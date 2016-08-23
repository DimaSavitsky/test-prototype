// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.countdown.min
//= require jquery.jscrollpane.min
//= require jquery.mousewheel
//= require tether
//= require bootstrap
//= require jquery_ujs
//= require jquery-ui
//= require turbolinks
//= require cocoon
//= require_tree .

var ready;
ready = function() {

  $('[data-countdown]').each(function() {
    var $this = $(this), finalDate = $(this).data('countdown');
    $this.countdown(finalDate, function(event) {
      $this.html(event.strftime('%M:%S'));
    });
  });
  
  $('.scroll-pane').jScrollPane();

  $('#open-instructions').click(function(event){
    event.preventDefault();
    $('#test-instructions').show(500);
    $('.under-modal').html( '<a href="#instructions" id="close-instructions">Close Instructions</a>' );
  });

  $('#close-instructions').click(function(event){
    event.preventDefault();
    $('#test-instructions').hide(500);
    $('.under-modal').html( '<a href="#instructions" id="open-instructions">Close Instructions</a><a href="/tests">Cancel</a>' );
  });
  
  
  window_width = $(window).width();
  window_height = $(window).height();
  reinitTable();
  
  $(window).on('resize',function(){
    window_width = $(window).width();
    window_height = $(window).height();
    reinitTable();
  });
  
  function reinitTable(){
    tableFix = (window_width - 950) / 2;
    $('.table-padding').css('width',tableFix);
    $('.ui-tooltip').css('left',tableFix,'important');
  };  

  $('[data-toggle="tooltip"]').tooltip({
    position: { my: 'left bottom-20', at: 'left top'}
  });
  
};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);




