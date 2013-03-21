$(document).ready(function() {
	$("#deleteRecords").click(function (e, confirmed) {
		e.preventDefault();
		var recCount= $('#totalEntries').attr('title');
		if(recCount !== undefined && recCount === "1") {
			$("#dialog-confirm-rec-message").text("Record will be permanently deleted and cannot be recovered. Are you sure?");
		} else {
			$("#dialog-confirm-rec-message").text("Records will be permanently deleted and cannot be recovered. Are you sure?");
		}
		$("#dialog-confirm-rec-count").text(recCount);
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
