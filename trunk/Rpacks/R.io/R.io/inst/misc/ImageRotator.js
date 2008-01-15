// This script has successfully been tested on:
//   Internet Explorer v6.0
//   Netscape Navigator v4.0, v6.0, v6.2
//   Opera v4.02
// It does not work for:
//   Netscape Navigator 3.02
// Other unknown!
function preloadImages() {
  var i, k, args;

  if(document.images) {
    // Create buffer if non-existing
 	  if(!document.buffer)
  	  document.buffer=new Array();

    // Load all images to the end of the buffer
    args=preloadImages.arguments;
    k = document.buffer.length;
  	for(i=0; i < args.length; i++) {
      document.buffer[k] = new Image;
      document.buffer[k].src = args[i];
      k = k + 1;
  	}
  }
}

function changeImage() {
  var args;
  args = changeImage.arguments;
  img = findImage(args[0]);
  img.src = args[1];
}


function findImage(name) {
  var i, img;

  // Search 'document' then 'document.all'
  img = document[name];
  if (img) return img;

  if(document.all) {
    img = document.all[name];
    if (img) return img;
  }

  // Finally, search any layers for the image
  for(i=0; document.layers && i < document.layers.length; i++) {
    img = findImage(name, document.layers[i].document); 
    if (img) return img;
  }

  return img;
}
