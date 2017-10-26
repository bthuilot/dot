var GetUWLItemChromeDriver;
(function (GetUWLItemChromeDriver) {
    GetUWLItemChromeDriver.ExtensionNamespace = typeof browser != 'undefined' ? browser : chrome;
    GetUWLItemChromeDriver.initialized;
    GetUWLItemChromeDriver.library = new GetUWLItemLibrary.GetUWLItem(document);
    function getTime() {
        return (window.performance) ? window.performance.now() : Date.now();
    }
    GetUWLItemChromeDriver.getTime = getTime;
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
                response.payload = this.library.handle(request.payload);
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
    GetUWLItemChromeDriver.handleMessage = handleMessage;
    function bootstrap() {
        if (!this.initialized) {
            this.initialized = true;
            GetUWLItemChromeDriver.ExtensionNamespace.runtime.onMessage.addListener(this.handleMessage.bind(this));
        }
    }
    GetUWLItemChromeDriver.bootstrap = bootstrap;
    GetUWLItemChromeDriver.bootstrap.call(GetUWLItemChromeDriver);
})(GetUWLItemChromeDriver || (GetUWLItemChromeDriver = {}));
