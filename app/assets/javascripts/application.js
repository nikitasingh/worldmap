// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){
    $('#index_table').dataTable();
});


$(function(){
    if($("#devise_notice").text() != ""){
        createDialog("<h3 class='heading3 alert-message'>"+ $("#devise_notice").text() +"</h3>");
        $("#devise_notice").remove();
    }
    if($("#devise_alert").text() != ""){
        createDialog("<h3 class='heading3 alert-message'>"+ $("#devise_alert").text() +"</h3>");
        $("#devise_alert").remove();
    }
    function createDialog( message) {
        $.colorbox({
            html : message,
            transition: 'fade',
            width: 600,
            height: 130,
            scrolling: false
        });
        setTimeout(function() {
            $.colorbox.close();
        }, 2000);
    }

});