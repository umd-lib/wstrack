var layer;
var floor1,floor2,floor3,floor4,floor5,floor6,floor7,floor8;

$(document).ready(function() {	
	var stage = new Kinetic.Stage({
	    container: 'mapCanvas',
	    height: 600,
	    width: 960,
	    id : 'myCanvas'
	});
	
	layer = new Kinetic.Layer({draggable: true});
	
	var count = 8;
	var loaded = function() {
		count--;
		if(count === 0) {
			floor1 = new Kinetic.Image({
			    image: floor1Image,
			    scale : .20
			});
			floor2 = new Kinetic.Image({
			    image: floor2Image,
			    scale : .20,
			    x : 210
			});
			floor3 = new Kinetic.Image({
			    image: floor3Image,
			    scale : .20,
			    x : 420
			});
			floor4 = new Kinetic.Image({
			    image: floor4Image,
			    scale : .20,
			    x : 630
			});
			floor5 = new Kinetic.Image({
			    image: floor5Image,
			    scale : .20,
			    y : 310
			});
			floor6 = new Kinetic.Image({
			    image: floor6Image,
			    scale : .20,
			    x : 210,
			    y : 310
			});
			floor7 = new Kinetic.Image({
			    image: floor7Image,
			    scale : .20,
			    x : 420,
			    y : 310
			});
			floor8 = new Kinetic.Image({
			    image: floor8Image,
			    scale : .20,
			    x : 630,
			    y : 310
			});
			layer.add(floor1);
			layer.add(floor2);
			layer.add(floor3);
			layer.add(floor4);
			layer.add(floor5);
			layer.add(floor6);
			layer.add(floor7);
			layer.add(floor8);
			stage.add(layer);
		}
	};
	
	var floor1Image = new Image();
	floor1Image.onload = loaded;
	floor1Image.src = 'images/mckeldin_fl1.jpg';
	
	var floor2Image = new Image();
	floor2Image.onload = loaded;
	floor2Image.src = 'images/mckeldin_fl2.jpg';	
	
	var floor3Image = new Image();
	floor3Image.onload = loaded;
	floor3Image.src = 'images/mckeldin_fl3.jpg';	
	
	var floor4Image = new Image();
	floor4Image.onload = loaded;
	floor4Image.src = 'images/mckeldin_fl4.jpg';	
	
	var floor5Image = new Image();
	floor5Image.onload = loaded;
	floor5Image.src = 'images/mckeldin_fl5.jpg';
	
	var floor6Image = new Image();
	floor6Image.onload = loaded;
	floor6Image.src = 'images/mckeldin_fl6.jpg';	
	
	var floor7Image = new Image();
	floor7Image.onload = loaded;
	floor7Image.src = 'images/mckeldin_fl7.jpg';	
	
	var floor8Image = new Image();
	floor8Image.onload = loaded;
	floor8Image.src = 'images/mckeldin_fl8.jpg';	
	
	// add the layer to the stage
	stage.add(layer);

	ui.stage = stage;
	$(stage.content).on('mousewheel', ui.zoom);
});

var ui = {
	    stage: null,
	    scale: 1,
	    zoomFactor: 1.1,
	    origin: {
	        x: 0,
	        y: 0
	    },
	    zoom: function(event) {
	        event.preventDefault();
	        var evt = event.originalEvent,
	            mx = evt.clientX /* - canvas.offsetLeft */,
	            my = evt.clientY /* - canvas.offsetTop */,
	            wheel = evt.wheelDelta / 120;
	        var zoom = (ui.zoomFactor - (evt.wheelDelta < 0 ? 0.2 : 0));
	        var newscale = ui.scale * zoom;
	        ui.origin.x = mx / ui.scale + ui.origin.x - mx / newscale;
	        ui.origin.y = my / ui.scale + ui.origin.y - my / newscale;
	        ui.stage.setOffset(ui.origin.x, ui.origin.y);
	        ui.stage.setScale(newscale,newscale);
	        ui.stage.draw();

	        ui.scale *= zoom;
	    }
	};
