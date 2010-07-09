// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
  $('#tabs').tabs();
});
$(function(){
  $('#site-form').tabs();
});
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
    'width' : '300px',
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

jQuery().ready(function(){
  // simple accordion
  jQuery('#list1a').accordion();
});
//$(function() {
//  $("#navigation").accordion({
//    active: false,
//    navigation: true,
//    header: '.head',
//    event: 'mouseover'
//  });
//});