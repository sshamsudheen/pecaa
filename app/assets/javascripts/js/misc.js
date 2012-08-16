
	
	
	 function loadMap() {
	 	var addr_selector = arguments[0] === null ? '#misc_address' : '#'+arguments[0]+' #misc_address';
        var address = $(addr_selector).val();
	    var uri = "zoom=10&size="+arguments[1]+"&markers=color:blue|" + encodeURIComponent(address) + "&sensor=false";
	    var mapURL = "http://maps.googleapis.com/maps/api/staticmap?" + uri;
         var img_selector = arguments[0] === null ? '#map-canvas-image' : '#'+arguments[0]+' #map-canvas-image';
	    $(img_selector).attr('src', mapURL);
	 }
	
	 function initMisc() {
		$('#mapObj').css("left", "50px");
	    $('#mapObj').css("top", "30px");
	    $('#mapAddr').css("right", "50px");
	    $('#mapAddr').css("top", "30px");
        // init default configs
        var _div_id = null, _wh = '400x400';
        if (arguments.length) {
            _div_id = arguments[0];
              _wh = arguments[1];
        }
        // arguments are necessary for this method
	    loadMap(_div_id, _wh);
		$("#reloadMap").click(function(){
			loadMap();
			return false;
		});
	 }
	
	
