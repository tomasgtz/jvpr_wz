
/**
 * @ngdoc function
 * @name newappApp.controller:SubscriptionCtrl
 * @description
 * # SubscriptionCtrl
 * Controller of the newappApp
 */

angular.module('newApp')
  .controller('SubscriptionCtrl', function ($scope, CanvasFactory, ngDialog, $rootScope, $timeout, ngDragDrop, ImagesFactory, UtilsFactory, AppSettings, campaignService, objCampaign , $location, userService, $route) {
	
	$scope.precio = "";
	$scope.alertShow = false;
	$scope.message = "";
	$scope.alertClass = "";
	$scope.precioBronce = 416;
	$scope.precioPlata = 1872;
	$scope.precioOro = 3900;
	$scope.precioPlatino = "Cotizar";
	$scope.precioUsuario = 1000;
	$scope.precioEspacio = 1000;
	$scope.styleBronce = {};
	$scope.stylePlata = {};
	$scope.styleOro = {};
	$scope.stylePlatino = {};
	$scope.styleUsuario = {};
	$scope.styleEspacio = {};
	$scope.type = 2;
	$scope.usuarioAgregado = 0;
	$scope.espacioAgregado = 0;
	$scope.subscripcionAgregada = 0;
	$scope.mensualidad = 0;
	$scope.extraUsuario = 0;
	$scope.extraEspacio = 0;
	$scope.total = 0;
	
	$scope.selectOption = function(value){
		
		if(value < 5){
			$scope.styleBronce = {};
			$scope.stylePlata = {};
			$scope.styleOro = {};
			$scope.stylePlatino = {};
			$scope.subscripcionAgregada = 0;
			$scope.mensualidad = 0;
		}
		
		if(value===1){
			$scope.styleBronce 	= { "background-color" : "#d0eed8" };
			$scope.subscripcionAgregada = 1;
			if($scope.type===1){
				$scope.mensualidad = 4680;
			}else{
				$scope.mensualidad = 416;
			}
		}
		if(value===2){
			$scope.stylePlata 	= { "background-color" : "#d0eed8" };
			$scope.subscripcionAgregada = 2;
			if($scope.type===1){
				$scope.mensualidad = 20904;
			}else{
				$scope.mensualidad = 1872;
			}
		}
		if(value===3){
			$scope.styleOro 	= { "background-color" : "#d0eed8" };
			$scope.subscripcionAgregada = 3;
			if($scope.type===1){
				$scope.mensualidad = 43680;
			}else{
				$scope.mensualidad = 3900;
			}
		}
		if(value===4){
			$scope.stylePlatino = { "background-color" : "#d0eed8" };
			$scope.subscripcionAgregada = 4;
			if($scope.type===1){
				$scope.mensualidad = "Solicitar cotización";
			}else{
				$scope.mensualidad = "Solicitar cotización";
			}
		}
		if(value===5){
			if($scope.usuarioAgregado 	=== 0){
				$scope.usuarioAgregado 	= 1;
				$scope.styleUsuario 	= { "background-color" : "#d0eed8" };
				$scope.extraUsuario = 1000;
			}else{
				$scope.usuarioAgregado 	= 0;
				$scope.styleUsuario 	= {  };
				$scope.extraUsuario = 0;
			}
		}
		if(value===6){
			if($scope.espacioAgregado 	=== 0){
				$scope.espacioAgregado 	= 1;
				$scope.styleEspacio 	= { "background-color" : "#d0eed8" };
				$scope.extraEspacio = 1000;
			}else{
				$scope.extraEspacio = 0;
				$scope.espacioAgregado 	= 0;
				$scope.styleEspacio 	= {  };
			}
		}		
		
		// $scope.total = $scope.mensualidad + $scope.extraUsuario + $scope.extraEspacio;
		$scope.total = $scope.mensualidad;
	}
	
	$scope.getPrice = function(){
		
		if($( "#selectprice" ).val() > 0){
			$scope.precio = $( "#selectprice" ).val();
			$scope.alertShow = false;
			$scope.message = "";
			$scope.alertClass = "";
		}else{
			$scope.alertShow = true;
			$scope.message = "Seleccionar un plan para calcular precio.";
			$scope.alertClass = "alert alert-warning";
		}		
	}
	
	/*INITIALIZE*/
	/*INITIALIZE*/
	$scope.anualButton = {    };
	
	$scope.monthButton = {
		"background-color" : "#44BBFF",
		"border-radius"	   : "15px",
		"color"	  		   : "white"
	};
	/*INITIALIZE*/
	/*INITIALIZE*/
	
	$scope.makeActive = function(type){
		
			$scope.styleBronce = {};
			$scope.stylePlata = {};
			$scope.styleOro = {};
			$scope.stylePlatino = {};
			$scope.styleUsuario = {};
			$scope.styleEspacio = {};
			$scope.usuarioAgregado = 0;
			$scope.espacioAgregado = 0;
			$scope.subscripcionAgregada = 0;
			$scope.mensualidad = 0;
			$scope.extraUsuario = 0;
			$scope.extraEspacio = 0;
			$scope.total = 0;
	
		if(type === 1){
			$scope.anualButton = {
				"background-color" : "#44BBFF",
				"border-radius"	   : "15px",
				"color"	  		   : "white"
			};
			
			$scope.precioBronce = 4680;
			$scope.precioPlata = 20904;
			$scope.precioOro = 43680;
			$scope.precioPlatino = "Cotizar";
			$scope.precioUsuario = 1000;
			$scope.precioEspacio = 1000;
			$scope.type = 1;
			
			$scope.monthButton = {  "cursor" : "pointer"  };
		}else{
			$scope.anualButton = {  "cursor" : "pointer"  };
			
			$scope.monthButton = {
				"background-color" : "#44BBFF",
				"border-radius"	   : "15px",
				"color"	  		   : "white"
			};
			
			$scope.precioBronce = 416;
			$scope.precioPlata = 1872;
			$scope.precioOro = 3900;
			$scope.precioPlatino = "Cotizar";
			$scope.precioUsuario = 1000;
			$scope.precioEspacio = 1000;
			$scope.type = 2;
		}
	}
	
	$scope.conekta = function(){
		
		var text = "";
										var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

										for( var i=0; i < 5; i++ ){
											text += possible.charAt(Math.floor(Math.random() * possible.length));
										}
										
										
		alert("{ 'Transaction' : 'successful', 'count' : '1', 'env' , "+text+" }");
		$route.reload();
	}
	
	userService.currentUser()
	.then(function(data) {
		if (data.id_user === undefined){
			$location.path('/');
		}else{
			$scope.currentUser = data;
		}			
	});
	
	$scope.allPlans=[
		{countryId : 1, name : "Suscripción Bronce" , price : 10},
        {countryId : 2, name : "Suscripción Plata" , price : 20},
        {countryId : 3, name : "Suscripción Oro" , price : 30},
        {countryId : 4, name : "Suscripción Platino" , price : 40},
        {countryId : 5, name : "Solicitar 1 usuario extra" , price : 50},
		{countryId : 6, name : "Paquete 2 usuarios extra" , price : 60},
		{countryId : 7, name : "Solicitar 1 GB de espacio" , price : 70},
		{countryId : 8, name : "Paquete 2 GB de espacio" , price : 80}
    ];  
	
  });
