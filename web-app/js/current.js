$(document).ready(function() {
	$("#deleteRecords").click(function (e, confirmed) {
		e.preventDefault();
		$( "#dialog-confirm" ).dialog("open");
	});
	$("#dialog-confirm").dialog({
		resizable : false,
		height : 200,
		width : 350,
		modal : true,
		autoOpen : false,
		buttons : {
			"Delete all Records" : function( event, ui ) {
				$(this).dialog("close");
				var hrefUrl= $('#deleteRecords').attr('href');
				window.location.replace(hrefUrl);
			},
			Cancel : function(event, ui ) {
				$(this).dialog("close");
			}
		}
	});
});
