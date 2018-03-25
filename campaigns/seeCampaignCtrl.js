'use strict';



/**

 * @ngdoc function

 * @name newappApp.controller:MainCtrl

 * @description

 * # MainCtrl

 * Controller of the newappApp

 */

var urlHost = 'https://wizad.mx/';
var urlHostEmpresas = 'https://empresas.wizad.mx/';



angular.module('newApp')

  .controller('seeCampaignCtrl', function ($scope, campaignService, userService, applicationService, pluginsService, $log, objCampaign) {

		$scope.imagesArray 		= [];
		$scope.imagesArrayCopy	= [];
		
		$scope.fontArray 		= [];
		$scope.fontArrayCopy	= [];
		
		$scope.paletteArray 	= [];
		$scope.paletteArrayCopy	= [];
		
		$scope.textArray 		= [];
		$scope.textArrayCopy	= [];
		
		$scope.materialArray 		= [];	
		$scope.materialArrayCopy	= [];	
		
		$scope.newTexts			= [];
		$scope.deletedTexts		= [];
		
		$scope.newPalettes		= [];
		$scope.deletedPalettes	= [];
		
		$scope.newImages		= [];
		$scope.deletedImages	= [];
		
		$scope.newFonts			= [];
		$scope.deletedFonts		= [];
		
		$scope.allMaterials 	= [];
		$scope.newMaterials		= [];
		$scope.deletedMaterials	= [];

		$scope.CampaignSelected =  {};
		$scope.liStyle = "1px solid black";
		
		$scope.newText = function(){
			var newTextO    = { id_config: 0, text_config: '' };			
			newTextO.id_config = $scope.textArray.length+2150;		
			newTextO.text_config = "";			
			$scope.textArray.push(newTextO);			
			$scope.newTexts.push(newTextO);
		};
		
		$scope.eraseText = function(selectedText){	
			var existOnOriginal = $scope.textArrayCopy.indexOf(selectedText);
			if(existOnOriginal>-1){
				$scope.deletedTexts.push(selectedText);		
			}
			var index = $scope.textArray.indexOf(selectedText);
			$scope.textArray.splice(index, 1);
			index = $scope.newTexts.indexOf(selectedText);
			$scope.newTexts.splice(index, 1);			
		};
		
		$scope.newPalette = function(newColor){
			var newPaletteO = { id_palette: 0, color: '' };
			newPaletteO.id_palette = $scope.paletteArray.length+2150;
			newPaletteO.color = newColor;
			$scope.newPalettes.push(newPaletteO);
			$scope.paletteArray.push(newPaletteO);
		};
		
		$scope.erasePalette = function(){	
			var existOnOriginal = $scope.paletteArrayCopy.indexOf($scope.pantoneDrop);
			console.log(existOnOriginal);
			console.log($scope.pantoneDrop);
			if(existOnOriginal>-1){
				$scope.deletedPalettes.push($scope.pantoneDrop);		
			}			
			var index = $scope.paletteArray.indexOf($scope.pantoneDrop);
			$scope.paletteArray.splice(index, 1);
			index = $scope.newPalettes.indexOf($scope.pantoneDrop);
			$scope.newPalettes.splice(index, 1);
		};
		
		$scope.pantoneToRemove = function (pantone){
			$scope.pantoneDrop = pantone;
		};
		
		$scope.materialSelected = function (material){
			
			var addMaterial = { id_material : "", description : "", width : "", height : "", thumbnail : "" };
			
			addMaterial.id_material = material.id_material;
			addMaterial.description	= material.description;
			addMaterial.width		= material.width;
			addMaterial.height		= material.height;
			addMaterial.thumbnail	= material.thumbnail;
			
			console.log(addMaterial);
			console.log(material);
			
			if(material.selected === "1"){
							
				$scope.materialArray.push(addMaterial);
				$scope.newMaterials.push(addMaterial);
				
			}
			
			if(material.selected === "0"){
				
				for(var i in $scope.materialArrayCopy){
					if($scope.materialArrayCopy[i].id_material === material.id_material){
						$scope.deletedMaterials.push(addMaterial);
					}
				}
				
				for(var i in $scope.materialArray){
					if($scope.materialArray[i].id_material === material.id_material){
						$scope.materialArray.splice(i, 1);
					}
				}
				
				for(var i in $scope.newMaterials){
					if($scope.newMaterials[i].id_material === material.id_material){
						$scope.newMaterials.splice(i, 1);
					}
				}
				
				// console.log($scope.materialArray);
				// console.log($scope.newMaterials);		
				// var index = $scope.materialArray.indexOf(addMaterial);
				// console.log(index);				
				// $scope.materialArray.splice(index, 1);
				// index = $scope.newMaterials.indexOf(addMaterial);	
				// console.log(index);						
				// $scope.newMaterials.splice(index, 1);
				
			}
			
		}

		/* Dropzone functions */
		var accepti = ".png,.jpg";
		var acceptf = ".ttf,.otf";
		
		var dzImages = new Dropzone('#dzImages', { addRemoveLinks: true , acceptedFiles: accepti });	
		var dzFonts  = new Dropzone('#dzFonts',  { addRemoveLinks: true , acceptedFiles: acceptf });		
		
		dzImages.on("success", function(file) {
						
			var newPack 	= { id_cgpack: 0, image: '' };
			newPack.id_cgpack = $scope.imagesArray.length+2150;
			newPack.image 	= file.name;
			console.log(newPack);
			
			$scope.imagesArray.push(newPack);
			$scope.newImages.push(newPack);
			console.log($scope.newImages);
			
		});
		dzImages.on("removedfile", function(file) {
			
			for(var i in $scope.imagesArrayCopy){
				
				var newPack 	= { id_cgpack: 0, image: '' };
				newPack.id_cgpack	= $scope.imagesArrayCopy[i].id_cgpack;
				newPack.image		= $scope.imagesArrayCopy[i].image;
					
				if(file.name === $scope.imagesArrayCopy[i].image){
										
					$scope.deletedImages.push(newPack);
							
				}
			}				
			
			for(var i in $scope.newImages){
			
				var newPack 	= { id_cgpack: 0, image: '' };
				newPack.id_cgpack	= $scope.newImages[i].id_cgpack;
				newPack.image		= $scope.newImages[i].image;
				
				if(file.name === $scope.newImages[i].image){
					
					var index = $scope.newImages.indexOf(newPack);				
					$scope.newImages.splice(index, 1);
					
				}
			
			}
			console.log($scope.deletedImages);
			console.log($scope.newImages);
			
		});
		
		dzFonts.on("success", function(file) {
						
			var newFont 		= { id_cgfont: 0, font: '' };
			newFont.id_cgfont 	= $scope.imagesArray.length+2150;
			newFont.font 		= file.name;
			console.log(newFont);
			
			$scope.fontArray.push(newFont);
			$scope.newFonts.push(newFont);
			console.log($scope.newFonts);
			
		});
		dzFonts.on("removedfile", function(file) {
			
			for(var i in $scope.fontArrayCopy){
				
				var newFont 		= { id_cgfont: 0, font: '' };
				newFont.id_cgfont	= $scope.fontArrayCopy[i].id_cgfont;
				newFont.font		= $scope.fontArrayCopy[i].font;
					
				if(file.name === $scope.fontArrayCopy[i].font){
										
					$scope.deletedFonts.push(newFont);
							
				}
			}				
			
			for(var i in $scope.newFonts){
			
				var newFont 		= { id_cgfont: 0, font: '' };
				newFont.id_cgfont	= $scope.newFonts[i].id_cgfont;
				newFont.font		= $scope.newFonts[i].font;
				
				if(file.name === $scope.newFonts[i].font){
					
					var index = $scope.newFonts.indexOf(newFont);				
					$scope.newFonts.splice(index, 1);
					
				}
			
			}
			console.log($scope.deletedFonts);
			console.log($scope.newFonts);
			
		});
		/* Dropzone functions */
		
		objCampaign.getCampaign()
		.then(function(data) {

			$scope.CampaignSelected = data;
			console.log("asd tom5 [" + data.download + "] loading campaign info");	
			
			if(data.download == '1') {
				$scope.CampaignSelected.download = true;
			} else {
			
				$scope.CampaignSelected.download = false;
			}
			
			var params = {
				"campaign_p" : ""
			}
			params.campaign_p = $scope.CampaignSelected.id_campaign;
			
			campaignService.GPaletteCampaign(params)
			.then(function(data) {
				$scope.paletteArray = data;
				for(var i in $scope.paletteArray){
					$scope.paletteArrayCopy.push($scope.paletteArray[i]);
				}
			})

			campaignService.GTextsCampaign(params)
			.then(function(data) {
				$scope.textArray = data;
				for(var i in $scope.textArray){
					$scope.textArrayCopy.push($scope.textArray[i]);
				}
			})
			
			campaignService.GMaterialsCampaign(params)
			.then(function(data) {
				$scope.materialArray = data;
				for(var i in $scope.materialArray){
					$scope.materialArrayCopy.push($scope.materialArray[i]);
				}	
				campaignService.GMaterials(params)
				.then(function(data) {
					$scope.allMaterials = data;
					console.log("All materials");
					for(var i in $scope.allMaterials){
						for(var j in $scope.materialArray){
							if($scope.allMaterials[i].id_material === $scope.materialArray[j].id_material){
								$scope.allMaterials[i].selected = "1";
								
								console.log($scope.allMaterials[i].selected);
							}
						}
					}
				})
			})	
			
			campaignService.GPackCampaign(params)
			.then(function(data) {				
				$scope.imagesArray = data;		
				for(var i in $scope.imagesArray){
					$scope.imagesArrayCopy.push($scope.imagesArray[i]);
					var mockFile = { name: $scope.imagesArray[i].image, size: 12345 };
					dzImages.options.addedfile.call(dzImages, mockFile);
					dzImages.options.thumbnail.call(dzImages, mockFile, urlHostEmpresas + 'uploads/' + $scope.imagesArray[i].image);
					dzImages.files.push(mockFile);
				}	
			})
			
			campaignService.GFontsCampaign(params)
			.then(function(data) {
				$scope.fontArray = data;
				console.log("cargando info de campaña 2" + data);
				
				for(var i in $scope.fontArray){
					console.log("font " + $scope.fontArray[i]);
					$scope.fontArrayCopy.push($scope.fontArray[i]);
					var mockFile = { name: $scope.fontArray[i].font, size: 12345 };
					dzFonts.options.addedfile.call(dzFonts, mockFile);
					dzFonts.files.push(mockFile);
				}					
			})
		})
		
		$scope.saveChanges = function(){
			
			var params = {
				"campaign_p" 		: "",
				"newTextArray" 		: "",
				"newPaletteArray" 	: "",
				"newMaterialArray" 	: "",
				"newPackArray" 		: "",
				"newFontArray" 		: "",
				"delTextArray" 		: "",
				"delPaletteArray" 	: "",
				"delMaterialArray" 	: "",
				"delPackArray" 		: "",
				"delFontArray" 		: "",
				"autorization"		: "",
				"description"		: "",
				"name"				: ""
			}
			
			params.campaign_p		= $scope.CampaignSelected.id_campaign;
			params.newTextArray		= $scope.newTexts;
			params.newPaletteArray	= $scope.newPalettes;
			params.newMaterialArray	= $scope.newMaterials;
			params.newPackArray		= $scope.newImages;
			params.newFontArray		= $scope.newFonts;
			params.delTextArray		= $scope.deletedTexts;
			params.delPaletteArray	= $scope.deletedPalettes;
			params.delMaterialArray	= $scope.deletedMaterials;
			params.delPackArray		= $scope.deletedImages;
			params.delFontArray		= $scope.deletedFonts;
			params.name				= $scope.CampaignSelected.campaign_name;
			params.description		= $scope.CampaignSelected.description;
			params.userupdate		= $scope.currentUser.id_user
			
			if( $scope.CampaignSelected.download	) {
				params.autorization = 1;
			} else {
				params.autorization = 0;
			}
			
			campaignService.SaveCampaignUpdate(params)
			.then(function(data) {
				console.log("Success");
				if(data[0].returnMessage === "SUCCESS"){
					$scope.message = "Se guardo la campaña exitosamente.";
					$scope.alertClass = "alert alert-success";
					$scope.alertShow = true;
					$scope.name 	  = "";
					$scope.desc 	  = "";
					$scope.noemp 	  = 0;
					$scope.industry   = "";
					$scope.webpage 	  = "";
					$scope.pc 		  = "";
					$scope.nameuser   = "";
					$scope.telhome 	  = "";
					$scope.telmobile  = "";
					$scope.optionCity = 0;
				}else{
					$scope.message = "Error al guardar la campaña, favor de intentar más tarde.";
					$scope.alertClass = "alert alert-warning";
					$scope.alertShow = true;
				}				
			})
			
		}
		
		
  });

