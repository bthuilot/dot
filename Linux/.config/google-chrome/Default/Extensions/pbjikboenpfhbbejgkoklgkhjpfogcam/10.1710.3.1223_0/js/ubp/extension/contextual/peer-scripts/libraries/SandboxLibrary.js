var SandboxLibrary;
(function (SandboxLibrary) {
    var Sandboxer = (function () {
        function Sandboxer(extensionMessageProxy) {
            this.sandboxMessagePrefix = "UBPSandboxer";
            this.sandboxManager = new SandboxLibrary.SandboxManager({
                strategy: new SandboxLibrary.IFrameCreationStrategy(),
                forwardMessageFunction: extensionMessageProxy,
                whitelistedOrigins: {}
            });
        }
        Sandboxer.prototype.sandboxMessageHandler = function (msg) {
            this.sandboxManager.sandboxMessageHandler(msg);
        };
        Sandboxer.prototype.handle = function (requestType, args) {
            if (!args) {
                throw new Error("Must provide arguments to Sandbox API's");
            }
            switch (requestType) {
                case this.sandboxMessagePrefix.concat("CreateSandbox"):
                    if (args.sandboxSpecification) {
                        return this.sandboxManager.createSandbox(args.sandboxSpecification);
                    }
                    break;
                case this.sandboxMessagePrefix.concat("ModifySandbox"):
                    if (args.sandboxId && args.sandboxCSSSpecification) {
                        return this.sandboxManager.modifySandbox(args.sandboxId, args.sandboxCSSSpecification);
                    }
                    break;
                case this.sandboxMessagePrefix.concat("DestroySandbox"):
                    if (args.sandboxId) {
                        return this.sandboxManager.destroySandbox(args.sandboxId);
                    }
                    break;
                case this.sandboxMessagePrefix.concat("AddWhitelistedOrigin"):
                    if (args.origin) {
                        return this.sandboxManager.addWhitelistedOrigin(args.origin);
                    }
                    break;
                case this.sandboxMessagePrefix.concat("SendMessageToSandbox"):
                    if (args.message) {
                        return this.sandboxManager.sendMessageToSandbox(args.sandboxId, args.message);
                    }
                    break;
                default:
                    throw new Error("Invalid request type: " + requestType);
            }
            throw new Error("Invalid args for sandbox message: " + requestType);
        };
        Sandboxer.prototype.canHandle = function (requestType) {
            switch (requestType) {
                case this.sandboxMessagePrefix.concat("CreateSandbox"):
                case this.sandboxMessagePrefix.concat("ModifySandbox"):
                case this.sandboxMessagePrefix.concat("DestroySandbox"):
                case this.sandboxMessagePrefix.concat("AddWhitelistedOrigin"):
                case this.sandboxMessagePrefix.concat("SendMessageToSandbox"):
                    return true;
                default:
                    return false;
            }
        };
        return Sandboxer;
    })();
    SandboxLibrary.Sandboxer = Sandboxer;
    var SandboxManager = (function () {
        function SandboxManager(args) {
            this.instanceId = randomInteger();
            this.pendingSandboxes = {};
            this.establishedSandboxes = {};
            if (args.strategy) {
                this.strategy = args.strategy;
            }
            else {
                throw new Error("SandboxManager requires a notification creation strategy");
            }
            this.forwardMessageFunction = args.forwardMessageFunction || function () {
            };
            this.whitelistedOrigins = args.whitelistedOrigins || {};
        }
        SandboxManager.prototype.sandboxMessageHandler = function (msg) {
            if (!this._isRelevantMessage(msg)) {
                return;
            }
            msg = msg;
            if (this._isHandshakeMessage(msg)) {
                this._handleHandshake(msg);
            }
            else {
                this._handleMessage(msg);
            }
        };
        SandboxManager.prototype.createSandbox = function (sandboxSpec) {
            var targetUrl = sandboxSpec.url, proxyUrl = sandboxSpec.proxy, cssSpec = sandboxSpec.sandboxCSSSpecification;
            if (!(targetUrl && proxyUrl)) {
                throw new Error("Must provide both proxy and target url to createSandbox");
            }
            var handle = this._generateSandboxHandle();
            if (targetUrl.match(/[&\?]ubpSandboxHandle=/)) {
                throw new Error("target URL already contains a reserved query string key: ubpSandboxHandle");
            }
            targetUrl = appendQueryParams(targetUrl, {
                "ubpSandboxHandle": "1"
            });
            if (proxyUrl.match(/[&\?]target=/)) {
                throw new Error("proxy URL already contains a reserved query string key: target");
            }
            proxyUrl = appendQueryParams(proxyUrl, {
                "ubpSandboxHandle": handle,
                "target": targetUrl
            });
            this.strategy.createSandbox(handle, proxyUrl, cssSpec);
            this.pendingSandboxes[handle] = true;
            var origin = this.strategy.grokOrigin(proxyUrl);
            if (origin) {
                this.addWhitelistedOrigin(origin);
            }
            return handle;
        };
        SandboxManager.prototype.modifySandbox = function (handle, sandboxCSSSpecification) {
            this.strategy.modifySandbox(handle, sandboxCSSSpecification);
        };
        SandboxManager.prototype.destroySandbox = function (handle) {
            delete this.pendingSandboxes[handle];
            delete this.establishedSandboxes[handle];
            this.strategy.destroySandbox(handle);
        };
        SandboxManager.prototype.addWhitelistedOrigin = function (origin) {
            this.whitelistedOrigins[origin] = origin;
        };
        SandboxManager.prototype.sendMessageToSandbox = function (handle, message) {
            this.strategy.sendMessageToSandbox(handle, message);
        };
        SandboxManager.prototype._handleMessage = function (msg) {
            this.forwardMessageFunction(msg.data);
        };
        SandboxManager.prototype._handleHandshake = function (msg) {
            var handle = msg.data.handle;
            this.establishedSandboxes[handle] = msg.source;
            delete this.pendingSandboxes[handle];
        };
        SandboxManager.prototype._isValidOrigin = function (origin) {
            return !!this.whitelistedOrigins[origin];
        };
        SandboxManager.prototype._isRelevantMessage = function (msg) {
            return !!(msg && msg.source && msg.data && msg.data.mType && msg.data.handle && this._isValidOrigin(this.strategy.grokOrigin(msg.origin)));
        };
        SandboxManager.prototype._isHandshakeMessage = function (msg) {
            return msg.data.mType === SandboxManager.SANDBOX_HANDSHAKE;
        };
        SandboxManager.prototype._generateSandboxHandle = function () {
            return SandboxManager.SANDBOX_PREFIX + "_iid=" + this.instanceId + "_sid=" + randomInteger() + "_time=" + Date.now();
        };
        SandboxManager.SANDBOX_HANDSHAKE = "UBPSandboxHandshake";
        SandboxManager.SANDBOX_PREFIX = "UBPNotif";
        return SandboxManager;
    })();
    SandboxLibrary.SandboxManager = SandboxManager;
    var IFrameCreationStrategy = (function () {
        function IFrameCreationStrategy() {
            this._defaultCSSRules = {
                "background": "transparent",
                "border": "0",
                "box-shadow": "none",
                "display": "block",
                "height": "0px",
                "left": "0",
                "overflow-x": "visible",
                "overflow-y": "visible",
                "padding": "0",
                "position": "absolute",
                "right": "auto",
                "top": "0",
                "width": "0px",
                "z-index": "99999"
            };
        }
        IFrameCreationStrategy.prototype.grokOrigin = function (url) {
            var a = document.createElement("a");
            a.href = url;
            return (a.protocol + "//" + a.host).toLowerCase();
        };
        IFrameCreationStrategy.prototype.createSandbox = function (handle, proxyUrl, cssSpec) {
            var sandbox = document.createElement("iframe");
            sandbox.style.cssText = this._buildCssString(this._defaultCSSRules).concat(this._buildCssString(cssSpec));
            sandbox.src = proxyUrl;
            sandbox.setAttribute("id", handle);
            document.body.appendChild(sandbox);
        };
        IFrameCreationStrategy.prototype.modifySandbox = function (handle, cssSpec) {
            var sandbox = document.getElementById(handle);
            if (!sandbox) {
                throw new Error("Cannot modify sandbox; wasn't found");
            }
            sandbox.style.cssText += this._buildCssString(cssSpec);
        };
        IFrameCreationStrategy.prototype.sendMessageToSandbox = function (handle, message) {
            var sandbox = document.getElementById(handle);
            if (!sandbox || !sandbox.contentWindow) {
                throw new Error("Cannot send message to sandbox; Sandbox with id: '" + handle + "' is not valid");
            }
            try {
                sandbox.contentWindow.postMessage(message, "*");
            }
            catch (e) {
                var error = new Error("Error while sending message to sandbox: " + e);
                console.log(error.message, e);
                throw error;
            }
        };
        IFrameCreationStrategy.prototype.destroySandbox = function (handle) {
            var sandbox = document.getElementById(handle);
            if (sandbox !== null && sandbox.parentNode !== null) {
                sandbox.parentNode.removeChild(sandbox);
            }
        };
        IFrameCreationStrategy.prototype._buildCssString = function (cssSpec) {
            var styleRulesArray = [];
            for (var styleName in cssSpec) {
                if (cssSpec.hasOwnProperty(styleName)) {
                    styleRulesArray.push([styleName, cssSpec[styleName]].join(":"));
                }
            }
            return styleRulesArray.join(";").concat(";");
        };
        return IFrameCreationStrategy;
    })();
    SandboxLibrary.IFrameCreationStrategy = IFrameCreationStrategy;
    var MAX_SAFE_INTEGER = Number["MAX_SAFE_INTEGER"] || 9007199254740991;
    var MIN_SAFE_INTEGER = Number["MIN_SAFE_INTEGER"] || -9007199254740991;
    var USE_SIGN_BIT = (MAX_SAFE_INTEGER * -1) === MIN_SAFE_INTEGER;
    function randomInteger() {
        var randomInteger = Math.floor(Math.random() * MAX_SAFE_INTEGER);
        if (USE_SIGN_BIT) {
            var heads = Math.floor(Math.random() * 2);
            if (heads) {
                randomInteger *= -1;
            }
        }
        return randomInteger.toString();
    }
    function appendQueryParams(url, params) {
        var sourceUrl = "", queryString = "", urlhash = "";
        for (var key in params) {
            if (params.hasOwnProperty(key)) {
                queryString += "&" + encodeURIComponent(key) + "=" + encodeURIComponent(params[key]);
            }
        }
        if (url.indexOf('#') > 0) {
            var cl = url.indexOf('#');
            urlhash = url.substring(url.indexOf('#'), url.length);
        }
        else {
            urlhash = '';
            cl = url.length;
        }
        sourceUrl = url.substring(0, cl);
        if (sourceUrl.indexOf("?") > -1) {
            if (sourceUrl.charAt(sourceUrl.length - 1) === "&" || sourceUrl.charAt(sourceUrl.length - 1) === "?") {
                queryString = queryString.slice(1);
            }
        }
        else {
            queryString = "?" + queryString.slice(1);
        }
        return sourceUrl + queryString + urlhash;
    }
    SandboxLibrary.appendQueryParams = appendQueryParams;
})(SandboxLibrary || (SandboxLibrary = {}));
