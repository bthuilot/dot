var Style;
(function (Style) {
    var StyleLibrary = (function () {
        function StyleLibrary(_htmlDocument) {
            this._htmlDocument = _htmlDocument;
            this._apiMap = {
                "UBPStyleApply": this.applyStyle.bind(this),
                "UBPStyleReset": this.resetStyle.bind(this)
            };
        }
        StyleLibrary.prototype._generateStyleHandle = function () {
            return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
                var r = Math.random() * 16 | 0;
                var v = (c == 'x' ? r : (r & 0x3 | 0x8));
                return v.toString(16);
            });
        };
        StyleLibrary.prototype._getElement = function (elementCssSelector) {
            var element = this._htmlDocument.querySelector(elementCssSelector);
            if (!element) {
                throw new Error("StyleLibrary couldn't find the specified element.");
            }
            return element;
        };
        StyleLibrary.prototype.applyStyle = function (styleSpecfication) {
            if (!styleSpecfication || !styleSpecfication.elementCssSelector || !styleSpecfication.inlineCss) {
                throw new Error("StyleLibrary.applyStyle() requires elementCssSelector and inlineCss.");
            }
            var element = this._getElement(styleSpecfication.elementCssSelector);
            if (element.dataset["ubpStyleFinalized"]) {
                throw new Error("StyleLibrary.applyStyle() cannot apply style on a finalized element.");
            }
            element.dataset["ubpOldStyle"] = element.getAttribute("style") || "";
            var styleHandle = this._generateStyleHandle();
            element.dataset["ubpStyleHandle"] = styleHandle;
            element.setAttribute("style", [element.dataset["ubpOldStyle"], styleSpecfication.inlineCss].join("; "));
            if (styleSpecfication.finalize) {
                element.dataset["ubpStyleFinalized"] = styleHandle;
            }
            return styleHandle;
        };
        StyleLibrary.prototype.resetStyle = function (styleHandle) {
            var element = this._getElement("[data-ubp-style-handle='" + styleHandle + "']");
            var oldStyle = element.dataset["ubpOldStyle"];
            element.setAttribute("style", oldStyle);
            element.removeAttribute("data-ubp-style-finalized");
        };
        StyleLibrary.prototype.canHandle = function (requestType) {
            if (typeof this._apiMap[requestType] === "function") {
                return true;
            }
            else {
                return false;
            }
        };
        StyleLibrary.prototype.handle = function (requestType, payload) {
            if (!this.canHandle(requestType)) {
                throw new Error("StyleLibrary: Cannot handle " + requestType + ".");
            }
            return this._apiMap[requestType](payload);
        };
        return StyleLibrary;
    })();
    Style.StyleLibrary = StyleLibrary;
})(Style || (Style = {}));
