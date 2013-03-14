$(document).ready(function() {
	$("#exportDialog").dialog({
		height : 557,
		width : 557,
		title : "Export CSV",
		autoOpen : false,
		draggable : true,
		show : {
			effect : "blind",
			duration : 1000
		},
		hide : {
			effect : "blind",
			duration : 1000
		}
	});
	$("#exportLink").click(function() {
		$("#exportDialog").dialog("open");
	});
});