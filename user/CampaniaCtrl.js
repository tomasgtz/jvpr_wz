'use strict';

angular.module('newApp').controller('CampaniaCtrl', function ($scope, userService, generalService) {

   $scope.id_company = 0;
	
	userService.currentUser()
	.then(function(data) {
		if (data.id_user === undefined){
			$location.path('/');
		}else{
			$scope.currentUser = data;
		}			
	});
	
	generalService.AllCompaniesAdmin()
		.then(function(data) {
			$scope.allCompanies = data;
	})
	
	$scope.changeCompany = function(company){
		$scope.id_company = company.id_company;
	}
	
	$scope.saveCampaign = function(){
		
		var params = {
			"name_p" : "",
			"description_p" : ""
		}
		params.name_p 			= $scope.name_p;
		params.description_p 		= $scope.description_p;
		 
		 
		generalService.NewCampaign(params)
		.then(function(data) {
			$scope.messageUser 	 = "Datos actualizados exitosamente.";
				$scope.alertUserClass = "alert alert-success";
				$scope.alertUserShow  = true;
				$scope.name_p = "";
				$scope.description_p = "";
		})
	}
	
	
});
