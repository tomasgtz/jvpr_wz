'use strict';



/**

 * @ngdoc function

 * @name newappApp.controller:MainCtrl

 * @description

 * # MainCtrl

 * Controller of the newappApp

 */



angular.module('newApp')

  .controller('HistoryCtrl', function ($scope, campaignService, userService, applicationService, pluginsService, $log, objCampaign, generalService, Excel, $timeout) {

		$scope.history = [];
		$scope.filterGeneral = "";
		$scope.filterCampaign = "";
		$scope.companiesArray = [];
		
		$scope.filterCampaignChange = function(value){
			$scope.filterCampaign = value;
		}
		
		$scope.filterGeneralChange = function(value){
			$scope.filterGeneral = value;
		}
		
		// generalService.GetHistory()
			// .then(function(data) {
				// // console.log(data);
				// $scope.history.push(data[0]);
				// $scope.history.push(data[1]);
				// console.log($scope.history);
		// })
		
		generalService.GCompanies()
			.then(function(data) {
				$scope.companiesArray = data;
		})
		
		$scope.getHistoryCompany = function(){
			
			var params = {
				"idcompany_p" : ""
			}
			params.idcompany_p = $( "#selectcompany" ).val();
			
			generalService.GetHistory(params)
				.then(function(data) {
					$scope.history = data;
			})
		}
		// $( "#selectcompany" ).val();
		// $scope.exportData = function () {
			// var blob = new Blob([document.getElementById('movements').innerHTML], {
				// type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8"
			// });
			// saveAs(blob, "Reporte de Movimientos.xls");
		// };
		
		// $("#btnExport").click(function (e) {
			// window.open('data:application/vnd.ms-excel,' + $('#dvData').html());
			// e.preventDefault();
		// });
		
		$scope.exportToExcel=function(tableId){ // ex: '#my-table'
            var exportHref=Excel.tableToExcel(tableId,'WireWorkbenchDataExport');
            $timeout(function(){location.href=exportHref;},100); // trigger download
        }
		
  });

