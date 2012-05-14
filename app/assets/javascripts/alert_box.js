$('.confirm_delete').click(function(){
  $("#alertBox_"+$(this).attr("rel")).show();
  return false;
});
$('.cancel_alert').click(function(){
  $("#alertBox_"+$(this).attr("rel")).hide();
  return false;
});
