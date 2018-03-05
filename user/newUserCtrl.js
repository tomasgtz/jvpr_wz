'use strict';

angular.module('newApp').controller('newUserCtrl', function ($scope, userService, generalService) {
	
	
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
			for(var i in $scope.allUsers){
				if($scope.currentUser.id_user === $scope.allUsers[i].id_user){
					$scope.allUsers.splice(i, 1);
				}
			}
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
	
	$scope.saveUser = function(){
		
		var params = {
			"name_p" : "",
			"password_p" : "",
			"company_p" : "",
			"homephone_p" : "",
			"mobilephone_p" : "",
			"username_p" : ""
		}
		
		var randomstring = Math.random().toString(36).slice(-8);
		
		params.name_p 			= $scope.name_p;
		params.password_p 		= randomstring;
		params.company_p 		= $scope.currentUser.id_company;
		params.homephone_p 		= $scope.homephone_p;
		params.mobilephone_p 	= $scope.mobilephone_p;
		params.username_p		= $scope.username_p;
		 
		generalService.NewUser(params)
		.then(function(data) {
			if(data[0].returnMessage === 'SUCCESS'){
				
				$scope.messageUser 	 = "Datos actualizados exitosamente.";
				$scope.alertUserClass = "alert alert-success";
				$scope.alertUserShow  = true;
				$scope.name_p = "";
				$scope.password_p = "";
				$scope.homephone_p = "";
				$scope.mobilephone_p = "";
				
				
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
