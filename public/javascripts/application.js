// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
  $('#report-form').tabs();
});
$(function(){
  $('#link-form').tabs();
});
$(function(){
  $('#manage-list').tabs();
});
$(function(){
  $('#manage-account').tabs();
});
$(function(){
  $('div.navigation').css({
    'width' : '400px',
    'float' : 'left'
  });
  $('div.gallery_wrapper').css('display', 'block');
});
$(function(){
  $('#thumbs').galleriffic({
    imageContainerSel:      '#slideshow',
    controlsContainerSel:   '#controls'
  });
});


$(function() {
	$('a.advance-link').lightBox(); // Select all links in object with gallery ID
});


