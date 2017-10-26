var ChromeActionPeerDriver;
(function (ChromeActionPeerDriver) {
    ChromeActionPeerDriver.ExtensionNamespace = typeof browser != 'undefined' ? browser : chrome;
    ChromeActionPeerDriver.initialized;
    ChromeActionPeerDriver.actionHandler = function (msg) {
        ChromeActionPeerDriver.ExtensionNamespace.runtime.sendMessage({
            type: "UBPExternalMessage.Action",
            payload: msg
        });
    };
    ChromeActionPeerDriver.library = new Action.ActionLibrary(document, ChromeActionPeerDriver.actionHandler);
    function getTime() {
        return (window.performance) ? window.performance.now() : Date.now();
    }
    ChromeActionPeerDriver.getTime = getTime;
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
    ChromeActionPeerDriver.handleMessage = handleMessage;
    function bootstrap() {
        if (!this.initialized) {
            this.initialized = true;
            ChromeActionPeerDriver.ExtensionNamespace.runtime.onMessage.addListener(this.handleMessage.bind(this));
        }
    }
    ChromeActionPeerDriver.bootstrap = bootstrap;
    ChromeActionPeerDriver.bootstrap.call(ChromeActionPeerDriver);
})(ChromeActionPeerDriver || (ChromeActionPeerDriver = {}));
