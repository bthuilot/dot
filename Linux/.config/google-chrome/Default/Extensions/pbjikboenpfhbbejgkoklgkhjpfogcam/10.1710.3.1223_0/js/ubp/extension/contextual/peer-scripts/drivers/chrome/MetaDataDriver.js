var ChromeMetaDataDriver;
(function (ChromeMetaDataDriver) {
    ChromeMetaDataDriver.ExtensionNamespace = typeof browser != 'undefined' ? browser : chrome;
    ChromeMetaDataDriver.initialized;
    ChromeMetaDataDriver.library = new MetaDataLibrary.MetaData(window);
    function getTime() {
        return (window.performance) ? window.performance.now() : Date.now();
    }
    ChromeMetaDataDriver.getTime = getTime;
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
    ChromeMetaDataDriver.handleMessage = handleMessage;
    function bootstrap() {
        if (!this.initialized) {
            this.initialized = true;
            ChromeMetaDataDriver.ExtensionNamespace.runtime.onMessage.addListener(this.handleMessage.bind(this));
        }
    }
    ChromeMetaDataDriver.bootstrap = bootstrap;
    ChromeMetaDataDriver.bootstrap.call(ChromeMetaDataDriver);
})(ChromeMetaDataDriver || (ChromeMetaDataDriver = {}));
