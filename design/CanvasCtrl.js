'use strict';

/**
 * @ngdoc function
 * @name newappApp.controller:CanvasCtrl
 * @description
 * # CanvasCtrl
 * Controller of the newappApp
 */

angular.module('newApp')
  .controller('CanvasCtrl', function ($scope, $rootScope, CanvasFactory, $timeout) {
	
		// ViewModel
	  var vm = this;

	  vm.isObjectSelected = false;

	  //on object selection
	  $rootScope.$on("objectSelected", function () {
		$timeout(function () {
		  vm.isObjectSelected = true;
		}, 0);
	  });

	  //on object cleared
	  $rootScope.$on("objectCleared", function () {
		$timeout(function () {
		  vm.isObjectSelected = false;
		}, 0);
	  });

	  //delete selected object
	  vm.deleteSelectedObject = function () {
		var canvas = CanvasFactory.getCanvas();
		var activeObject = canvas.getActiveObject();
		canvas.remove(activeObject);
	  };

	  //add text
	  vm.addText = function () {
		var canvas = CanvasFactory.getCanvas();
		var text = "Sample Text";
		var fontColor = "#000";
		var fontFamily = "Allerta+Stencil";
		var textSample = new fabric.IText(text, {
		  left: fabric.util.getRandomInt(10, 100),
		  top: fabric.util.getRandomInt(10, 200),
		  fontFamily: 'helvetica',
		  angle: 0,
		  fill: '#000000',
		  scaleX: 0.5,
		  scaleY: 0.5,
		  fontWeight: '',
		  hasRotatingPoint: true
		});
		canvas.add(textSample);
		canvas.item(canvas.item.length - 1).hasRotatingPoint = true;
		canvas.setActiveObject(textSample);
	  };

	  //paint the canvas
	  vm.paintBrush = function () {
		alert("Sorry :( not yet implemented...");
	  };

	  //reset the board
	  vm.resetBoard = function () {
		var canvas = CanvasFactory.getCanvas();
		canvas.clear();
	  };
		
  });
