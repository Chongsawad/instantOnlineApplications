$('div.navigation').css({'width' : '300px', 'float' : 'left'});
$('div.content').css('display', 'block');

$(document).ready(function() {
  // Initialize Minimal Galleriffic Gallery
  $('#thumbs').galleriffic({
    imageContainerSel:      '#slideshow',
    controlsContainerSel:   '#controls'
  });
});