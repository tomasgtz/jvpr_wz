

angular.module('newApp').service('userService', function($http,$q){
	
	var UserContext = {
				"id_user" 			: "",
				"name" 				: "",
				"password" 			: "",
				"type" 				: "",
				"typenum"    		: "",
				"image"				: "",
				"date_up" 			: "",
				"date_update" 		: "",
				"home_phone" 		: "",
				"mobile_phone" 		: "",
				"fk_company" 		: "",
				"status" 			: "",
				"address" 			: "",
				"logo" 				: "",
				"company_name" 		: "",
				"company_status"	: "",
				"company_update" 	: "",
				"pc" 				: "",
				"city" 				: "",
				"web_page" 			: "",
				"industry" 			: "",
				"no_employees" 		: "",
				"subs_description"	: "",
				"id_company"		: ""
			}
			
	
	return { 
	
		authenticationUser : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: 'http://test.mbledteq.com/serviciosWizad.php/Authentication',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { email_p : params.email_p , password_p : params.password_p  }
			})
			.success(function(data) {
				if(data[0] !== undefined){
					UserContext.id_user 	 	 = data[0].id_user;
					UserContext.name 		 	 = data[0].name;
					UserContext.password 	 	 = data[0].password;
					UserContext.type 		 	 = data[0].type;
					UserContext.typenum		 	 = data[0].typenum;
					UserContext.image 		 	 = data[0].image;
					UserContext.date_up 	 	 = data[0].date_up;
					UserContext.date_update  	 = data[0].date_update;
					UserContext.home_phone 	 	 = data[0].home_phone;
					UserContext.mobile_phone 	 = data[0].mobile_phone;
					UserContext.fk_company 	 	 = data[0].fk_company;
					UserContext.status 		 	 = data[0].status;
					UserContext.address 		 = data[0].address;
					UserContext.logo 		 	 = data[0].logo;
					UserContext.company_name  	 = data[0].company_name;
					UserContext.company_status 	 = data[0].company_status;
					UserContext.company_update 	 = data[0].company_update;	
					UserContext.pc 		 		 = data[0].pc;
					UserContext.city 			 = data[0].city;
					UserContext.web_page 		 = data[0].web_page;
					UserContext.industry 		 = data[0].industry;
					UserContext.no_employees 	 = data[0].no_employees;	
					UserContext.subs_description = data[0].subs_description;	
					UserContext.id_company 	     = data[0].id_company;	
					
				}
				
				defered.resolve(data);		
			})
			.error(function(data){
				defered.reject(err)
			})
			return promise;
			
		},
	
		currentUser : function(){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			defered.resolve(UserContext);
			return promise;
			
		}
	
	}

})



angular.module('newApp').service('generalService', function($http,$q){
	
	
	return { 
	
		saveCompanyData : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
			
			$http({
			method: 'POST',
			url: 'http://test.mbledteq.com/serviciosWizad.php/UCompany',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { name_p : params.name_p , address_p : params.address_p,  company_p : params.company_p,
					industry_p : params.industry_p , noemployees_p : params.noemployees_p,  
					webpage_p : params.webpage_p, pc_p : params.pc_p 
				  }
			})
			.success(function(data) {
				if(data[0] !== undefined){
					
				}
				
				defered.resolve(data);		
			})
			.error(function(data){
				defered.reject(err)
			})
			return promise;
			
		},
		
		saveUserData : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
			
			$http({
			method: 'POST',
			url: 'http://test.mbledteq.com/serviciosWizad.php/UUser',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { name_p : params.name_p , password_p : params.password_p,  
					mobilephone_p : params.mobilephone_p, homephone_p : params.homephone_p, iduser_p : params.iduser_p
				  }
			})
			.success(function(data) {
				if(data[0] !== undefined){
					
				}
				
				defered.resolve(data);		
			})
			.error(function(data){
				defered.reject(err)
			})
			return promise;
			
		},
		
		getUsersCompany : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
			
			$http({
			method: 'POST',
			url: 'http://test.mbledteq.com/serviciosWizad.php/GUserCompany',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { idcompany_p : params.idcompany_p}
			})
			.success(function(data) {
				if(data[0] !== undefined){
					
				}
				
				defered.resolve(data);		
			})
			.error(function(data){
				defered.reject(err)
			})
			return promise;
			
		},
		
		getTextsCompany : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
			
			$http({
			method: 'POST',
			url: 'http://test.mbledteq.com/serviciosWizad.php/GTextsCompany',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { idcompany_p : params.idcompany_p}
			})
			.success(function(data) {
				if(data[0] !== undefined){
					
				}
				
				defered.resolve(data);		
			})
			.error(function(data){
				defered.reject(err)
			})
			return promise;
			
		},
		
		getPaletteCompany : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
			
			$http({
			method: 'POST',
			url: 'http://test.mbledteq.com/serviciosWizad.php/GPaletteCompany',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { idcompany_p : params.idcompany_p}
			})
			.success(function(data) {
				if(data[0] !== undefined){
					
				}
				
				defered.resolve(data);		
			})
			.error(function(data){
				defered.reject(err)
			})
			return promise;
			
		},
		
		saveTextConfigs : function(params){
			var defered = $q.defer();
			var promise = defered.promise;
			var x = angular.toJson(params.textconfig_p);	
			$http({
			method: 'POST',
			url: 'http://test.mbledteq.com/serviciosWizad.php/NewCompany_TextConfig',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { company_p : params.company_p, textconfig_p : x}
			})
			.success(function(data) {
				if(data[0] !== undefined){
					
				}
				
				defered.resolve(data);		
			})
			.error(function(data){
				defered.reject(err)
			})
			return promise;
		},
		
		savePalette : function(params){
			var defered = $q.defer();
			var promise = defered.promise;
			var x = angular.toJson(params.color_p);	
			$http({
			method: 'POST',
			url: 'http://test.mbledteq.com/serviciosWizad.php/NewCompany_Palette',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { company_p : params.company_p, color_p : x}
			})
			.success(function(data) {
				if(data[0] !== undefined){
					
				}
				
				defered.resolve(data);		
			})
			.error(function(data){
				defered.reject(err)
			})
			return promise;
		},
		
		AllUsersAdmin : function(){
			var defered = $q.defer();
			var promise = defered.promise;
			$http({
			method: 'POST',
			url: 'http://test.mbledteq.com/serviciosWizad.php/AllUsersAdmin',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			}
			})
			.success(function(data) {
				if(data[0] !== undefined){
					
				}
				
				defered.resolve(data);		
			})
			.error(function(data){
				defered.reject(err)
			})
			return promise;
		},
		
		AllCompaniesAdmin : function(){
			var defered = $q.defer();
			var promise = defered.promise;
			$http({
			method: 'POST',
			url: 'http://test.mbledteq.com/serviciosWizad.php/AllCompaniesAdmin',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			}
			})
			.success(function(data) {
				if(data[0] !== undefined){
					
				}
				
				defered.resolve(data);		
			})
			.error(function(data){
				defered.reject(err)
			})
			return promise;
		},
		
		NewUser : function(params){
			var defered = $q.defer();
			var promise = defered.promise;
			$http({
			method: 'POST',
			url: 'http://test.mbledteq.com/serviciosWizad.php/NewUser',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { company_p : params.company_p, name_p : params.name_p, password_p : params.password_p, homephone_p : params.homephone_p, mobilephone_p : params.mobilephone_p}
			})
			.success(function(data) {
				if(data[0] !== undefined){
					
				}
				
				defered.resolve(data);		
			})
			.error(function(data){
				defered.reject(err)
			})
			return promise;
		},
		
		NewCompany : function(params){
			var defered = $q.defer();
			var promise = defered.promise;
			$http({
			method: 'POST',
			url: 'http://test.mbledteq.com/serviciosWizad.php/NewCompany',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { name_p : params.name_p, address_p : params.address_p, noemployees_p : params.noemployees_p, industry_p : params.industry_p, webpage_p : params.webpage_p , pc_p : params.pc_p}
			})
			.success(function(data) {
				if(data[0] !== undefined){
					
				}
				
				defered.resolve(data);		
			})
			.error(function(data){
				defered.reject(err)
			})
			return promise;
		},
		
		CountSubscriptions : function(){
			var defered = $q.defer();
			var promise = defered.promise;
			$http({
			method: 'POST',
			url: 'http://test.mbledteq.com/serviciosWizad.php/CountSubscriptions',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			}
			})
			.success(function(data) {
				if(data[0] !== undefined){
					
				}
				
				defered.resolve(data);		
			})
			.error(function(data){
				defered.reject(err)
			})
			return promise;
		},
		
		NewCampaign : function(params){
			var defered = $q.defer();
			var promise = defered.promise;
			$http({
			method: 'POST',
			url: 'http://test.mbledteq.com/serviciosWizad.php/NewCampaign',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { name_p : params.name_p, description_p : params.description_p}
			})
			.success(function(data) {
				if(data[0] !== undefined){
					
				}
				
				defered.resolve(data);		
			})
			.error(function(data){
				defered.reject(err)
			})
			return promise;
		}
	}
})





angular.module('newApp').controller('mainCtrl',
    ['$scope', 'applicationService', 'quickViewService', 'builderService', 'pluginsService', '$location', 'userService',
        function ($scope, applicationService, quickViewService, builderService, pluginsService, $location, userService) {
            
			
			$scope.showLoggin = true;
			$scope.indexClass = "sidebar-condensed account2";
			$scope.username = "";
			$scope.password = "";
			$scope.alertShow = false;
			
			
			$(document).ready(function () {
                applicationService.init();
                quickViewService.init();
                builderService.init();
                pluginsService.init();
                Dropzone.autoDiscover = false;
            });

            $scope.$on('$viewContentLoaded', function () {
                pluginsService.init();
                applicationService.customScroll();
                applicationService.handlePanelAction();
                $('.nav.nav-sidebar .nav-active').removeClass('nav-active active');
                $('.nav.nav-sidebar .active:not(.nav-parent)').closest('.nav-parent').addClass('nav-active active');

                if($location.$$path == '/' || $location.$$path == '/layout-api'){
                    $('.nav.nav-sidebar .nav-parent').removeClass('nav-active active');
                    $('.nav.nav-sidebar .nav-parent .children').removeClass('nav-active active');
                    if ($('body').hasClass('sidebar-collapsed') && !$('body').hasClass('sidebar-hover')) return;
                    if ($('body').hasClass('submenu-hover')) return;
                    $('.nav.nav-sidebar .nav-parent .children').slideUp(200);
                    $('.nav-sidebar .arrow').removeClass('active');
                }
                if($location.$$path == '/'){
                    $('body').addClass('dashboard');
                }
                else{
                    $('body').removeClass('dashboard');
                }

            });

            $scope.isActive = function (viewLocation) {
                return viewLocation === $location.path();
            };
			
			
			
			
			$scope.tryLoggin = function(){
				if($scope.username === "" || $scope.password === ""){
					$scope.message = "Su usuario o contraseña es inválido.";
					$scope.alertClass = "alert alert-warning";
					$scope.alertShow = true;
				}else{
					
					var params = {
						"email_p" : "",
						"password_p" : ""
					}
					
					params.email_p = $scope.username;
					params.password_p = $scope.password;
					
					userService.authenticationUser(params)
					.then(function(data) {
						if(data[0] === undefined){
							$scope.message = "Su usuario o contraseña es inválido.";
							$scope.alertClass = "alert alert-warning";
							$scope.alertShow = true;
						}
							
						else{
							userService.currentUser()
							.then(function(data) {
								$scope.currentUser = data;
								$scope.showLoggin = false;
								$scope.indexClass = "fixed-topbar fixed-sidebar theme-sdtl color-default";
								if($scope.currentUser.typenum === '1'){
									$location.path('/admin-dashboard');
								}
								if($scope.currentUser.typenum === '2'){
									$location.path('/');
								}
								if($scope.currentUser.typenum === '3'){
									$location.path('/design-dashboard');
								}	
								if($scope.currentUser.typenum === '4'){
									$location.path('/designi-dashboard');
								}								
							});
						}		
					})
				}		
			}
			
			$scope.logOut = function(){
				$scope.showLoggin = true;
				$scope.indexClass = "sidebar-condensed account2";
				$scope.username = "";
				$scope.password = "";
				$scope.alertShow = false;
				$location.path('/');
			}

}]);

