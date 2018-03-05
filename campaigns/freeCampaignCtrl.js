/**
 * @ngdoc function
 * @name newappApp.controller:campaignMaterialsCtrl
 * @description
 * # campaignMaterialsCtrl
 * Controller of the newappApp
 */

var urlHost = 'https://localhost/';

angular.module('newApp')
  .controller('freeCampaignCtrl', function ($scope, CanvasFactory, ngDialog, $rootScope, $timeout, ngDragDrop, ImagesFactory, UtilsFactory, AppSettings, campaignService, objCampaign , $location, generalService) {

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
	$scope.factory.canvas = new fabric.Canvas("play_board");
	$scope.factory.canvas.preserveObjectStacking = true;
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
	$scope.adminNotified = false;
	$scope.alertExpiredShow  = false;
	$scope.randomNumberArray = [];
	$scope.zoomActivated = false;
	$scope.myFontStack = "";
	$scope.cropStarted = false;
	
	$scope.el = {};
	$scope.object = {};
	$scope.lastActive = {};
	$scope.object1 = {};
	$scope.object2 = {};
	$scope.cntObj=0;
	$scope.election_object_left=0;
	$scope.selection_object_top=0;
	
	/*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*/
	/*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*/
	var main = document.getElementById("play_board");
	var zoom = document.getElementById("zoom");
	var ctx = main.getContext("2d")
	var zoomCtx = zoom.getContext("2d");
	
	// main.addEventListener("mousemove", function(e){
		// console.log(e);
		// zoomCtx.fillStyle = "white";
		// //zoomCtx.clearRect(0,0, zoom.width, zoom.height);
		// //zoomCtx.fillStyle = "transparent";
		// zoomCtx.fillRect(0,0, zoom.width, zoom.height);
		// zoomCtx.drawImage(main, e.x, e.y, 200, 100, 0,0, 400, 200);
		// console.log(zoom.style);
		// zoom.style.top = e.pageY + 10 + "px"
		// zoom.style.left = e.pageX + 10 + "px"
		// zoom.style.display = "block";
	// });

	// main.addEventListener("mouseout", function(){
		// zoom.style.display = "none";
	// });
	/*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*/
	/*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*//*ZOOM*/
		
	$scope.fontsUploaded = [];
	generalService.GFonts()
	.then(function(data) {
		$scope.fontsUploaded = data;
		
	})
	
	var accepti = ".png,.jpg";
	var acceptf = ".ttf,.otf";
	var myDropzone2 = new Dropzone("#dropzoneFrm2", { addRemoveLinks: true , acceptedFiles: acceptf });
	// var myDropzone3 = new Dropzone("#dropzoneFrm3", { addRemoveLinks: true , acceptedFiles: accepti });
	
	myDropzone2.on("success", function(file) {
		var newFont 	= { id_font: 0, font: '' };
		newFont.id_font = $scope.fontsUploaded.length+1;
		newFont.font 	= file.name.substring(0, file.name.length-4);
		$scope.fontsUploaded.push(newFont);
		
		var FormatType = "";
		if(file.name.indexOf("otf") !== -1){
			FormatType = "opentype";
		}
		if(file.name.indexOf("ttf") !== -1){
			FormatType = "truetype";
		}
		$("head").append("<style>@font-face { font-family: "+file.name.substring(0, file.name.length-4)+";    src: url('/uploads/"+file.name+"') format('"+FormatType+"');}</style>");
		$scope.$apply();
		$scope.factory.canvas.renderAll();
		// file._downloadLink = Dropzone.createElement("<button type=\"button\" class=\"btn btn-primary btn-embossed\" ng-click=\"modifyFont()\" style=\"margin-top:3px;\">Aplicar</button>");
		// file.previewElement.appendChild(file._downloadLink);    
		return file.previewElement.classList.add("dz-success");
	});
	
	$scope.modifyFont = function(){
		// var activeObject = $scope.factory.canvas.getActiveObject();
		
			
			// var modifyFontFamily = $( "#selectFont" ).val();
		
			// if(modifyFontFamily.indexOf("otf") !== -1){
				// modifyFontFamily = modifyFontFamily.substring(0, modifyFontFamily.length-4);
			// }
			// if(modifyFontFamily.indexOf("ttf") !== -1){
				// modifyFontFamily = modifyFontFamily.substring(0, modifyFontFamily.length-4);
			// }
			// activeObject.fontFamily = modifyFontFamily;
			// var y = 1;	
			// $scope.factory.canvas.renderAll();
			
		console.log($scope.myFontStack);
		var activeObject = $scope.factory.canvas.getActiveObject();
		activeObject.fontFamily = $scope.myFontStack;
		$scope.factory.canvas.renderAll();
		
		
	}
	
	$scope.modifyFontSize = function(){
		// var activeObject = $scope.factory.canvas.getActiveObject();
		
			
			// var modifyFontFamily = $( "#selectFont" ).val();
		
			// if(modifyFontFamily.indexOf("otf") !== -1){
				// modifyFontFamily = modifyFontFamily.substring(0, modifyFontFamily.length-4);
			// }
			// if(modifyFontFamily.indexOf("ttf") !== -1){
				// modifyFontFamily = modifyFontFamily.substring(0, modifyFontFamily.length-4);
			// }
			// activeObject.fontFamily = modifyFontFamily;
			// var y = 1;	
			// $scope.factory.canvas.renderAll();
	    var fontSizeStack = $( "#selectfontsize" ).val();
		console.log(fontSizeStack);
		var activeObject = $scope.factory.canvas.getActiveObject();
		activeObject.fontSize = parseInt(fontSizeStack);
		$scope.factory.canvas.renderAll();
		
		
	}
	
	// myDropzone3.on("success", function(file) {
		// // var newFont 	= { id_font: 0, font: '' };
		// // newFont.id_font = $scope.fontsUploaded.length+1;
		// // newFont.font 	= file.name;
		// // $scope.fontsUploaded.push(newFont);
		// file._downloadLink = Dropzone.createElement("<button type=\"button\" class=\"btn btn-primary btn-embossed\" data-dismiss=\"modal\" style=\"margin-top:3px;\">Aplicar</button>");
		// file.previewElement.appendChild(file._downloadLink);    
		// return file.previewElement.classList.add("dz-success");
	// });
	
	if($scope.currentUser.id_company === "4" || parseInt($scope.currentUser.typenum) === 2){
		$scope.adminNotified = true;
	}
	
	var newPaletteO = { color: "" };
	newPaletteO.color = "#000000";
	$scope.paletteArray.push(newPaletteO);
	newPaletteO = { color: "" };
	newPaletteO.color = "#FFFFFF";
	$scope.paletteArray.push(newPaletteO);
	
	$scope.notifyAdministrador = function(){
		$scope.adminNotified = true;
		
		var params = {
				"company_p" : "",
				"user_p"	: ""
			}
			params.company_p = $scope.currentUser.fk_company;
			params.user_p 	 = $scope.currentUser.name;
			
			generalService.NotifyAdministratorFreeCampaign(params)
			.then(function(data) {
				
			})
		
		var historyUser = {
				"user_p" 		: "",
				"message_p"		: "",
				"campaign_p"	: ""
			}
			
			historyUser.user_p		= $scope.currentUser.id_user;
			historyUser.message_p	= "Inicio campaña libre";
			historyUser.campaign_p 	= 0;
			
			generalService.AddHistory(historyUser)
			.then(function(data) {
				
			})
	}
	
	$scope.clearCanvas = function(){
		$scope.factory.canvas.clear();
	}
	
	$scope.newPalette = function(newColor){
		console.log(newColor);
		$scope.your_model = "";
		if(newColor === undefined || newColor === ""){
			$scope.alertExpiredClass = "alert alert-warning";
			$scope.alertExpiredShow  = true;
			$scope.alertExpiredMessage = "Seleccione un color..";
			return;
		}
		
		for(var i in $scope.paletteArray){
			
			if($scope.paletteArray[i].color === newColor){
				$scope.alertExpiredClass = "alert alert-warning";
				$scope.alertExpiredShow  = true;
				$scope.alertExpiredMessage = "Color ya agregado anteriormente..";
				return;
			}
		}
				
		var newPaletteR = { color: '' };
		newPaletteR.color = newColor;
		$scope.paletteArray.push(newPaletteR);
		$scope.alertExpiredShow  = false;
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
		
		$scope.factory.canvas.clear();
		if($scope.currentUser.id_company === "4" && $scope.newMaterialChange.free == 0){
			
			console.log("Marca de Agua");
			var myImg = urlHost + 'materiales/'+$scope.newMaterialChange.thumbnail;
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
		
		$scope.showCanvasMaterialSelected = true;
		material.style="1px solid black";
		// $scope.factory.canvas.setWidth($scope.canvasWidth);
		// $scope.factory.canvas.setHeight($scope.canvasHeight);
		// $scope.factory.canvas.width  = $scope.canvasWidth;
		// $scope.factory.canvas.height = $scope.canvasHeight; 
		// $scope.factory.canvas.style.width  = $scope.canvasWidth + 'px';
		// $scope.factory.canvas.style.height = $scope.canvasHeight + 'px';
		// $('#play_board').attr({width:parseInt($scope.canvasWidth),height:parseInt($scope.canvasHeight)}).css({width:$scope.canvasWidth + 'px',height:$scope.canvasHeight + 'px'});
		
		
		$scope.widthMultiplier = $scope.canvasWidth / 800;
		$scope.heightMultiplier = $scope.canvasHeight / 500;
		
		$("#hero_container").css("width", $scope.newMaterialChange.width_small+"px");
		$("#hero_container").css("height", $scope.newMaterialChange.height_small+"px");
		$scope.factory.canvas.setDimensions({width: $scope.newMaterialChange.width_small, height: 
			parseInt($scope.newMaterialChange.height_small)});
		
		// if(parseInt($scope.canvasWidth) > 800){
			// if(parseInt($scope.canvasHeight) > 500){
				// // $("#hero_container").css("min-width", "900px");
				// $("#hero_container").css("width", "800px");
				// $("#hero_container").css("height", "500px");
				// // $("#canvas_container").css("width", "900px");
				// // $("#canvas_container").css("height", "500px");
				// $scope.factory.canvas.setDimensions({width: 800, height: 500});
			// }else{
				// // $("#hero_container").css("min-width", "900px");
				// $("#hero_container").css("width", "800px");
				// $("#hero_container").css("height", $scope.canvasHeight +"px");
				// $scope.factory.canvas.setDimensions({width: 800, height: parseInt($scope.canvasHeight)});
				// // $("#canvas_container").css("width", "900px");
				// // $("#canvas_container").css("height", $scope.canvasHeight +"px");
			// }
		// }
		// else{
			// if(parseInt($scope.canvasHeight) > 500){
				// // $("#hero_container").css("min-width", $scope.canvasWidth +"px");
				// $("#hero_container").css("width", $scope.canvasWidth +"px");
				// $("#hero_container").css("height", "500px");
				// $scope.factory.canvas.setDimensions({width: parseInt($scope.canvasWidth), height: 500});
				// // $("#canvas_container").css("width", $scope.canvasWidth +"px");
				// // $("#canvas_container").css("height", "500px");
			// }else{
				// // $("#hero_container").css("min-width", $scope.canvasWidth +"px");
				// $("#hero_container").css("width", parseInt($scope.canvasWidth));
				// $("#hero_container").css("height", parseInt($scope.canvasHeight));
				// $scope.factory.canvas.setDimensions({width: parseInt($scope.canvasWidth), height: parseInt($scope.canvasHeight)});
				// // $("#canvas_container").css("width", $scope.canvasWidth +"px");
				// // $("#canvas_container").css("height", $scope.canvasHeight +"px");
			// }
		// }
		
		// $("#play_board").width(parseInt($scope.canvasWidth)).height(parseInt($scope.canvasHeight));
		//$scope.exportAs();
		
		
		//$scope.factory.canvas.calcOffset();
		 $scope.factory.canvas.deactivateAll().renderAll();
		 $scope.factory.canvas.deactivateAll().renderAll();
		//$scope.factory.canvas.renderAll();
	}
	
	$scope.setTransparent = function(){
		$scope.factory.canvas.setBackgroundColor(null, $scope.factory.canvas.renderAll.bind($scope.factory.canvas));
		// $scope.canvasTarget = false;
	}
	
	$scope.addZoom = function(){
		$scope.factory.canvas.setZoom($scope.factory.canvas.getZoom()+1);
		$scope.factory.canvas.renderAll();
	}
	  
	$scope.lessZoom = function(){
		$scope.factory.canvas.setZoom($scope.factory.canvas.getZoom()-1);
		$scope.factory.canvas.renderAll();
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
			
			// campaignService.GPackCampaign(params)
			// .then(function(data) {
				// if(data.length>0){
				// $scope.imageArray = data;
				// for (var i in $scope.imageArray){
					// var newImg   = { title: '', src: '' , isUserUploaded: false};
					// newImg.title = $scope.imageArray[i].image;
					// newImg.src   = 'http://wizadqa.mbledteq.com/uploads/' + $scope.imageArray[i].image;
					// $scope.images.push(newImg);
				// }
				// }
			// })
			
			// campaignService.GPackIdentity(params)
			// .then(function(data) {
				// if(data.length>0){
				// $scope.identityImageArray = data;
				// for (var i in $scope.identityImageArray){
					// var newImg   = { title: '', src: '' , isUserUploaded: false};
					// newImg.title = $scope.identityImageArray[i].image;
					// newImg.src   = 'http://wizadqa.mbledteq.com/uploads/' + $scope.identityImageArray[i].image;
					// $scope.imagesIdentity.push(newImg);
				// }
				// }
			// })
			
			// campaignService.GPaletteCampaign(params)
			// .then(function(data) {
				// $scope.paletteArray = data;
				
				// var newPaletteO = { id_palette: 10000, color: '#FFFFFF' };
				// $scope.paletteArray.push(newPaletteO);
				
			// })
			
			campaignService.GFontsCampaign(params)
			.then(function(data) {
				$scope.fontArray = data;
			})
			
			campaignService.getMaterials(params)
			.then(function(data) {
				$scope.materialArray = data;
				for (var i in $scope.materialArray){
					$scope.materialArray[i].style="";
				}
			})
		})
		
	$scope.ZoomStatus = function(){
		if ($scope.zoomActivated){
			$scope.zoomActivated = false;
		}else{
			$scope.zoomActivated = true;
		}
	}
	
	$scope.factory.canvas.on({
	  'object:moving': function objectMoving(e) {
		$scope.$broadcast('objectMoving', e);
	  },
	  'object:selected': function objectSelected(e) {
		$scope.$broadcast('objectSelected', e);
	  },
	  'selection:cleared': function selectionCleared(e) {
		$scope.$broadcast('objectCleared', e);
	  },
	  'object:modified': function objectModified(e) {
		$scope.$broadcast('objectModified', e);
	  },
	  'object:added': function objectAdded(e) {
		$scope.$broadcast('objectAdded', e);
	  },
	  'object:removed': function objectRemoved(e) {
		$scope.$broadcast('objectRemoved', e);
	  },
	  'mouse:move': function MouseMoving(e) {
		// $scope.$broadcast('mouseMoving', e);
		if ($scope.zoomActivated){
			console.log(e);
			zoomCtx.fillStyle = "white";
			//zoomCtx.clearRect(0,0, zoom.width, zoom.height);
			//zoomCtx.fillStyle = "transparent";
			var pointer = $scope.factory.canvas.getPointer(e.e);
			  var posX = pointer.x;
			  var posY = pointer.y;
			zoomCtx.fillRect(0,0, zoom.width, zoom.height);
			zoomCtx.drawImage(main, e.e.offsetX, e.e.offsetY, 200, 100, 0,0, 400, 200);
			console.log(zoom.style);
			zoom.style.top = e.e.offsetY + 10 + "px"
			zoom.style.left = e.e.offsetX + 10 + "px"
			zoom.style.display = "block";
		}else{
			zoom.style.display = "none";
		}
		
	  },
	  'path:created': function pathCreated(e) {
		$scope.$broadcast('pathCreated', e);
	  }
	});
	
		//*stickers*//
		
		
	  $scope.images = [ {
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
		var rectSecondObj = $scope.findObjectWithPropertyValue($scope.factory.canvas, 'name', 'overlayImage');
		$scope.factory.canvas.bringToFront(rectSecondObj);
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
		// var guid = UtilsFactory.guid();
		var imageDimensions = document.createElement('img');
		// imageDimensions.addEventListener('load', function() {
			// // image.width × image.height
			// $scope.widthPrev  = imageDimensions.width; 
			// $scope.heightPrev = imageDimensions.height;
		// });
		
		
		var image = {
			// guid: guid,
			src: $scope.previewImages[0]
		};
		
		imageDimensions.src = image.src;
		image.width = imageDimensions.width; 
		image.height = imageDimensions.height;
		var myDivElement = $( "#mContent" );
		
		$scope.images.push(image);
		// ImagesFactory.savePhotoImage(image);
		console.log($scope.images);
		console.log("preview");
		console.log($scope.previewImages);
		// UtilsFactory.resetUsedFileStorageSpace(); //Reset the $rootScope file storage for header data update
		$scope.previewImages = [];
		var sticker = {
		  src: $scope.previewImages[0],
		  title: "Nueva imagen",
		  isUserUploaded: true
		};
		ImagesFactory.saveStickerImage(sticker);
		
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
		var PosX = undefined,
			PosY = undefined;
		if (obj.drop === true) {
		  PosX = $event.clientX - $event.currentTarget.offsetLeft - 50;
		  PosY = $event.clientY - $event.currentTarget.offsetTop - 54; //offset height of header
		}
		fabric.Image.fromURL(obj.src, function (oImg) {
		  if (obj.drop === true) {
			oImg.set('left', PosX).set('top', PosY);
		  }
			var random = $scope.getRandomSpan();
			random = "img" + random;
			oImg.set('id', random)
			$scope.factory.canvas.centerObject(oImg);
			oImg.scaleToWidth(250);
			oImg.scaleToHeight(250);
			$scope.factory.canvas.add(oImg);
			var rectSecondObj = $scope.findObjectWithPropertyValue($scope.factory.canvas, 'name', 'overlayImage');
			$scope.factory.canvas.bringToFront(rectSecondObj);
			$scope.factory.canvas.renderAll();
		  // canvas.add(oImg);
		});
	  };
	  
	  	//*canvas*//

	  $scope.isObjectSelected = false;

	  //mouseMoving
		// $scope.$on("mouseMoving", function (e) {
			// $timeout(function () {
				// // console.log(e);
				// zoomCtx.fillStyle = "white";
				// //zoomCtx.clearRect(0,0, zoom.width, zoom.height);
				// //zoomCtx.fillStyle = "transparent";
				// zoomCtx.fillRect(0,0, zoom.width, zoom.height);
				// zoomCtx.drawImage(main, e.x, e.y, 200, 100, 0,0, 400, 200);
				// console.log(zoom.style);
				// zoom.style.top = e.pageY + 10 + "px"
				// zoom.style.left = e.pageX + 10 + "px"
				// zoom.style.display = "block";
			// }, 0);
		// });
	  
	  //on object selection
	  $scope.$on("objectSelected", function () {
		$timeout(function () {
		  $scope.isObjectSelected = true;
		  $scope.canvasTarget = false;
		  var activeObject = $scope.factory.canvas.getActiveObject();
		  
		  if(activeObject.id.indexOf("circle") !== -1 || activeObject.id.indexOf("triangle") !== -1
				|| activeObject.id.indexOf("rect") !== -1 || activeObject.id.indexOf("text") !== -1
				|| activeObject.id.indexOf("line") !== -1){
				$scope.formSelected = true;
				
				if(activeObject.id.indexOf("text") !== -1){
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
			// $scope.formSelected = false;
			// $scope.factory.canvas.deactivateAll().renderAll();
			// activeObject.setColor(pal.color);
			$scope.factory.canvas.renderAll();
	  }
	  
	  var download = function download(url, name) {
		angular.element('<a>').attr({ href: url, download: name })[0].click();
	  };
		  
	  $scope.exportPDF = function(name) {
		 $scope.factory.canvas.deactivateAll().renderAll();
		 $scope.factory.canvas.setZoom(1);
		 console.log($scope.factory.canvas);
		 console.log($scope.newMaterialChange);
		 $scope.savingCanvasWidth = $scope.factory.canvas.width;
		 $scope.savingCanvasHeight = $scope.factory.canvas.height;
		 console.log($scope.savingCanvasWidth);
		 console.log($scope.savingCanvasHeight);
		 $scope.factory.canvas.setDimensions({width: parseInt($scope.newMaterialChange.width), height: parseInt($scope.newMaterialChange.height)});
		 var imgData = $scope.factory.canvas.toDataURL({       format: 'png'   });
		 // download($scope.factory.canvas.toDataURL({       format: 'png'   }), 'wizad_design.png');
		 $scope.factory.canvas.setDimensions({width: parseInt($scope.savingCanvasWidth), height: parseInt($scope.savingCanvasHeight)});
		 var pdf = new jsPDF();
		 pdf.addImage(imgData, 'JPEG', 0, 0);
		 var download = document.getElementById('download');
		 pdf.save("download.pdf");

	 }
	 $scope.exportPNG = function(name) {
                 fabric.devicePixelRatio = 1;
		 $("#hero_container").css("width", $scope.newMaterialChange.width+"px");
		 $("#hero_container").css("height", $scope.newMaterialChange.height+"px");
		 $scope.factory.canvas.setDimensions({width: $scope.newMaterialChange.width, height: 
			parseInt($scope.newMaterialChange.height)});
			
		 var objects =  $scope.factory.canvas.getObjects();
			for (var i in objects) {
				var scaleX = objects[i].scaleX;
				var scaleY = objects[i].scaleY;
				var left = objects[i].left;
				var top = objects[i].top;

				var tempScaleX = scaleX * $scope.newMaterialChange.width_multiplier;
				var tempScaleY = scaleY * $scope.newMaterialChange.height_multiplier;
				var tempLeft = left * $scope.newMaterialChange.width_multiplier;
				var tempTop = top * $scope.newMaterialChange.height_multiplier;

				objects[i].scaleX = tempScaleX;
				objects[i].scaleY = tempScaleY;
				objects[i].left = tempLeft;
				objects[i].top = tempTop;

				objects[i].setCoords();
			}
			$scope.factory.canvas.renderAll();
			$scope.factory.canvas.calcOffset();
			var imgData = $scope.factory.canvas.toDataURL({       format: 'png'   });
			download($scope.factory.canvas.toDataURL({       format: 'png'   }), 'wizad_design.png');
//AFTER DOWNLOAD RETURN TO NORMAL STATE
			
		$("#hero_container").css("width", $scope.newMaterialChange.width_small+"px");
		$("#hero_container").css("height", $scope.newMaterialChange.height_small+"px");
		$scope.factory.canvas.setDimensions({width: $scope.newMaterialChange.width_small, height: 
			parseInt($scope.newMaterialChange.height_small)});
			
		var objects =  $scope.factory.canvas.getObjects();
			for (var i in objects) {
				var scaleX = objects[i].scaleX;
				var scaleY = objects[i].scaleY;
				var left = objects[i].left;
				var top = objects[i].top;

				var tempScaleX = scaleX / $scope.newMaterialChange.width_multiplier;
				var tempScaleY = scaleY / $scope.newMaterialChange.height_multiplier;
				var tempLeft = left / $scope.newMaterialChange.width_multiplier;
				var tempTop = top / $scope.newMaterialChange.height_multiplier;

				objects[i].scaleX = tempScaleX;
				objects[i].scaleY = tempScaleY;
				objects[i].left = tempLeft;
				objects[i].top = tempTop;

				objects[i].setCoords();
			}
			$scope.factory.canvas.renderAll();
			$scope.factory.canvas.calcOffset();

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
		  $scope.alertExpiredShow = false;
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
	  $scope.$on("objectCleared", function () {
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
		 
			var random = $scope.getRandomSpan();
			random = "line" + random;
			
			var bkColor = $scope.factory.canvas.backgroundColor;
			var presetColor = 0;
			while(bkColor === $scope.paletteArray[presetColor].color){
				presetColor ++;
			}
		  
			var fontColor = $scope.paletteArray[presetColor].color;
			
			var lineSample = new fabric.Line([50, 100, 200, 100], {
				left: 20,
				top: 20,
				stroke: fontColor,
				strokeWidth: 5,
				id: random
			});
			console.log("addline");
			$scope.factory.canvas.add(lineSample);
			var rectSecondObj = $scope.findObjectWithPropertyValue($scope.factory.canvas, 'name', 'overlayImage');
			$scope.factory.canvas.bringToFront(rectSecondObj);
		}
	  
	    $scope.findObjectWithPropertyValue = function (canvas, propertyName, propertyValue) {
				var condition = {};
				condition[propertyName] = propertyValue;
				//return _(canvas.getObjects()).where( condition ).first()  /* _.where function deprecated as of v4.0.0 in favor of _.filter function */
			return _(canvas.getObjects()).filter( condition ).first()
		}

		$scope.getRandomSpan = function(){			
			do{
				var value = Math.floor((Math.random()*300)+1);
			}while($scope.randomNumberArray.includes(value))				
			return value;
		}
		
		$scope.addText = function () {
			  
			var random = $scope.getRandomSpan();
			random = "text" + random;
			var bkColor = $scope.factory.canvas.backgroundColor;
			var presetColor = 0;
			while(bkColor === $scope.paletteArray[presetColor].color){
				presetColor ++;
			}				
			// var canvas = CanvasFactory.getCanvas();
			var text = "Escribe tu texto..";
			var fontColor = $scope.paletteArray[presetColor].color;
			var fontFamily = "Allerta+Stencil";
			var textSample = new fabric.IText(text, {
			  left: 0,
			  top: 0,
			  fontSize: 20,
			  fontFamily: fontFamily,
			  angle: 0,
			  fill: fontColor,
			  scaleX: 3,
			  scaleY: 3,
			  fontWeight: '',
			  hasRotatingPoint: true,
			  id : random
			});
			$scope.factory.canvas.add(textSample);
			//$scope.factory.canvas.item(canvas.item.length - 1).hasRotatingPoint = true;
			$scope.factory.canvas.setActiveObject(textSample);
			var rectSecondObj = $scope.findObjectWithPropertyValue($scope.factory.canvas, 'name', 'overlayImage');
			$scope.factory.canvas.bringToFront(rectSecondObj);
		};

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
			//$scope.canvasTarget = false;
			// $scope.factory.canvas.renderTop();
		}
		
		$scope.addCircle = function(){
			
			var random = $scope.getRandomSpan();
			random = "circle" + random;
			var bkColor = $scope.factory.canvas.backgroundColor;
			var presetColor = 0;
			while(bkColor === $scope.paletteArray[presetColor].color){
				presetColor ++;
			}	
			
			var circle=new fabric.Circle({
				top: 0,
				left: 0,
				radius: 99,
				fill: $scope.paletteArray[presetColor].color,
				id: random
			});
			$scope.factory.canvas.add(circle);
			var rectSecondObj = $scope.findObjectWithPropertyValue($scope.factory.canvas, 'name', 'overlayImage');
			$scope.factory.canvas.bringToFront(rectSecondObj);
		}
		
		$scope.addTriangle = function(){
			
			var random = $scope.getRandomSpan();
			random = "triangle" + random;
			var bkColor = $scope.factory.canvas.backgroundColor;
			var presetColor = 0;
			while(bkColor === $scope.paletteArray[presetColor].color){
				presetColor ++;
			}
			
			var triangle=new fabric.Triangle({
				top: 0,
				left: 0,
				radius: 99,
				fill: $scope.paletteArray[presetColor].color,
				id: random
			});
			$scope.factory.canvas.add(triangle);
			var rectSecondObj = $scope.findObjectWithPropertyValue($scope.factory.canvas, 'name', 'overlayImage');
			$scope.factory.canvas.bringToFront(rectSecondObj);
		}
		
		$scope.addRectangle = function(){
			
			var random = $scope.getRandomSpan();
			random = "rect" + random;
			var bkColor = $scope.factory.canvas.backgroundColor;
			var presetColor = 0;
			while(bkColor === $scope.paletteArray[presetColor].color){
				presetColor ++;
			}		
			
			var rectangle=new fabric.Rect({
				left: 0,
				top: 0,
				width: 100,
				height: 100,
				fill: $scope.paletteArray[presetColor].color,
				padding: 10,
				id:random
			});
			$scope.factory.canvas.add(rectangle);
			var rectSecondObj = $scope.findObjectWithPropertyValue($scope.factory.canvas, 'name', 'overlayImage');
			$scope.factory.canvas.bringToFront(rectSecondObj);
		}
		
		$scope.moveToFront = function(){
			var activeObject = $scope.factory.canvas.getActiveObject();
			$scope.factory.canvas.bringToFront(activeObject);
		}
		$scope.moveToBack = function(){
			var activeObject = $scope.factory.canvas.getActiveObject();
			$scope.factory.canvas.sendToBack(activeObject);
		}
		$scope.moveToBackward = function(){
			var activeObject = $scope.factory.canvas.getActiveObject();
			$scope.factory.canvas.sendBackwards(activeObject);
		}
		$scope.moveToForward = function(){
			var activeObject = $scope.factory.canvas.getActiveObject();
			$scope.factory.canvas.bringForward(activeObject);
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
		
		$scope.startCrop = function(){
			$scope.cropStarted = true;
			
			
			$scope.factory.canvas.remove($scope.el);
			if($scope.factory.canvas.getActiveObject())
			{
				
			$scope.object=$scope.factory.canvas.getActiveObject();
			
			if($scope.lastActive !== $scope.object)
			{console.log('different object');}	
			else{console.log('same object');}
			if ($scope.lastActive && $scope.lastActive !== $scope.object) 
			{
				$scope.lastActive.clipTo = null;
				 
			}
				
				
				
				$scope.el = new fabric.Rect
				({
					fill: 'rgba(0,0,0,0.3)',
					originX: 'left',
					originY: 'top',
					stroke: '#ccc',
					strokeDashArray: [2, 2],
					opacity: 1,
					width: 1,
					height: 1,
					borderColor: '#36fd00',
					cornerColor: 'green',
					hasRotatingPoint:false
				});
			
				$scope.el.left=$scope.factory.canvas.getActiveObject().left;
				$scope.selection_object_left=$scope.factory.canvas.getActiveObject().left;
				$scope.selection_object_top=$scope.factory.canvas.getActiveObject().top;
				$scope.el.top=$scope.factory.canvas.getActiveObject().top;
				$scope.el.width=$scope.factory.canvas.getActiveObject().width*$scope.factory.canvas.getActiveObject().scaleX;
				$scope.el.height=$scope.factory.canvas.getActiveObject().height*$scope.factory.canvas.getActiveObject().scaleY;
				
				
				$scope.factory.canvas.add($scope.el);
				$scope.factory.canvas.setActiveObject($scope.el);
				for(var i=0; i<$("#layers li").size();i++)
					{
						$scope.factory.canvas.item(i).selectable= false;
					}
			}
			
			else{
					alert("Please select an object or layer");
			}
		}
		
		$scope.crop = function(){
			$scope.cropStarted = false;
			var left = $scope.el.left - $scope.object.left;
			var top = $scope.el.top - $scope.object.top;
			left *= 1;
			top *= 1;
			
			var width = $scope.el.width * 1;
			var height = $scope.el.height * 1;
		    $scope.object.clipTo = function (ctx) 
			{
				
				ctx.rect(-($scope.el.width/2)+left, -($scope.el.height/2)+top, parseInt(width*$scope.el.scaleX), parseInt($scope.el.scaleY*height));
				
		 
			}
			
			
			
			for(var i=0; i<$("#layers li").size();i++)
				{
					$scope.factory.canvas.item(i).selectable= true;
				}
			disabled = true;
		   
			$scope.factory.canvas.remove($scope.factory.canvas.getActiveObject());
			$scope.lastActive = $scope.object;
			$scope.factory.canvas.renderAll();
			
		}
		
  });
