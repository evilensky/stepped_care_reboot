$(document).ready(function(ev){

	var ver_top = ($(window).height() - $("#container").height()) / 2;
	$('#container').css( "margin-top", ver_top+'px' );

	$(window).resize(function(){
		var ver_top = ($(window).height() - $("#container").height()) / 2;
		$('#container').css( "margin-top", ver_top+'px' );
		});
});