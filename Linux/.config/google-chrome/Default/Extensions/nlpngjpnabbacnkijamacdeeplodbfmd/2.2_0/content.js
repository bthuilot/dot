var aoun = false;
var url = "https://rawgit.com/kylesferrazza/aounify/master/img/";
var numImages = 10;

function getRandomImgUrl() {
  return url + Math.floor(Math.random() * numImages) + ".jpg";
}

function changeImgSrc(img) {
  img.src = getRandomImgUrl();
  img.attributes.src = getRandomImgUrl();
}

function operateWithinFrame(tagName) {
  var frames = document.getElementsByTagName(tagName);
  for (var i = 0; i < frames.length; i++) {
    var img = frames[i].contentDocument.getElementsByTagName("img");
    operateOnList(imgs);
  }
}

function operateOnList(elems) {
  for (var i = 0; i < elems.length; i++) {
    changeImgSrc(elems[i]);
  }
}

chrome.runtime.onMessage.addListener(
  function(request, sender, sendResponse) {
    if( request.message === "clicked_browser_action" ) {
      aoun = !aoun;
      if (aoun) {
        var allImgs = document.getElementsByTagName("img");
        operateOnList(allImgs);
        operateWithinFrame("frame");
        operateWithinFrame("iframe");
      }
    }
  }
);
