var PageMessagingChromeDriver;
(function (PageMessagingChromeDriver) {
    PageMessagingChromeDriver.ExtensionNamespace = typeof browser != 'undefined' ? browser : chrome;
    PageMessagingChromeDriver.initialized;
    function bootstrap() {
        if (!this.initialized) {
            this.initialized = true;
            PageMessagingChromeDriver.ExtensionNamespace.runtime.onMessage.addListener(function (request) {
                window.parent.postMessage(request, "*");
            });
            window.addEventListener("message", function (message) {
                if (message.data && message.data.UBPMessageType === "UBPMessage") {
                    var messageToSend = {
                        type: "UBPExternalMessage.Sandbox",
                        payload: {
                            mType: message && message.data && message.data.type,
                            handle: -1,
                            data: message.data
                        }
                    };
                    PageMessagingChromeDriver.ExtensionNamespace.runtime.sendMessage(messageToSend);
                }
            });
        }
    }
    PageMessagingChromeDriver.bootstrap = bootstrap;
    PageMessagingChromeDriver.bootstrap.call(PageMessagingChromeDriver);
})(PageMessagingChromeDriver || (PageMessagingChromeDriver = {}));
