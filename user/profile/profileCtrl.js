'use strict';

angular.module('newApp').controller('profileCtrl', function ($scope, userService, generalService, $timeout) {

    $scope.images = [];
	
	userService.currentUser()
	.then(function(data) {
		if (data.id_user === undefined){
			$location.path('/');
		}else{
			$scope.currentUser = data;
		}			
	});
	
	var initializing = true
	
	$scope.$watch('currentUser.image', function(newValue, oldValue) {
		if(newValue != oldValue && oldValue != undefined){
				$scope.updatePhoto();
			}
	});
	
	$scope.$watch('currentUser.logo', function(newValue, oldValue) {
		if(newValue != oldValue && oldValue != undefined){
				$scope.updateLogo();
			}
	});
	
	$scope.updatePhoto = function(){
		
		var params = {
			"userid" : "",
			"photo" : ""
		}
		params.userid 			= $scope.currentUser.id_user;
		params.photo 			= $scope.currentUser.image;
		
		generalService.saveUserPhoto(params)
		.then(function(data) {
			if(data[0].returnMessage === 'SUCCESS'){
								
				$scope.messageCompany 	 = "Foto actualizada exitosamente.";
				$scope.alertCompanyClass = "alert alert-success";
				$scope.alertCompanyShow  = true;
				
			}else{
				
				$scope.messageCompany 	 = "Ocurrió un error en la aplicación, intenté de nuevo más tarde.";
				$scope.alertCompanyClass = "alert alert-danger";
				$scope.alertCompanyShow  = true;
				
			}
		})
	}
	
	$scope.updateLogo = function(){
		
		var params = {
			"userid" : "",
			"photo" : ""
		}
		params.userid 			= $scope.currentUser.id_user;
		params.photo 			= $scope.currentUser.logo;
		
		generalService.saveUserLogo(params)
		.then(function(data) {
			if(data[0].returnMessage === 'SUCCESS'){
								
				$scope.messageCompany 	 = "Foto actualizada exitosamente.";
				$scope.alertCompanyClass = "alert alert-success";
				$scope.alertCompanyShow  = true;
				
			}else{
				
				$scope.messageCompany 	 = "Ocurrió un error en la aplicación, intenté de nuevo más tarde.";
				$scope.alertCompanyClass = "alert alert-danger";
				$scope.alertCompanyShow  = true;
				
			}
		})
	}
	
	$scope.saveCompanyData = function(){
		
		var params = {
			"name_p" : "",
			"address_p" : "",
			"company_p" : "",
			"industry_p" : "",
			"noemployees_p" : "",
			"webpage_p" : "",
			"pc_p" : ""
		}
		params.name_p 			= $scope.currentUser.company_name;
		params.address_p 		= $scope.currentUser.address;
		params.company_p 		= $scope.currentUser.id_company;
		params.industry_p 		= $scope.currentUser.industry;
		params.noemployees_p 	= $scope.currentUser.no_employees;
		params.webpage_p 		= $scope.currentUser.web_page;
		params.pc_p 			= $scope.currentUser.pc;
		
		generalService.saveCompanyData(params)
		.then(function(data) {
			if(data[0].returnMessage === 'SUCCESS'){
				var params = {
					"email_p" : "",
					"password_p" : ""
				}
				
				params.email_p = $scope.currentUser.name;
				params.password_p = $scope.currentUser.password;
				
				userService.authenticationUser(params)
				.then(function(data) {					
					userService.currentUser()
					.then(function(data) {
						$scope.currentUser = data;	
					});							
				})
				
				$scope.messageCompany 	 = "Datos actualizados exitosamente.";
				$scope.alertCompanyClass = "alert alert-success";
				$scope.alertCompanyShow  = true;
				
			}else{
				
				$scope.messageCompany 	 = "Ocurrió un error en la aplicación, intenté de nuevo más tarde.";
				$scope.alertCompanyClass = "alert alert-danger";
				$scope.alertCompanyShow  = true;
				
			}
		})
	}
	
	$scope.saveUserData = function(){
 
		var params = {
			"name_p" : "",
			"password_p" : "",
			"mobilephone_p" : "",
			"homephone_p" : "",
			"iduser_p" : ""
		}
		params.name_p 			= $scope.currentUser.name;
		params.password_p 		= $scope.currentUser.password;
		params.mobilephone_p 	= $scope.currentUser.mobile_phone;
		params.homephone_p 		= $scope.currentUser.home_phone;
		params.iduser_p 		= $scope.currentUser.id_user;
		
		generalService.saveUserData(params)
		.then(function(data) {
			if(data[0].returnMessage === 'SUCCESS'){
				var params = {
					"email_p" : "",
					"password_p" : ""
				}
				
				params.email_p = $scope.currentUser.name;
				params.password_p = $scope.currentUser.password;
				
				userService.authenticationUser(params)
				.then(function(data) {					
					userService.currentUser()
					.then(function(data) {
						$scope.currentUser = data;	
					});							
				})
				
				$scope.messageUser 	 	= "Datos actualizados exitosamente.";
				$scope.alertUserClass 	= "alert alert-success";
				$scope.alertUserShow  	= true;
				
			}else{
				
				$scope.messageUser	 	= "Ocurrió un error en la aplicación, intenté de nuevo más tarde.";
				$scope.alertUserClass 	= "alert alert-danger";
				$scope.alertUserShow  	= true;
				
			}
		})
	}
	
	$scope.uploadSticker = function () {
		$timeout(function () {
		  //Notify $digest cycle hack
		  $('#sticker_upload').trigger('click');
		}, 0);
	};
	
	$scope.onFileUpload = function () {
		$scope.images = [];
		var image = {
			src: $scope.previewImages[0]
		};
		
		$scope.images.push(image);
		console.log($scope.images);
		console.log("preview");
		console.log($scope.previewImages);
		$scope.previewImages = [];
		var sticker = {
		  src: $scope.previewImages[0],
		  title: "Nueva imagen",
		  isUserUploaded: true
		};
		
	  };
	
	$scope.closeAlertCompany = function(){
		$scope.alertCompanyShow = false;
	}
	
	$scope.closeAlert = function(){
		$scope.alertUserShow = false;
	}
	
	$scope.reloadAllData = function(){
		var params = {
			"email_p" : "",
			"password_p" : ""
		}
		params.email_p = $scope.currentUser.name;
		params.password_p = $scope.currentUser.password;
		
		userService.authenticationUser(params)
		.then(function(data) {
				userService.currentUser()
				.then(function(data) {
					$scope.currentUser = data;
				});
		})
	}
	
	
});


angular.module('newApp')
	.directive("fileread", [function () {
    return {
        scope: {
            fileread: "="
        },
        link: function (scope, element, attributes) {
            element.bind("change", function (changeEvent) {
                var reader = new FileReader();
                reader.onload = function (loadEvent) {
                    scope.$apply(function () {
                        scope.fileread = loadEvent.target.result;
                    });
                }
                reader.readAsDataURL(changeEvent.target.files[0]);
            });
        }
    }
}]);