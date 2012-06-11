$('.confirm_delete').click(function(){
  $("#alertBox_"+$(this).attr("rel")).show();
  return false;
});
$('.cancel_alert').click(function(){
  $("#alertBox_"+$(this).attr("rel")).hide();
  return false;
});

function editor_options(){
  return {
      type      : "text",
      width     : '120px',
      height    : '15px',
      tooltip   : 'Click to edit...',
      onsubmit  : function(){}
  }
}

function get_Inline_editors_ready(klassname, edittext_url){  
  $(klassname).editable(edittext_url,  editor_options());
}
