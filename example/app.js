var win = Ti.UI.createWindow({
  layout: 'vertical',
	backgroundColor:'white'
});
win.open();

var TiCustomPasteboard = require('jp.hsj.ticustompasteboard');
Ti.API.info("module is => " + TiCustomPasteboard);
var pb = 'yay.my.pb';

if (Ti.Platform.name != "android") {
  var button = Ti.UI.createButton({
    top: 50,
    title: 'open photo gallery',
    width: Ti.UI.SIZE,
    height: Ti.UI.SIZE
  });
  win.add(button);
  var imageButton = Ti.UI.createButton({
    top: 50,
    title: 'get image',
    width: Ti.UI.SIZE,
    height: Ti.UI.SIZE
  });
  win.add(imageButton);
  button.addEventListener('click', function(){
    Ti.Media.openPhotoGallery({
      success: function(e){
        TiCustomPasteboard.createPasteboard(pb);
        TiCustomPasteboard.setImage(pb, e.media);
      }
    });
  });
  imageButton.addEventListener('click', function(){
    var blob = TiCustomPasteboard.getImage(pb);
    win.add(Ti.UI.createImageView({image: blob, top: 20}));
  });
}

