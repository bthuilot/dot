var ChromeSandboxPeerDriver;
(function (ChromeSandboxPeerDriver) {
    ChromeSandboxPeerDriver.ExtensionNamespace = typeof browser != 'undefined' ? browser : chrome;
    ChromeSandboxPeerDriver.initialized;
    ChromeSandboxPeerDriver.library = new SandboxLibrary.Sandboxer(function (msg) {
        ChromeSandboxPeerDriver.ExtensionNamespace.runtime.sendMessage({
            type: "UBPExternalMessage.Sandbox",
            payload: msg
        });
    });
    function getTime() {
        return (window.performance) ? window.performance.now() : Date.now();
    }
    ChromeSandboxPeerDriver.getTime = getTime;
    function createNewResponse(messageId) {
        return {
            msgId: messageId,
            error: undefined,
            payload: undefined,
            performanceTiming: {
                requestStart: undefined,
                requestEnd: undefined
            }
        };
    }
    function handleMessage(request, sender, sendResponse) {
        if (request && this.library.canHandle(request.type)) {
            var response = createNewResponse(request.msgId);
            try {
                response.performanceTiming.requestStart = this.getTime();
                response.payload = this.library.handle(request.type, request.payload);
                response.performanceTiming.requestEnd = this.getTime();
            }
            catch (e) {
                response.error = e;
            }
            finally {
                sendResponse(response);
            }
        }
    }
    ChromeSandboxPeerDriver.handleMessage = handleMessage;
    function bootstrap() {
        if (!this.initialized) {
            this.initialized = true;
            ChromeSandboxPeerDriver.ExtensionNamespace.runtime.onMessage.addListener(this.handleMessage.bind(this));
            window.addEventListener("message", function () {
                ChromeSandboxPeerDriver.library.sandboxMessageHandler.apply(ChromeSandboxPeerDriver.library, arguments);
            });
        }
    }
    ChromeSandboxPeerDriver.bootstrap = bootstrap;
    ChromeSandboxPeerDriver.bootstrap.call(ChromeSandboxPeerDriver);
})(ChromeSandboxPeerDriver || (ChromeSandboxPeerDriver = {}));
