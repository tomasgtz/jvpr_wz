'use strict';



/**

 * @ngdoc function

 * @name newappApp.controller:MainCtrl

 * @description

 * # MainCtrl

 * Controller of the newappApp

 */



angular.module('newApp')

  .controller('SuggestionCtrl', function ($scope, campaignService, userService, applicationService, pluginsService, $log, objCampaign, generalService) {

		$scope.inbox = [];
		$scope.filterComment = "";
		
		$scope.filterCommentChange = function(value){
			$scope.filterComment = value;
		}
		
		generalService.GAdmin_Inbox()
			.then(function(data) {
				// console.log(data);
				$scope.inbox = data;
		})
		
  });

