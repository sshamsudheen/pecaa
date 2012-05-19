//= require tinymce-jquery
$(document).ready(function() {
  $('a[rel*=facebox]').facebox({
  loadingImage : '/assets/loading.gif'
  //closeImage   : '/assets/closelabel.png'
  })

  $(".btnCancel").live('click', function(){
    $("#facebox").hide()
    $("#facebox_overlay").hide()      
  })
  
  $(".btnCancelForm").live('click', function(){
    $("#facebox").hide()
    $("#facebox_overlay").hide()
  })

  $("#enable_is_test_mode").live('click', function(){
    $(this).attr("class", "off");
    $(this).attr("id", "disable_is_test_mode");
    $("#site_payment_gateway_is_test_mode").attr("value", 0);
  });

  $("#disable_is_test_mode").live('click',function(){
    $(this).attr("class", "on");
    $("#site_payment_gateway_is_test_mode").attr("value", 1);
    $(this).attr("id", "enable_is_test_mode");
  });

  $("#enable_authorize_funds_only").live('click', function(){
    $(this).attr("class", "off");
    $(this).attr("id", "disable_authorize_funds_only");
    $("#site_payment_gateway_authorize_funds_only").attr("value", 0);
  });

  $("#disable_authorize_funds_only").live('click',function(){
    $(this).attr("class", "on");
    $("#site_payment_gateway_authorize_funds_only").attr("value", 1);
    $(this).attr("id", "enable_authorize_funds_only");
  });

  $("#enable_is_cvv").live('click', function(){
    $(this).attr("class", "off");
    $(this).attr("id", "disable_is_cvv");
    $("#site_payment_gateway_is_cvv").attr("value", 0);
  });

  $("#disable_is_cvv").live('click',function(){
    $(this).attr("class", "on");
    $("#site_payment_gateway_is_cvv").attr("value", 1);
    $(this).attr("id", "enable_is_cvv");
  });




//  $(function() {
//    $('textarea').tinymce({
//      width: "98%",
//      height: "50%",
//      theme: 'advanced'
//    });
//  });
})

