'use strict';

/**
 * @ngdoc function
 * @name newappApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the newappApp
 */
angular.module('newApp')
  .controller('dashboardCtrl', ['$scope', 'userService', 'applicationService', 'pluginsService' , 'generalService', 'campaignService', 'Excel', '$timeout', function ($scope, userService, applicationService, pluginsService, generalService, campaignService, Excel, $timeout) {
		
		$scope.activeTab = true;
		$scope.visitCount = 0;
		$scope.campaignCount = 0;
		$scope.FreeUsers = 0;
		$scope.userCount = 0;
		$scope.sortType     = ''; // set the default sort type
		$scope.sortReverse  = false;  // set the default sort order
		$scope.showflag = false;
		$scope.searchValue = "";
		$scope.filterUsers = "";
		$scope.filterCompanies = "";
		$scope.saveUsers = [];
		$scope.alertExpiredClass = "";
		$scope.alertExpiredShow = false;
		$scope.messageExpired = "";
		$scope.filteredCampaigns = []
		,$scope.currentPage = 1
		,$scope.numPerPage = 10
		,$scope.maxSize = 5;
		$scope.alertUserShow = false;
		
		$scope.$watch('currentUser.logo', function(newValue, oldValue) {
			if(newValue != oldValue && oldValue != undefined){
					$scope.updateLogo();
				}
		});
		
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
		
		$scope.exportToExcel=function(tableId){ // ex: '#my-table'
            var exportHref=Excel.tableToExcel(tableId,'WireWorkbenchDataExport');
            $timeout(function(){location.href=exportHref;},100); // trigger download
        }
		
		// $scope.$watch('currentPage', function() {
			// var begin = (($scope.currentPage - 1) * $scope.numPerPage)
			// , end = begin + $scope.numPerPage;
			
			// $scope.filteredCampaigns = $scope.campaignListing.slice(begin, end);
		// });
	
		$scope.newCompanyStatus = function(companyid, status){
			
			var params = {
				"status_p"  :  "",
				"company_p"	:  ""
			}
			
			params.status_p		= status;
			params.company_p	= companyid;
			
			generalService.UCompanyStatus(params)
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
		
		$scope.closeAlert = function(){
			$scope.alertUserShow = false;
		}
	
	
		$scope.filterUsersChange = function(filterUsers){
			$scope.filterUsers = filterUsers;
		}
		
		$scope.filterCompaniesChange = function(filterCompanies){
			$scope.filterCompanies = filterCompanies;
		}
		
		$scope.showDescription = function (company){
			$scope.address = company.address;
			$scope.industry = company.industry;
			$scope.web_page = company.web_page;
		}
				
		userService.currentUser()
		.then(function(data) {
			if (data.id_user === undefined){
				$location.path('/');
			}else{
				$scope.currentUser = data;
				if($scope.currentUser.days_left < 0){
					$scope.messageExpired	 = "Cuenta expirada, para recontratación de plan en el módulo de contratación.";
					$scope.alertExpiredClass = "alert alert-warning";
					$scope.alertExpiredShow  = true;
				}
			}			
		});
		
		generalService.DashboardCount()
		.then(function(data) {
			$scope.visitCount = data[1][0].Visits;
			$scope.campaignCount = data[2][0].Campaigns;
			$scope.userCount = data[0][0].Users;	
			$scope.FreeUsers = data[3][0].FreeUsers;				
		})
			
			
		// $scope.textConfig = [
							// { id: 1, name: 'John' }, 
							// { id: 2, name: 'Smith' }, 
							// { id: 3, name: 'Allen' }, 
							// { id: 4, name: ' Johnson' }, 
							// { id: 5, name: 'Harris' }, 
							// { id: 6, name: ' Williams' }, 
							// { id: 7, name: 'David' }
							// ];
		// $scope.paletteConfig = [
							// { id: 1, color: '#735ea1' }, 
							// { id: 2, color: '#3476a6' }, 
							// { id: 3, color: '#e31647' }, 
							// { id: 4, color: '#20ba1d' }
							// ];
		$scope.newTextsArray 	= [];
		$scope.newPaletteArray 	= [];
		$scope.goldCount 		= 0;
		$scope.silverCount 		= 0;
		$scope.bronzeCount		= 0;
		$scope.platCount 		= 0;
							
		
		
		
		$scope.newText = function(){
			
			var newTextO    = { id_config: 0, text_config: '' };
			newTextO.id_config = $scope.textConfig.length+1;
			newTextO.text_config = "";
			$scope.textConfig.push(newTextO);
			$scope.newTextsArray.push(newTextO);
		}
		
		$scope.newPalette = function(newColor){
			var newPaletteO = { id_palette: 0, color: '' };
			newPaletteO.id_palette = $scope.paletteConfig.length+1;
			newPaletteO.color = newColor;
			$scope.paletteConfig.push(newPaletteO);
			$scope.newPaletteArray.push(newPaletteO);
		}
		
		$scope.changeUser = function(user){
			for(var i in $scope.saveUsers){
				if($scope.saveUsers[i].id_user === user.id_user){
					$scope.saveUsers.splice(i, 1);
				}
			}
			$scope.saveUsers.push(user);
		}
		
		$scope.searchValueChange = function(searchValue){
			$scope.searchValue = searchValue;
		}
		
		$scope.saveUserChanges = function(){
			
			if($scope.saveUsers.length === 0){
				$scope.messageColor	 = "No se hicieron modificaciones en las campañas libres.";
				$scope.alertColorClass = "alert alert-warning";
				$scope.alertColorShow  = true;
				return;
			}
			
			console.log("SaveUsers");
			var paramss = {
				"users" : ""
			}
			
			paramss.users = $scope.saveUsers;
			
			campaignService.UUserFreeCampaign(paramss)
			.then(function(data) {
				if(data[0].returnMessage === 'SUCCESS'){
					$scope.messageColor	 = "Datos actualizados exitosamente.";
					$scope.alertColorClass = "alert alert-success";
					$scope.alertColorShow  = true;
					$scope.saveUsers =[];
				}
				else{
					$scope.messageColor 	 = "Ocurrió un error en la aplicación, intenté de nuevo más tarde.";
					$scope.alertColorClass = "alert alert-danger";
					$scope.alertColorShow  = true;
				}
			})
		}
		
		$scope.typenum = $scope.currentUser.typenum;
		if($scope.typenum == '1'){
			$scope.subsimage = "bronze_medal.png";
		}
		if($scope.typenum == '2'){
			$scope.subsimage = "silver_medal.png";
		}
		if($scope.typenum == '3'){
			$scope.subsimage = "gold_medal.png";
		}
		
		 
		if ($('#dropzoneFrm .dz-default').length == 0) {
            $("#dropzoneFrm").dropzone({});
        }
		
		var params = {
			"idcompany_p" : ""
		}
		
		params.idcompany_p = $scope.currentUser.id_company;
		
		generalService.getUsersCompany(params)
		.then(function(data) {
			$scope.userListing = data;
		})
		
		$scope.fillCampaigns = function(){
			campaignService.myCampaigns(params)
			.then(function(data) {
				$scope.campaignListing = data;
				// var begin = (($scope.currentPage - 1) * $scope.numPerPage)
				// , end = begin + $scope.numPerPage;
				
				// $scope.filteredCampaigns = $scope.campaignListing.slice(begin, end);
			})
		}
		$scope.fillCampaigns();
		
		generalService.getPaletteCompany(params)
		.then(function(data) {
			$scope.paletteConfig = data;
		})
		generalService.AllUsersAdmin(params)
		.then(function(data) {
			$scope.allUsers = data;
		})
		generalService.AllCompaniesAdmin(params)
		.then(function(data) {
			$scope.allCompanies = data;
			for(var i in $scope.allCompanies){
				if($scope.allCompanies[i].days_left > 0 && $scope.allCompanies[i].days_left < 30){
					$scope.allCompanies[i].contract_status = "Expira pronto - "+ $scope.allCompanies[i].days_left+ " días";
				}else{
					if($scope.allCompanies[i].days_left >= 30 ){
						$scope.allCompanies[i].contract_status = "Activa - "+ $scope.allCompanies[i].days_left+ " días";
					}else{
						$scope.allCompanies[i].contract_status = "Expiró";
					}
				}
			}
		})
		generalService.CountSubscriptions()
		.then(function(data) {
			for (var i = 0; i<data.length; i++){
				if(data[i].fk_subscription === '1') {
					$scope.bronzeCount		= $scope.bronzeCount +1;
				}
				if(data[i].fk_subscription === '2') {
					$scope.silverCount		= $scope.silverCount +1;
				}
				if(data[i].fk_subscription === '3') {
					$scope.goldCount		= $scope.goldCount +1;
				}
				if(data[i].fk_subscription === '4') {
					$scope.platCount		= $scope.platCount +1;
				}
			}
		})
		
		$scope.saveTextConfigs = function(){
			var paramss = {
				"company_p" : "",
				"textconfig_p" : "",
			}
			
			paramss.company_p = $scope.currentUser.id_company;
			paramss.textconfig_p = $scope.newTextsArray;
			
			generalService.saveTextConfigs(paramss)
			.then(function(data) {
				if(data[0].returnMessage === 'SUCCESS'){
					$scope.messageText	 = "Datos actualizados exitosamente.";
					$scope.alertTextClass = "alert alert-success";
					$scope.alertTextShow  = true;
					$scope.newTextsArray = [];
				}
				else{
					$scope.messageText 	 = "Ocurrió un error en la aplicación, intenté de nuevo más tarde.";
					$scope.alertTextClass = "alert alert-danger";
					$scope.alertTextShow  = true;
				}
			})
		}
		
		$scope.savePalette = function(){
			var paramss = {
				"company_p" : "",
				"color_p" : "",
			}
			
			paramss.company_p = $scope.currentUser.id_company;
			paramss.color_p = $scope.newPaletteArray;
			
			generalService.savePalette(paramss)
			.then(function(data) {
				if(data[0].returnMessage === 'SUCCESS'){
					$scope.messageColor	 = "Datos actualizados exitosamente.";
					$scope.alertColorClass = "alert alert-success";
					$scope.alertColorShow  = true;
					$scope.newPaletteArray =[];
				}
				else{
					$scope.messageColor 	 = "Ocurrió un error en la aplicación, intenté de nuevo más tarde.";
					$scope.alertColorClass = "alert alert-danger";
					$scope.alertColorShow  = true;
				}
			})
		}
  }]);
