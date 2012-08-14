
	
	
	 function loadMap() {
	 	var address = $("#misc_address").val();
	    var uri = "zoom=10&size=400x400&markers=color:blue|" + encodeURIComponent(address) + "&sensor=false";
	    var mapURL = "http://maps.googleapis.com/maps/api/staticmap?" + uri; //encodeURIComponent(uri); 
	    $("#map-canvas-image").attr('src', mapURL);
	}
	
	  function initMisc() {
		$('#mapObj').css("left", "50px");
	    $('#mapObj').css("top", "30px");
	    $('#mapAddr').css("right", "50px");
	    $('#mapAddr').css("top", "30px");
	    loadMap();
		$("#reloadMap").click(function(){
			loadMap();
			return false;
		});	
		
	}
	
	
