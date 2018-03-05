'use strict';

angular.module('newApp')
  .controller('campaignMaterialsCtrl', function ($scope, $rootScope, $window, campaignService, userService, applicationService, pluginsService, $log, objCampaign , $location) {
     
	 $scope.CampaignSelected =  {

				"id_campaign" 	: "",
				"description" 	: "",
				"name" 			: "",
				"date_up" 		: "",
				"date_update" 	: "",
				"status" 		: ""
		}
	
	 $scope.goToDesign = function(){
		// objCampaign.setCampaign($scope.CampaignSelected);
			
		$location.path('/designer-mode');
		// $window.location.assign('/#/designer-mode');
	 };
	 
	 
	
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
			
			campaignService.GMaterialsCampaign(params)
			.then(function(data) {
				$scope.materialArray = data;
			})
		})
	 
  });
