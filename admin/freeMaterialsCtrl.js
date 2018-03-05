'use strict';

angular.module('newApp').controller('freeMaterialsCtrl', function ($scope, userService, generalService, campaignService) {
	
	$scope.alertUserClass = "";
	$scope.alertUserShow = false;
	$scope.description_p ="";
	
	$scope.closeAlert = function(){
		$scope.alertUserShow = false;
	}
	
	userService.currentUser()
	.then(function(data) {
		if (data.id_user === undefined){
			$location.path('/');
		}else{
			$scope.currentUser = data;
		}			
	});
	
	var params = {
		"novalues" : ""
	}
	
	campaignService.GMaterials(params)
	.then(function(data) {
		$scope.allMaterials = data;
	})
	
	$scope.deleteMaterial = function(mat){
		$scope.selectedMaterial = mat;
	}
	
	$scope.chngMaterialStatus = function(idmaterial, status){
		
		var params = {
			"idmaterial_p"  :  "",
			"status_p"	:  ""
		}
		
		params.idmaterial_p		= idmaterial;
		params.status_p			= status;
		
		generalService.UMaterialStatus(params)
		.then(function(data) {
			if(data[0].returnMessage === 'SUCCESS'){
				
				$scope.messageUser 	 = "Datos actualizados exitosamente.";
				$scope.alertUserClass = "alert alert-success";
				$scope.alertUserShow  = true;
				
				
							
			}else{
				
				$scope.messageUser 	 = "Ocurrió un error en la aplicación, favor de contactar soporte.";
				$scope.alertUserClass = "alert alert-danger";
				$scope.alertUserShow  = true;
				
			}
		})
	}
	
	$scope.chngFreeMaterial = function(idmaterial, status){
		
		var params = {
			"idmaterial_p"  :  "",
			"free_p"	:  ""
		}
		
		params.idmaterial_p		= idmaterial;
		params.free_p			= status;
		
		generalService.UFreeMaterial(params)
		.then(function(data) {
			if(data[0].returnMessage === 'SUCCESS'){
				
				$scope.messageUser 	 = "Datos actualizados exitosamente.";
				$scope.alertUserClass = "alert alert-success";
				$scope.alertUserShow  = true;
				
				
							
			}else{
				
				$scope.messageUser 	 = "Ocurrió un error en la aplicación, favor de contactar soporte.";
				$scope.alertUserClass = "alert alert-danger";
				$scope.alertUserShow  = true;
				
			}
		})
	}
	
	$scope.saveMaterial = function(){
		
		var params = {
			"description_p" : "",
			"width_p" : "",
			"height_p" : ""
		}
		params.description_p 	= $scope.description_p;
		params.width_p 			= $scope.width_p;
		params.height_p 		= $scope.height_p;
		 
		 
		generalService.IMaterial(params)
		.then(function(data) {
			if(data[0].returnMessage === 'SUCCESS'){
				
				$scope.messageUser 	 = "Material agregado exitosamente.";
				$scope.alertUserClass = "alert alert-success";
				$scope.alertUserShow  = true;
				
				campaignService.GMaterials(params)
				.then(function(data) {
					$scope.allMaterials = data;
				})
				
							
			}else{
				
				$scope.messageUser 	 = "Ocurrió un error en la aplicación, favor de contactar soporte.";
				$scope.alertUserClass = "alert alert-danger";
				$scope.alertUserShow  = true;
				
			}
		})
	}
	
	
	// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // 
	
	
	
	
	//  BEGIN - * UI - SCOPES *
	$scope.selectedUser = {};
	//  END	  - * UI - SCOPES *
	
	//  BEGIN - * APPLICATION USER LOGGED-IN * 
	
	userService.currentUser()
	.then(function(data) {
		if (data.id_user === undefined){
			$location.path('/');
		}else{
			$scope.currentUser = data;
		}			
	});
	
	//  END   - * APPLICATION USER LOGGED-IN * 
	
	var params = {
		"idcompany_p" : ""
	}
		
	params.idcompany_p = $scope.currentUser.id_company;
	
	generalService.getUsersCompany(params)
		.then(function(data) {
			$scope.allUsers = data;
	})
	
	$scope.closeAlert = function(){
		$scope.alertUserShow = false;
	}
	
	$scope.selectedUserForDelete = function(user){
		$scope.selectedUser = user;
	}
	
	$scope.newUserStatus = function(userid, status){
		
		var params = {
			"status_p"  :  "",
			"user_p"	:  ""
		}
		
		params.status_p		= status;
		params.user_p		= userid;
		
		generalService.UUserStatus(params)
		.then(function(data) {
			if(data[0].returnMessage === 'SUCCESS'){
				
				$scope.messageUser 	 = "Datos actualizados exitosamente.";
				$scope.alertUserClass = "alert alert-success";
				$scope.alertUserShow  = true;
				
				
							
			}else{
				
				$scope.messageUser 	 = "Ocurrió un error en la aplicación, favor de contactar soporte.";
				$scope.alertUserClass = "alert alert-danger";
				$scope.alertUserShow  = true;
				
			}
		})
	}
	
	$scope.eraseUser = function(){
		
		var params = {
			"user_p"	:  ""
		}
		
		params.user_p		= $scope.selectedUser.id_user;
		
		generalService.DUser(params)
		.then(function(data) {
			if(data[0].returnMessage === 'SUCCESS'){
				
				$scope.messageUser 	 = "Usuario eliminado exitosamente.";
				$scope.alertUserClass = "alert alert-success";
				$scope.alertUserShow  = true;
				
				var params = {
					"idcompany_p" : ""
				}
					
				params.idcompany_p = $scope.currentUser.id_company;
				
				generalService.getUsersCompany(params)
					.then(function(data) {
						$scope.allUsers = data;
				})
							
			}else{
				
				$scope.messageUser 	 = "Ocurrió un error en la aplicación, favor de contactar soporte.";
				$scope.alertUserClass = "alert alert-danger";
				$scope.alertUserShow  = true;
				
			}
		})
	}
	
	
	
	
});
