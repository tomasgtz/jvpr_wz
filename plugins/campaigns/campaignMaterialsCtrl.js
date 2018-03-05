/**
 * @ngdoc function
 * @name newappApp.controller:campaignMaterialsCtrl
 * @description
 * # campaignMaterialsCtrl
 * Controller of the newappApp
 */
 
var urlHostEmpresas = 'https://empresas.wizad.mx/';


angular.module('newApp')
  .controller('campaignMaterialsCtrl', function ($scope, CanvasFactory, ngDialog, $rootScope, $timeout, ngDragDrop, ImagesFactory, UtilsFactory, AppSettings, campaignService, objCampaign , $location) {

	$scope.CampaignSelected =  {

				"id_campaign" 	: "",
				"description" 	: "",
				"name" 			: "",
				"date_up" 		: "",
				"date_update" 	: "",
				"status" 		: ""
		}
		
	$scope.objectsC = [];
	$scope.factory = {};
	$scope.canvas = {};
	$scope.factory.stickersCount = 0;
	$scope.factory.photosCount = 0;
	$scope.factory.canvas = new fabric.Canvas("play_board", {stateful: false}, {renderOnAddRemove: false});
	$scope.formSelected = false;
	$scope.imageSelected = false;
	$scope.canvasTarget = false;
	$scope.showFonts = false;
	$scope.paletteArray = [];
	$scope.fontArray = [];
	$scope.paletteArrayCopy = [];
	$scope.liStyle = "1px solid black";
	$scope.showImages = 0;
	$scope.showImagesIdentity = 0;
	$scope.showImagesCampaign = 0;
	$scope.showFontsCampaign = 0;
	$scope.canvasWidth = "700";
	$scope.canvasHeight = "500";
	$scope.textsCampaign = [];
	$scope.showCanvasMaterialSelected = false;
	
	
	$scope.testfonts = [
		{
			"family": "Abhaya Libre",
			"url": "https://cdn.rawgit.com/mooniak/abhaya-libre-font/gh-pages/fonts/AbhayaLibre-Regular.otf"
		},
		{
			"family": "Gemunu Libre",
			"url": "https://cdn.rawgit.com/mooniak/gemunu-libre-font/gh-pages/tests/fonts/GemunuLibre-Regular.otf"
		},
	];
	
	$scope.setTransparent = function(){
		$scope.factory.canvas.setBackgroundColor(null, $scope.factory.canvas.renderAll.bind($scope.factory.canvas));
		$scope.canvasTarget = false;
	}
	
	
	$scope.materialSelect = function(material){
		$scope.canvasWidth = material.width;
		$scope.canvasHeight = material.height;
		
		for (var i in $scope.materialArray){
			$scope.materialArray[i].style="";
		}
		
		material.style="1px solid black";
		$scope.factory.canvas.setWidth($scope.canvasWidth);
		$scope.factory.canvas.setHeight($scope.canvasHeight);
		$scope.factory.canvas.calcOffset();
	}
	
	$scope.seeImagesIdentity = function(){
		$scope.showImagesIdentity = 1;
	}
	$scope.seeImages = function(){
		$scope.showImagesCampaign = 1;
	}
	$scope.hideImages = function(){
		$scope.showImagesCampaign = 0;
	}
	$scope.hideImagesIdentity = function(){
		$scope.showImagesIdentity = 0;
	}
	$scope.seeFonts = function(){
		console.log("onFonts");
		$scope.showFontsCampaign = 1;
	}
	$scope.hideFonts = function(){
		$scope.showFontsCampaign = 0;
	}
	
	$scope.materialChange = function(){
		
		$scope.newMaterialChange = {};		
		var material = $( "#selectmateriall" ).val();
		
		for (var i in $scope.materialArray){
			if($scope.materialArray[i].id_material === material){
				$scope.newMaterialChange = $scope.materialArray[i];
				$scope.canvasWidth = $scope.materialArray[i].width;
				$scope.canvasHeight = $scope.materialArray[i].height;
			}
		}
		
		console.log($scope.currentUser.id_company);
		console.log(material.free);
		$scope.factory.canvas.clear();
		if($scope.currentUser.id_company === "4" && material.free == 0){
			
			console.log("Marca de Agua");
			var myImg = 'http://wizadqa.mbledteq.com/materiales/'+material.thumbnail;
			fabric.Image.fromURL(myImg, function(oImg) {
				var l = Math.random() * (500 - 0) + 0;
				var t = Math.random() * (500 - 0) + 0;                
				oImg.scale(0.6);
				oImg.set({'left':0});
				oImg.set({'top':0});
				oImg.set({'opacity':0.85});
				oImg.set({'selectable':false});
				oImg.set({'name':'overlayImage'});
				$scope.factory.canvas.add(oImg);
			});
			
		}
		
		console.log($scope.canvasHeight);
		$scope.showCanvasMaterialSelected = true;
		material.style="1px solid black";
		// $scope.factory.canvas.setWidth($scope.canvasWidth);
		// $scope.factory.canvas.setHeight($scope.canvasHeight);
		// $scope.factory.canvas.width  = $scope.canvasWidth;
		// $scope.factory.canvas.height = $scope.canvasHeight; 
		// $scope.factory.canvas.style.width  = $scope.canvasWidth + 'px';
		// $scope.factory.canvas.style.height = $scope.canvasHeight + 'px';
		// $('#play_board').attr({width:parseInt($scope.canvasWidth),height:parseInt($scope.canvasHeight)}).css({width:$scope.canvasWidth + 'px',height:$scope.canvasHeight + 'px'});
		console.log(parseInt($scope.canvasHeight));
		$scope.factory.canvas.setDimensions({width: parseInt($scope.canvasWidth), height: parseInt($scope.canvasHeight)});
		
		if(parseInt($scope.canvasWidth) > 1000){
			$("#hero_container").css("min-width", "1000px");
			$("#hero_container").css("width", "1000px");
		}
		else{
			$("#hero_container").css("min-width", $scope.canvasWidth +"px");
			$("#hero_container").css("width", $scope.canvasWidth +"px");
		}
		
		// $("#play_board").width(parseInt($scope.canvasWidth)).height(parseInt($scope.canvasHeight));
		//$scope.exportAs();
		
		
		//$scope.factory.canvas.calcOffset();
		 $scope.factory.canvas.deactivateAll().renderAll();
		//$scope.factory.canvas.renderAll();
	}
	
	
	
	objCampaign.getCampaign()
		.then(function(data) {

			$scope.CampaignSelected.id_campaign = data.id_campaign;
			$scope.CampaignSelected.description = data.description;
			$scope.CampaignSelected.name 		= data.name;
			$scope.CampaignSelected.date_up 	= data.date_up;
			$scope.CampaignSelected.date_update = data.date_update;
			$scope.CampaignSelected.status 		= data.status;			

			var params = {
				"campaign_p" : ""
			}
			params.campaign_p = $scope.CampaignSelected.id_campaign;
			$scope.images = [];
			$scope.imagesIdentity = [];
			
			campaignService.GPackCampaign(params)
			.then(function(data) {
				if(data.length>0){
				$scope.imageArray = data;
				for (var i in $scope.imageArray){
					var newImg   = { title: '', src: '' , isUserUploaded: false};
					newImg.title = $scope.imageArray[i].image;
					newImg.src   = urlHostEmpresas + 'uploads/' + $scope.imageArray[i].image;
					$scope.images.push(newImg);
				}
				}
			})
			
			campaignService.GPackIdentity(params)
			.then(function(data) {
				if(data.length>0){
				$scope.identityImageArray = data;
				for (var i in $scope.identityImageArray){
					var newImg   = { title: '', src: '' , isUserUploaded: false};
					newImg.title = $scope.identityImageArray[i].image;
					newImg.src   = urlHostEmpresas + '/uploads/' + $scope.identityImageArray[i].image;
					$scope.imagesIdentity.push(newImg);
				}
				}
			})
			
			campaignService.GPaletteCampaign(params)
			.then(function(data) {
				$scope.paletteArray = data;
				var newPaletteO = { id_palette: 10000, color: '#FFFFFF' };
				$scope.paletteArray.push(newPaletteO);
				newPaletteO = { id_palette: 10000, color: '#000000' };
				$scope.paletteArray.push(newPaletteO);
				for(var i in $scope.paletteArray){
					$scope.paletteArrayCopy.push($scope.paletteArray[i]);
				}
			})
			
			campaignService.GFontsCampaign(params)
			.then(function(data) {
				$scope.fontArray = data;
				for (var i in $scope.fontArray){
					$scope.fontArray[i].urlcheck = urlHostEmpresas + '/uploads/' + $scope.fontArray[i].font;
					$scope.fontArray[i].name = $scope.fontArray[i].font.substring(0, $scope.fontArray[i].font.length-4); ;
				}
			})
			
			campaignService.GTextsCampaign(params)
			.then(function(data) {
				$scope.textsCampaign = data;
			})
			
			campaignService.GMaterialsCampaign(params)
			.then(function(data) {
				$scope.materialArray = data;
				for (var i in $scope.materialArray){
					$scope.materialArray[i].style="";
				}
			})
		})
	
	$scope.factory.canvas.on({
	  'object:moving': function objectMoving(e) {
		$rootScope.$broadcast('objectMoving', e);
	  },
	  'object:selected': function objectSelected(e) {
		$rootScope.$broadcast('objectSelected', e);
	  },
	  'selection:cleared': function selectionCleared(e) {
		$rootScope.$broadcast('objectCleared', e);
	  },
	  'object:modified': function objectModified(e) {
		$rootScope.$broadcast('objectModified', e);
	  },
	  'object:added': function objectAdded(e) {
		$rootScope.$broadcast('objectAdded', e);
	  },
	  'object:removed': function objectRemoved(e) {
		$rootScope.$broadcast('objectRemoved', e);
	  },
	  'path:created': function pathCreated(e) {
		$rootScope.$broadcast('pathCreated', e);
	  }
	});
	
		//*stickers*//
		
		
	  $scope.images = [{
		title: "2x1",
		src: "http://wizadqa.mbledteq.com/uploads/TELCEL2.jpg",
		isUserUploaded: false
	  }, {
		title: "Cinepolis",
		src: "images/cinepolis.png",
		isUserUploaded: false
	  }, {
		title: "Fondo",
		src: "images/fondo.png",
		isUserUploaded: false
	  }, {
		title: "Palomitas",
		src: "images/palomitas.png",
		isUserUploaded: false
	  }, {
		title: "Personas",
		src: "images/personascin.png",
		isUserUploaded: false
	  }, {
		title: "Sala",
		src: "images/sala.png",
		isUserUploaded: false
	  }];


	  //Restore Stored Stickers
	  var stickersImgs = ImagesFactory.getRestoredStickerImages($scope.images);
	  $scope.images = stickersImgs;

	  $scope.uploaded = false;
	  $scope.title = "";
	  $scope.previewImages = [];

	  //Drag & Drop Styles
	  $scope.styles = {
		draggables: {
		  onDragging: { border: "1px dashed #000", cursor: "move" },
		  onStart: { opacity: 0.5 }
		},
		droppables: {
		  onEnter: { border: "1px dashed #2DA43E" },
		  onLeave: { border: "" }
		}
	  };

	  //Drag Drop Events Callbacks
	  $scope.dragCallback = function (event) {
		console.log("Dragging", event);
	  };

	  $scope.dropCallback = function (event) {
		var currDragElem = ngDragDrop.getCurrentDragElement();
		var imgSrc = currDragElem.attr("src");
		var object = {
		  src: imgSrc,
		  drop: true
		};
		$scope.dropImage(object, event);
		console.log("Dropped", event);
	  };

	  $scope.overCallback = function (event) {
		console.log("Drag Over", event);
	  };

	  //Delete Sticker
	  $scope.deleteSticker = function (image) {
		var index = $scope.images.indexOf(image);
		$scope.images.splice(index, 1);
		ImagesFactory.deleteStickerImage(image); //delete from persisted localStorage
		UtilsFactory.resetUsedFileStorageSpace(); //Reset the $rootScope file storage for header data update
	  };

	  //callback function once file is uploaded
	  $scope.onFileUpload = function () {
		$scope.uploaded = true;
	  };

	  //submit sticker
	  $scope.submitSticker = function (form) {
		var guid = UtilsFactory.guid();
		var sticker = {
		  src: $scope.previewImages[0],
		  title: $scope.title,
		  isUserUploaded: true,
		  guid: guid
		};

		if (form.$valid && $scope.previewImages.length) {
		  //if form is valid perform action
		  form.$setPristine();
		  form.$setUntouched();
		  $scope.uploaded = false;
		  $scope.images.push(sticker);
		  ImagesFactory.saveStickerImage(sticker); //Persist Sticker Image
		  UtilsFactory.resetUsedFileStorageSpace(); //Reset the $rootScope file storage for header data update
		  $scope.previewImages = []; //Reset the images
		  ngDialog.close();
		}
	  };

	  //upload sticker
	  $scope.uploadSticker = function () {
		$timeout(function () {
		  //Notify $digest cycle hack
		  $('#sticker_upload').trigger('click');
		}, 0);
	  };

	  //open upload dialog
	  $scope.openUploadDialog = function () {
		if (0 >= 1) { //AppSettings.maxStorageSpace
		  //if storage exceed max app provided storage space then throw error
		  alert("Exceeded max provided localstorage space. Please empty to save.");
		} else {
		  //open dialog to save
		  ngDialog.open({
			template: 'design/stickerDialog.html',
		  });
		}
	  };

	  //Add Image to Canvas Area
	  $scope.dropImage = function (obj, $event) {
		// var canvas = CanvasFactory.getCanvas();
		// $scope.objectsC = canvas._objects;
		var PosX = 0,
			PosY = 0;
		if (obj.drop === true) {
		  PosX = 0; //$event.clientX - $event.currentTarget.offsetLeft - 50;
		  PosY = 0; //$event.clientY - $event.currentTarget.offsetTop - 54; //offset height of header
		}
		fabric.Image.fromURL(obj.src, function (oImg) {
		  if (obj.drop === true) {
			oImg.set('left', PosX).set('top', PosY);
		  }
			// $scope.factory.canvas.centerObject(oImg);
			$scope.factory.canvas.add(oImg);
			$scope.factory.canvas.renderAll();
		  // canvas.add(oImg);
		});
	  };
	  
	  	//*canvas*//

	  $scope.isObjectSelected = false;

	  //on object selection
	  $rootScope.$on("objectSelected", function () {
		$timeout(function () {
		  $scope.isObjectSelected = true;
		  $scope.canvasTarget = false;
		  var activeObject = $scope.factory.canvas.getActiveObject();
		  console.log(activeObject);
		  if(activeObject.type === "circle" || activeObject.type === "triangle" 
				|| activeObject.type === "rect" || activeObject.type === "i-text"
				|| activeObject.type === "line"){
				$scope.formSelected = true;
				
				if(activeObject.type === "i-text"){
					$scope.showFonts = true;
				}
				else{
					$scope.showFonts = false;
				}
				
		  }else{
			    $scope.formSelected = false;
				$scope.showFonts = false;
		  }
		  if(activeObject.type === "image" ){
				$scope.imageSelected = true;
				$scope.showFonts = false;
		  }else{
			    $scope.imageSelected = false;
		  }
		}, 0);
	  });
	  
	  $scope.changeFormColor = function(pal){
			var activeObject = $scope.factory.canvas.getActiveObject();
			console.log(activeObject.type);
			if(activeObject.type === "circle" || activeObject.type === "triangle" 
				|| activeObject.type === "rect" || activeObject.type === "i-text"){
				activeObject.setFill(pal.color);	
			}
			
			if(activeObject.type === "line"){
				activeObject.setStroke(pal.color);	
			}
			
			$scope.factory.canvas.deactivateAll().renderAll();
			$scope.formSelected = false;
			// activeObject.setColor(pal.color);
	  }
	  
	  $scope.addZoom = function(){
		$scope.factory.canvas.setZoom($scope.factory.canvas.getZoom()+1);
		$scope.factory.canvas.renderAll();
	  }
	  
	  $scope.lessZoom = function(){
		$scope.factory.canvas.setZoom($scope.factory.canvas.getZoom()-1);
		$scope.factory.canvas.renderAll();
	  }
	  
	  var download = function download(url, name) {
		angular.element('<a>').attr({ href: url, download: name })[0].click();
	  };
		  
	  $scope.exportAs = function(name) {
		  
		//$scope.factory.canvas.deactivateAll().renderAll();
		//download($scope.factory.canvas.toDataURL(), 'wizad_design.png');
		$scope.factory.canvas.setZoom(1);
		download($scope.factory.canvas.toDataURL({multiplier: 2}), 'wizad_design.png');
		// download($scope.factory.canvas.toDataURL({format: 'p',    multiplier: 2   }), 'wizad_design.png');
	  }
	  
	  $scope.renderAllTest = function(){
		  $scope.factory.canvas.deactivateAll().renderAll();
	  }
	  // $scope.changeFormColor = function(pal){
			// var activeObject = $scope.factory.canvas.getActiveObject();
		
			// activeObject.setFill(pal.color);
			// $scope.factory.canvas.renderAll();
			// // activeObject.setColor(pal.color);
	  // }
	  
	  $scope.canvasIsTargeted = function(){
		  $scope.canvasTarget = true;
		  $scope.formSelected = false;
		  $scope.factory.canvas.deactivateAll().renderAll();
	  }
	  
	  $scope.changeTextFont = function(font){
		  var activeObject = $scope.factory.canvas.getActiveObject();
		  activeObject.fontFamily = font.font;
		  $scope.factory.canvas.renderAll();
		  console.log(font.font);
		  // var text = "Escribe tu texto..";
		  // var fontColor = $scope.paletteArray[0].color;
		  // var textSample = new fabric.IText(text, {
			  // left: fabric.util.getRandomInt(10, 100),
			  // top: fabric.util.getRandomInt(10, 200),
			  // fontFamily: font.font,
			  // angle: 0,
			  // fill: fontColor,
			  // scaleX: 0.5,
			  // scaleY: 0.5,
			  // fontWeight: '',
			  // hasRotatingPoint: true
			// });
		// $scope.factory.canvas.add(textSample);
		// $scope.factory.canvas.item(canvas.item.length - 1).hasRotatingPoint = true;
		// $scope.factory.canvas.setActiveObject(textSample);
		// $scope.factory.canvas.renderAll();
	  }

	  //on object cleared
	  $rootScope.$on("objectCleared", function () {
		$timeout(function () {
		  $scope.formSelected = false;
		  $scope.imageSelected = false;
		  $scope.isObjectSelected = false;
		  $scope.showFonts = false;
		}, 0);
	  });

	  //delete selected object
	  $scope.deleteSelectedObject = function () {
		var canvas = CanvasFactory.getCanvas();
		var activeObject = $scope.factory.canvas.getActiveObject();
		$scope.factory.canvas.remove(activeObject);
	  };
	  
	  $scope.addLine = function(){
		  
		  var bkColor = $scope.factory.canvas.backgroundColor;
			var presetColor = 0;
			while(bkColor === $scope.paletteArray[presetColor].color){
				presetColor ++;
			}
		  
		var fontColor = $scope.paletteArray[presetColor].color;
		
		var lineSample = new fabric.Line([50, 100, 200, 200], {
			left: 170,
			top: 150,
			stroke: fontColor
		});
		
		$scope.factory.canvas.add(lineSample);
	  }

	  //add text
	  $scope.addText = function () {
		// var canvas = CanvasFactory.getCanvas();
		var bkColor = $scope.factory.canvas.backgroundColor;
			var presetColor = 0;
			while(bkColor === $scope.paletteArray[presetColor].color){
				presetColor ++;
			}
		
		
		var text = "Escribe tu texto..";
		var fontColor = $scope.paletteArray[presetColor].color;
		var fontFamily = "Allerta+Stencil";
		var textSample = new fabric.IText(text, {
		  left: fabric.util.getRandomInt(10, 100),
		  top: fabric.util.getRandomInt(10, 200),
		  fontFamily: 'Raleway-Bold.ttf',
		  angle: 0,
		  fill: fontColor,
		  scaleX: 3,
		  scaleY: 3,
		  fontWeight: '',
		  hasRotatingPoint: true
		});
		$scope.factory.canvas.add(textSample);
		$scope.factory.canvas.item(canvas.item.length - 1).hasRotatingPoint = true;
		$scope.factory.canvas.setActiveObject(textSample);
	  };
	  
	  $scope.addPreloadedText = function(text){
		  // var canvas = CanvasFactory.getCanvas();
			var bkColor = $scope.factory.canvas.backgroundColor;
			var presetColor = 0;
			while(bkColor === $scope.paletteArray[presetColor].color){
				presetColor ++;
			}
		  
			var text = text.text;
			var fontColor = $scope.paletteArray[presetColor].color;
			var fontFamily = "Allerta+Stencil";
			var textSample = new fabric.IText(text, {
			  left: fabric.util.getRandomInt(10, 100),
			  top: fabric.util.getRandomInt(10, 200),
			  fontFamily: 'Raleway-Bold.ttf',
			  angle: 0,
			  fill: fontColor,
			  scaleX: 3,
			  scaleY: 3,
			  fontWeight: '',
			  hasRotatingPoint: true
			});
			$scope.factory.canvas.add(textSample);
			$scope.factory.canvas.item($scope.factory.canvas.item.length - 1).hasRotatingPoint = true;
			$scope.factory.canvas.setActiveObject(textSample);
	  }

	  //paint the canvas
	  $scope.paintBrush = function () {
		alert("Sorry :( not yet implemented...");
	  };

	  // var font = $scope.factory.canvas.Font('Ubuntuu', 'http://wizadqa.mbledteq.com/uploads/fonts/Raleway-Light.ttf');
	  
	  
	  
	  //reset the board
	  $scope.resetBoard = function () {
		var canvas = CanvasFactory.getCanvas();
		canvas.clear();
	  };
	  
		$scope.changeCanvasColor = function(pal){
			$scope.factory.canvas.backgroundColor=pal.color;
			$scope.factory.canvas.renderAll();
			$scope.canvasTarget = false;
			// $scope.factory.canvas.renderTop();
		}
		
		$scope.addCircle = function(){
			
			var bkColor = $scope.factory.canvas.backgroundColor;
			var presetColor = 0;
			while(bkColor === $scope.paletteArray[presetColor].color){
				presetColor ++;
			}
			
			var circle=new fabric.Circle({
				top: 150,
				left: 150,
				radius: 99,
				fill: $scope.paletteArray[presetColor].color
			});
			$scope.factory.canvas.add(circle);
		}
		
		$scope.addTriangle = function(){
			
			var bkColor = $scope.factory.canvas.backgroundColor;
			var presetColor = 0;
			while(bkColor === $scope.paletteArray[presetColor].color){
				presetColor ++;
			}
			
			var triangle=new fabric.Triangle({
				top: 150,
				left: 150,
				radius: 99,
				fill: $scope.paletteArray[presetColor].color
			});
			
			$scope.factory.canvas.add(triangle);
		}
		
		$scope.addRectangle = function(){
			
			var bkColor = $scope.factory.canvas.backgroundColor;
			var presetColor = 0;
			while(bkColor === $scope.paletteArray[presetColor].color){
				presetColor ++;
			}
			
			var rectangle=new fabric.Rect({
				left: 100,
				top: 50,
				width: 100,
				height: 100,
				fill: $scope.paletteArray[presetColor].color,
				angle: 20,
				padding: 10
			});
			$scope.factory.canvas.add(rectangle);
		}
		
		$scope.moveToFront = function(){
			var activeObject = $scope.factory.canvas.getActiveObject();
			$scope.factory.canvas.bringToFront(activeObject);
			$scope.formSelected = false;
			$scope.factory.canvas.deactivateAll().renderAll();
		}
		$scope.moveToBack = function(){
			var activeObject = $scope.factory.canvas.getActiveObject();
			$scope.factory.canvas.sendToBack(activeObject);
			$scope.formSelected = false;
			$scope.factory.canvas.deactivateAll().renderAll();
		}
		$scope.moveToBackward = function(){
			var activeObject = $scope.factory.canvas.getActiveObject();
			$scope.factory.canvas.sendBackwards(activeObject);
			$scope.formSelected = false;
			$scope.factory.canvas.deactivateAll().renderAll();
		}
		$scope.moveToForward = function(){
			var activeObject = $scope.factory.canvas.getActiveObject();
			$scope.factory.canvas.bringForward(activeObject);
			$scope.formSelected = false;
			$scope.factory.canvas.deactivateAll().renderAll();
		}
		$scope.saveCanvas = function(){
			
		}
		$scope.exportImg = function(){
			var objects = $scope.getCanvasObjects();
			if (objects.length !== 0) {
			  ngDialog.open({
				template: 'design/downloadDialog.html',
				closeByDocument: true,
				closeByEscape: true,
				scope: $scope
			  });
			} else {
			  alert("Nothing on sticker board!!");
			}
		}
		
		$scope.getCanvasObjects = function() {
			
			return $scope.factory.canvas.getObjects();
		}
		
  });
