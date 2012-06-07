$(document).ready(function() {
	$(".ConLibra li:even").addClass("alt");
})

function validateScroll(tblId, tblHeight){
	var $tbl = $('#'+tblId), tH = tblHeight;
	if($tbl.length) {
		if($tbl.find('.ConLibra').height() >= tH) {
			$tbl.find('.scrollbar').show();
			$tbl.find('.overview').css('position', 'absolute');
			$tbl.find('.viewport').height(tH);
			$tbl.find('ul.ConLibra').css('border-right', '0');
			$tbl.tinyscrollbar();
			$('#shadow').show();
		} else {
			$tbl.find('.overview').css('position', 'relative');
			$tbl.find('.scrollbar').hide();
			$('#shadow').hide();
		}
	}
}
