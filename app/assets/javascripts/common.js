//= require tinymce-jquery
$(document).ready(function() {
  $('a[rel*=facebox]').facebox({
  loadingImage : '/assets/loading.gif',
  closeImage   : '/assets/btn_deleteUser_active.png'
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

  $("#enable_is_enable").live('click', function(){
    $(this).attr("class", "off");
    $(this).attr("id", "disable_is_enable");
    $("#shipping_gateway_attribute_is_enable").attr("value", 0);
  });

  $("#addFlatBtn").live('click', function(){    
    $(category_main[0]).insertAfter(".categoryMain");
  });

  $("#addWeightBtn").live('click', function(){
    $(category_main_weight[0]).insertAfter(".categoryMainWeight");
  });


  $("#disable_is_enable").live('click',function(){
    $(this).attr("class", "on");
    $("#shipping_gateway_attribute_is_enable").attr("value", 1);
    $(this).attr("id", "enable_is_enable");
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

  $("#flat_shipping_rate_flat_rate").live('click',function(){
    $("#flat_rate_option").show();
    $("#weight_rate_option").hide();
  });

  $("#flat_shipping_rate_weight_rate").live('click',function(){
    $("#flat_rate_option").hide();
    $("#weight_rate_option").show();
  });



//  $(function() {
//    $('textarea').tinymce({
//      width: "98%",
//      height: "50%",
//      theme: 'advanced'
//    });
//  });
})

