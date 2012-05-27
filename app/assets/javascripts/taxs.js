$(document).ready(function() {
$("#tax_payment_eazy").live('click', function(){
  $("#custom_tax_gateway").hide();
  $("#easy_tax_gateway").show();
});

$("#tax_payment_custom").live('click', function(){
  $("#custom_tax_gateway").show();
  $("#easy_tax_gateway").hide();
});

$("#tax_gateway_attribute_location").live('change', function(){
  if(this.value == 'country'){
    $('#facebox #country_names').show();
    $('#facebox #state_names').hide();
    $('#facebox #zip_code').hide();
  }
  else if(this.value == 'state'){
    $('#facebox #country_names').hide();
    $('#facebox #state_names').show();
    $('#facebox #zip_code').hide();
  }
  else if(this.value == 'zip'){
    $('#facebox #country_names').hide();
    $('#facebox #state_names').hide();
    $('#facebox #zip_code').show();
  }

});
});