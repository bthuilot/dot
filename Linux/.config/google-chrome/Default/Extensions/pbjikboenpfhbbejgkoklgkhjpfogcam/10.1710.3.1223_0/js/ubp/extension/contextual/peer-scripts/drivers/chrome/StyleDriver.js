var ChromeStylePeerDriver;
(function (ChromeStylePeerDriver) {
    ChromeStylePeerDriver.ExtensionNamespace = typeof browser != 'undefined' ? browser : chrome;
    ChromeStylePeerDriver.initialized;
    ChromeStylePeerDriver.library = new Style.StyleLibrary(document);
    function getTime() {
        return (window.performance) ? window.performance.now() : Date.now();
    }
    ChromeStylePeerDriver.getTime = getTime;
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
    ChromeStylePeerDriver.handleMessage = handleMessage;
    function bootstrap() {
        if (!this.initialized) {
            this.initialized = true;
            ChromeStylePeerDriver.ExtensionNamespace.runtime.onMessage.addListener(this.handleMessage.bind(this));
        }
    }
    ChromeStylePeerDriver.bootstrap = bootstrap;
    ChromeStylePeerDriver.bootstrap.call(ChromeStylePeerDriver);
})(ChromeStylePeerDriver || (ChromeStylePeerDriver = {}));
