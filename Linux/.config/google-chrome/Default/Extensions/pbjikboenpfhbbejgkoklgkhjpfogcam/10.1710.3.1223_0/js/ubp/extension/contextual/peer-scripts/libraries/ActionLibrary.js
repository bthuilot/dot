var Action;
(function (Action) {
    var ActionLibrary = (function () {
        function ActionLibrary(_htmlDocument, _actionHandler) {
            this._htmlDocument = _htmlDocument;
            this._actionHandler = _actionHandler;
            this._actionListeners = {};
            this._apiMap = {
                "UBPActionRegister": this.register.bind(this),
                "UBPActionDeregister": this.deregister.bind(this)
            };
        }
        ActionLibrary.prototype._generateActionListenerId = function () {
            return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
                var r = Math.random() * 16 | 0;
                var v = (c == 'x' ? r : (r & 0x3 | 0x8));
                return v.toString(16);
            });
        };
        ActionLibrary.prototype._generateActionListener = function (actionListenerId, eventName) {
            var self = this;
            return function () {
                self._actionHandler({
                    actionListenerId: actionListenerId,
                    eventName: eventName
                });
            };
        };
        ActionLibrary.prototype._getElement = function (elementCssSelector) {
            var element = this._htmlDocument.querySelector(elementCssSelector);
            if (!element) {
                throw new Error("ActionLibrary.register() couldn't find the specified element.");
            }
            return element;
        };
        ActionLibrary.prototype.register = function (actionSpecification) {
            if (!actionSpecification || !actionSpecification.elementCssSelector || !actionSpecification.eventName) {
                throw new Error("ActionLibrary.register() requires elementCssSelector and eventName.");
            }
            var element = this._getElement(actionSpecification.elementCssSelector);
            var actionListenerId = this._generateActionListenerId();
            var actionListener = this._generateActionListener(actionListenerId, actionSpecification.eventName);
            if (typeof element.addEventListener !== "function") {
                throw new Error("ActionListener.register() couldn't add action listener to the specified element.");
            }
            element.addEventListener(actionSpecification.eventName, actionListener);
            this._actionListeners[actionListenerId] = {
                element: element,
                listener: actionListener,
                eventName: actionSpecification.eventName
            };
            return actionListenerId;
        };
        ActionLibrary.prototype.deregister = function (actionListenerId) {
            var actionListener = this._actionListeners[actionListenerId];
            if (actionListener) {
                actionListener.element.removeEventListener(actionListener.eventName, actionListener.listener);
            }
            else {
                throw new Error("ActionLibrary.deregister() couldn't remove action listener for the specified actionListenerId.");
            }
            delete this._actionListeners[actionListenerId];
        };
        ActionLibrary.prototype.canHandle = function (requestType) {
            if (typeof this._apiMap[requestType] === "function") {
                return true;
            }
            else {
                return false;
            }
        };
        ActionLibrary.prototype.handle = function (requestType, payload) {
            if (!this.canHandle(requestType)) {
                throw new Error("ActionLibrary: Cannot handle " + requestType + ".");
            }
            return this._apiMap[requestType](payload);
        };
        return ActionLibrary;
    })();
    Action.ActionLibrary = ActionLibrary;
})(Action || (Action = {}));
