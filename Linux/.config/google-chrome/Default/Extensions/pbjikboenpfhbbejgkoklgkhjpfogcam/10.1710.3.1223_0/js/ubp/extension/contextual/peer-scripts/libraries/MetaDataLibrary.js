var MetaDataLibrary;
(function (MetaDataLibrary) {
    var MetaData = (function () {
        function MetaData(_window) {
            this._window = _window;
            this._apiMap = {
                "UBPMetaDataGetPageReferrer": this.getPageReferrer.bind(this),
                "UBPMetaDataGetPageLocationData": this.getPageLocationData.bind(this),
                "UBPMetaDataGetPagePerformanceTimingData": this.getPagePerformanceTimingData.bind(this),
                "UBPMetaDataGetPageDimensionData": this.getPageDimensionData.bind(this)
            };
        }
        MetaData.prototype.canHandle = function (requestType) {
            return (typeof this._apiMap[requestType]) === "function";
        };
        MetaData.prototype.handle = function (requestType, payload) {
            if (!this.canHandle(requestType)) {
                throw new Error("MetaDataLibrary: Cannot handle " + requestType + ".");
            }
            return this._apiMap[requestType](payload);
        };
        MetaData.prototype.getPageReferrer = function () {
            return this._window && this._window.document && this._window.document.referrer || "";
        };
        MetaData.prototype.getPageLocationData = function () {
            return this._window && this._window.location && {
                url: this._window.location.href,
                hostname: this._window.location.hostname,
                path: this._window.location.pathname,
                protocol: this._window.location.protocol
            } || {};
        };
        MetaData.prototype.getPagePerformanceTimingData = function () {
            return this._window && this._window.performance && this._window.performance.timing && (this._window.performance.timing.toJSON() || JSON.parse(JSON.stringify(new Object(this._window.performance.timing)))) || {};
        };
        MetaData.prototype.getPageDimensionData = function () {
            return this._window && {
                outerHeight: this._window.outerHeight,
                outerWidth: this._window.outerWidth,
                innerHeight: this._window.innerHeight,
                innerWidth: this._window.innerWidth
            } || {};
        };
        return MetaData;
    })();
    MetaDataLibrary.MetaData = MetaData;
})(MetaDataLibrary || (MetaDataLibrary = {}));
