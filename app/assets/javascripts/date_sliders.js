$(document).ready(function(){
	$('#scrollbar1 span.name a.links').each(function(i,n){
		var nT = $.trim($(this).text()).substring(0, 17);
		if($.trim($(this).text()).length > 20) $(this).html(nT+'...');
	});

      $( '#dteRange' ).slider({
          range: true,
          min: 1,
          max: 31,
          values: [ 7, 16 ],
          slide: function( event, ui ) {
              // calculate the date range
              var dt = new Date(),
                  _y = dt.getFullYear(),
                  _m = dt.getMonth()+1;
              // now to display it
              $('.rangedisplay .dte_from').html('From: '+_m+'/'+ui.values[0]+'/'+_y);
              $('.rangedisplay .dte_to').html('To: '+_m+'/'+ui.values[1]+'/'+_y);
              // now save it for manipulation
              $('#last_edited_from').attr('value',_y+'-'+_m+'-'+ui.values[0]);
              $('#last_edited_to').attr('value',_y+'-'+_m+'-'+ui.values[1]);
          }
      });

      $( '#dtcRange' ).slider({
          range: true,
          min: 1,
          max: 31,
          values: [ 7, 16 ],
          slide: function( event, ui ) {
              // calculate the date range
              var dt = new Date(),
                      _y = dt.getFullYear(),
                      _m = dt.getMonth()+1;
              // now to display it
              $('.rangedisplay .dtc_from').html('From: '+_m+'/'+ui.values[0]+'/'+_y);
              $('.rangedisplay .dtc_to').html('To: '+_m+'/'+ui.values[1]+'/'+_y);
              // now save it for manipulation
              $('#date_created_from').attr('value',_y+'-'+_m+'-'+ui.values[0]);
              $('#date_created_to').attr('value',_y+'-'+_m+'-'+ui.values[1]);
          }
      });
  })