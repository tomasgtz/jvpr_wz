
var webServiceUrl = 'https://empresas.wizad.mx/api/serviciosWizad.php/';

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
				"id_company"		: "",
				"free_campaign"		: "",
				"days_left"			: ""
			}
	
	
	return { 
	
		authenticationUser : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'Authentication',
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
					UserContext.image 		 	 = data[0].image != "" ? data[0].image : "http://www.wizadqa.mbledteq.com/nouserphoto.png";
					UserContext.date_up 	 	 = data[0].date_up;
					UserContext.date_update  	 = data[0].date_update;
					UserContext.home_phone 	 	 = data[0].home_phone;
					UserContext.mobile_phone 	 = data[0].mobile_phone;
					UserContext.fk_company 	 	 = data[0].fk_company;
					UserContext.status 		 	 = data[0].status;
					UserContext.address 		 = data[0].address;
					UserContext.logo 		 	 = data[0].logo != "" ? data[0].logo : "http://www.wizadqa.mbledteq.com/nobanneravailable.png";
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
					UserContext.free_campaign    = data[0].free_campaign;	
					UserContext.days_left    	 = data[0].days_left;	
					UserContext.UserName    	 = data[0].UserName;	
					//console.log(UserContext.image);
					//console.log(UserContext.logo);
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


angular.module('newApp').service('campaignService', function($http,$q){

	return{
		
		myCampaigns : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'Campaigns',
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
		
		UUserFreeCampaign : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
			var userArray 		= angular.toJson(params.users);		
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'UUserFreeCampaign',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { user : userArray}
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
		
		getMaterials : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'GMaterials',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			}})
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
		
		DCampaign : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'DCampaign',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { campaign_p : params.campaign_p}
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
		
		GPaletteCampaign : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'GPaletteCampaign',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { campaign_p : params.campaign_p}
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
		
		GTextsCampaign : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'GTextsCampaign',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { campaign_p : params.campaign_p}
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
		
		GMaterialsCampaign : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'GMaterialsCampaign',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { campaign_p : params.campaign_p}
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
		
		GPackCampaign : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'GPackCampaign',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { campaign_p : params.campaign_p}
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
		
		GPackIdentity : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'GPackIdentity',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { campaign_p : params.campaign_p}
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
		
		GFontsCampaign : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'GFontsCampaign',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { campaign_p : params.campaign_p}
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
		
		DPaletteCampaign : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'DPaletteCampaign',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { campaign_p : params.campaign_p}
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
		
		DTextsCampaign : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'DTextsCampaign',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { campaign_p : params.campaign_p}
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
		
		DMaterialsCampaign : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'DMaterialsCampaign',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { campaign_p : params.campaign_p}
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
		
		DPackCampaign : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'DPackCampaign',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { campaign_p : params.campaign_p}
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
		
		DFontsCampaign : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'DFontsCampaign',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { campaign_p : params.campaign_p}
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
		
		IFontCampaign : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'IFontCampaign',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { campaign_p : params.campaign_p}
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
		
		IPackCampaign : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'IPackCampaign',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { campaign_p : params.campaign_p}
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
		
		ITextCampaign : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'ITextCampaign',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { campaign_p : params.campaign_p}
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
		
		IMaterialCampaign : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'IMaterialCampaign',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { campaign_p : params.campaign_p}
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
		
		IPaletteCampaign : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'IPaletteCampaign',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { campaign_p : params.campaign_p}
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
		
		GMaterials : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'GMaterials',
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
		
		SaveNewCampaign : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'SaveNewCampaign',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { description_c : params.description_c, title_c : params.title_c, 
			autorization_c : params.autorization_c, company_p : params.company_p,
			segment_c: params.segment_c, city_c: params.city_c, age_c: params.age_c }
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
		
		SaveCampaignConfig : function(params){
			
			var defered 		= $q.defer();
			var promise 		= defered.promise;
			var textArray 		= angular.toJson(params.textconfig_p);		
			var paletteArray 	= angular.toJson(params.palette_p);
			var materialArray 	= angular.toJson(params.material_p);
			var packArray 		= angular.toJson(params.pack_p);
			var fontArray 		= angular.toJson(params.font_p);
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'SaveCampaignConfig',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { campaignid : params.campaignid, textconfig_p : textArray, 
					palette_p : paletteArray, material_p : materialArray,
					image_p : packArray, font_p : fontArray}
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
			url: webServiceUrl + 'NewCampaign_TextConfig',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { campaignid : params.campaignid, textconfig_p : x}
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
			url: webServiceUrl + 'NewCampaign_Palette',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { campaignid : params.campaignid, color_p : x}
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
		
		savePack : function(params){
			var defered = $q.defer();
			var promise = defered.promise;
			$http({
			method: 'POST',
			url: webServiceUrl + 'NewCampaign_Pack',
			headers: {'Content-Type': undefined},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { campaignid : params.campaignid, baseimage : params.baseimage, imagename : params.imagename}
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
		
		GCampaignMaterials : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'GCampaignMaterials',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { campaignid : params.campaignid}
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
		
		GCities : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'GCities',
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
		
		GAges : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'GAges',
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
		
		GSegments : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
						
			$http({
			method: 'POST',
			url: webServiceUrl + 'GSegments',
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
		
		SaveCampaignUpdate : function(params){
			
			var defered 		= $q.defer();
			var promise 		= defered.promise;
			
			var campaignid 			= params.campaign_p;
			var newTextArray 		= angular.toJson(params.newTextArray);		
			var newPaletteArray 	= angular.toJson(params.newPaletteArray);
			var newMaterialArray 	= angular.toJson(params.newMaterialArray);
			var newPackArray 		= angular.toJson(params.newPackArray);
			var newFontArray 		= angular.toJson(params.newFontArray);
			var delTextArray 		= angular.toJson(params.delTextArray);		
			var delPaletteArray 	= angular.toJson(params.delPaletteArray);
			var delMaterialArray 	= angular.toJson(params.delMaterialArray);
			var delPackArray 		= angular.toJson(params.delPackArray);
			var delFontArray 		= angular.toJson(params.delFontArray);
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'SaveCampaignUpdate',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { campaignid : campaignid, newTextArray : newTextArray, 
					newPaletteArray : newPaletteArray, newMaterialArray : newMaterialArray,
					newPackArray : newPackArray, newFontArray : newFontArray,
					delTextArray : delTextArray, delPaletteArray : delPaletteArray, 
					delMaterialArray : delMaterialArray, delPackArray : delPackArray, 
					delFontArray : delFontArray }
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

angular.module('newApp').service('generalService', function($http,$q){
	
	
	return { 
	
		saveCompanyData : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'UCompany',
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
		
		saveUserPhoto : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'UUserPhoto',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { userid : params.userid , photo : params.photo  }
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
		
		saveUserLogo : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'UUserLogo',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { userid : params.userid , photo : params.photo  }
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
		
		SaveIdentityUpdate : function(params){
			
			var defered 		= $q.defer();
			var promise 		= defered.promise;
			
			var company_p 			= params.company_p;
			var newTextArray 		= angular.toJson(params.newTextArray);		
			var newPaletteArray 	= angular.toJson(params.newPaletteArray);
			var newMaterialArray 	= angular.toJson(params.newMaterialArray);
			var newPackArray 		= angular.toJson(params.newPackArray);
			var newFontArray 		= angular.toJson(params.newFontArray);
			var delTextArray 		= angular.toJson(params.delTextArray);		
			var delPaletteArray 	= angular.toJson(params.delPaletteArray);
			var delMaterialArray 	= angular.toJson(params.delMaterialArray);
			var delPackArray 		= angular.toJson(params.delPackArray);
			var delFontArray 		= angular.toJson(params.delFontArray);
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'SaveCompanyUpdate',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { company_p : company_p, newTextArray : newTextArray, 
					newPaletteArray : newPaletteArray, newMaterialArray : newMaterialArray,
					newPackArray : newPackArray, newFontArray : newFontArray,
					delTextArray : delTextArray, delPaletteArray : delPaletteArray, 
					delMaterialArray : delMaterialArray, delPackArray : delPackArray, 
					delFontArray : delFontArray }
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
		
		NotifyAdministratorFreeCampaign : function(params){
			
			var defered 		= $q.defer();
			var promise 		= defered.promise;
			
			var company_p 			= params.company_p;
			var user_p 				= params.user_p;	
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'NotifyAdministratorFreeCampaign',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { idcompany_p : company_p, user_p : user_p }
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
		
		UFreeMaterial : function(params){
			
			var defered 		= $q.defer();
			var promise 		= defered.promise;
			
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'UFreeMaterial',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { idmaterial_p : params.idmaterial_p, free_p : params.free_p }
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
		
		IMaterial : function(params){
			
			var defered 		= $q.defer();
			var promise 		= defered.promise;
			
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'IMaterial',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { description_p : params.description_p, width_p : params.width_p, height_p : params.height_p }
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
		
		UMaterialStatus : function(params){
			
			var defered 		= $q.defer();
			var promise 		= defered.promise;
			
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'UMaterialStatus',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { idmaterial_p : params.idmaterial_p, status_p : params.status_p }
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
		
		UUserStatus : function(params){
			
			var defered 		= $q.defer();
			var promise 		= defered.promise;
			
			var status_p 			= params.status_p;
			var user_p 				= params.user_p;	
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'UUserStatus',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { status_p : status_p, user_p : user_p }
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
		
		UCompanyStatus : function(params){
			
			var defered 		= $q.defer();
			var promise 		= defered.promise;
			
			var status_p 			= params.status_p;
			var company_p 			= params.company_p;	
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'UCompanyStatus',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { status_p : status_p, company_p : company_p }
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
		
		DUser : function(params){
			
			var defered 		= $q.defer();
			var promise 		= defered.promise;
			
			var user_p 				= params.user_p;	
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'DUser',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { user_p : user_p }
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
		
		
		ICompanyNAdminUser : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'ICompanyNAdminUser',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { name_p : params.name_p , address_p : params.address_p,  logo_p : params.logo_p,
					city_p : params.city_p , nameuser_p : params.nameuser_p,  
					password_p : params.password_p, homephone_p : params.homephone_p , mobilephone_p : params.mobilephone_p, 
					employees_p : params.employees_p , industry_p : params.industry_p , webpage_p : params.webpage_p , pc_p : params.pc_p , 
					subs_p : params.subs_p , storage_p : params.storage, freq_p : params.freq, nameusernoemail_p : params.nameusernoemail
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
		//hi
		GFonts : function(paramss){
			
			var defered = $q.defer();
			var promise = defered.promise;
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'GFonts',
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
		
		GCompanies : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'Company',
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
		
		GHistoryCompany : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'GHistoryCompany',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { idcompany_p : params.idcompany_p
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
		
		GetAllSubscriptions : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'GetAllSubscriptions',
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
		
		GAdmin_Inbox : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'GAdmin_Inbox',
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
		
		GetHistory : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'GetHistory',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { idcompany_p : params.idcompany_p
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
		
		AddHistory : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'AddHistory',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { user_p : params.user_p, message_p : params.message_p, campaign_p : params.campaign_p
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
		
		DashboardCount : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'DashboardCount',
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
		
		NewVisit : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'NewVisit',
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
		
		saveUserData : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'UUser',
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
			url: webServiceUrl + 'GUserCompany',
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
			url: webServiceUrl + 'GTextsCompany',
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
			url: webServiceUrl + 'GPaletteCompany',
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
		
		getFontsCompany : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'GFontsCompany',
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
		
		getPackCompany : function(params){
			
			var defered = $q.defer();
			var promise = defered.promise;
			
			$http({
			method: 'POST',
			url: webServiceUrl + 'GPackCompany',
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
			url: webServiceUrl + 'NewCompany_TextConfig',
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
			url: webServiceUrl + 'NewCompany_Palette',
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
			url: webServiceUrl + 'AllUsersAdmin',
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
			url: webServiceUrl + 'AllCompaniesAdmin',
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
			url: webServiceUrl + 'NewUser',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { company_p : params.company_p, name_p : params.name_p, password_p : params.password_p, homephone_p : params.homephone_p, mobilephone_p : params.mobilephone_p, username_p : params.username_p}
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
		
		RecoverPassword : function(params){
			var defered = $q.defer();
			var promise = defered.promise;
			$http({
			method: 'POST',
			url: webServiceUrl + 'RecoverPassword',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
			transformRequest: function(obj) {
				var str = [];
				for(var p in obj)
				str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
				return str.join("&");
			},
			data: { password_p : params.password_p, email_p : params.email_p }
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
			url: webServiceUrl + 'NewCompany',
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
			url: webServiceUrl + 'CountSubscriptions',
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
			url: webServiceUrl + 'NewCampaign',
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


angular.module('newApp').service('objCampaign', function($http,$q){
	
	var selectedCampaign = {};
	
	return { 
	
		setCampaign : function(params){
			
			selectedCampaign = params;
			
		},
		
		getCampaign : function(){
			
			var defered = $q.defer();
			var promise = defered.promise;
			
			defered.resolve(selectedCampaign);		
			return promise;
			
		}
	
	}
})


angular.module('newApp').factory('Excel',function($window){
	var uri='data:application/vnd.ms-excel;base64,',
		template='<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>',
		base64=function(s){return $window.btoa(unescape(encodeURIComponent(s)));},
		format=function(s,c){return s.replace(/{(\w+)}/g,function(m,p){return c[p];})};
	return {
		tableToExcel:function(tableId,worksheetName){
			var table=$(tableId),
				ctx={worksheet:worksheetName,table:table.html()},
				href=uri+base64(format(template,ctx));
			return href;
		}
	};
})

angular.module('newApp').controller('mainCtrl',
    ['$scope', 'applicationService', 'quickViewService', 'builderService', 'pluginsService', '$location', 'userService', 'generalService',
        function ($scope, applicationService, quickViewService, builderService, pluginsService, $location, userService, generalService) {
            
			
			
			$scope.showLoggin = true;
			$scope.indexClass = "sidebar-condensed account2";
			$scope.username = "";
			$scope.password = "";
			$scope.alertShow = false;
			$scope.alertRecoverShow = false;
			$scope.loginType = 1;
			$scope.recoverEmail = "";
			$scope.rEmail = "";
			$scope.rNombre = "";
			$scope.rCasa = "";
			$scope.rMobile = "";
			$scope.fontArray = [];
			
			var yourFontName = "deca";
			var yourFontURL  = "/uploads/stonehen.ttf";
			var newStyle = document.createElement('style');
			newStyle.appendChild(document.createTextNode("\
			@font-face {\
				font-family: " + yourFontName + ";\
				src: url('" + yourFontURL + "') format('truetype');\
			}\
			"));

			document.head.appendChild(newStyle);
			
			
			
			generalService.GFonts()
			.then(function(data) {
				$scope.fontArray = data;	
				// for (var i in $scope.fontArray){
					// $("head").prepend("<style type=\"text/css\">" + 
                                // "@font-face {\n" +
                                    // "\tfont-family: \"myFont\";\n" + 
                                    // "\tsrc: local('☺'), url('myFont.otf') format('opentype');\n" + 
                                // "}\n" + 
                                    // "\tp.myClass {\n" + 
                                    // "\tfont-family: myFont !important;\n" + 
                                // "}\n" + 
                            // "</style>");
				// }
				for (var i in $scope.fontArray){
					var FormatType = "";
					if($scope.fontArray[i].font.indexOf("otf") !== -1){
						FormatType = "opentype";
						$("head").append("<style>@font-face { font-family: "+$scope.fontArray[i].font.substring(0, $scope.fontArray[i].font.length-4)+";    src: url('/uploads/"+$scope.fontArray[i].font+"') format('"+FormatType+"');}</style>");
					}
					if($scope.fontArray[i].font.indexOf("ttf") !== -1){
						FormatType = "truetype";
						$("head").append("<style>@font-face { font-family: "+$scope.fontArray[i].font.substring(0, $scope.fontArray[i].font.length-4)+";    src: url('/uploads/"+$scope.fontArray[i].font+"') format('"+FormatType+"');}</style>");
					}
					
				}
				
			})
			
			generalService.NewVisit()
			.then(function(data) {	
			})
			
			
			
			$scope.logIn = function(){
				$scope.loginType = 1;
				$scope.username = "";
				$scope.password = "";
			}
			
			$scope.recoverPassword = function(){
				$scope.loginType = 2;
				$scope.recoverEmail = "";
			}
			
			$scope.registerNow = function(){
				$scope.loginType = 3;
				$scope.rEmail = "";
				$scope.rNombre = "";
				$scope.rCasa = "";
				$scope.rMobile = "";
				$scope.alertUserShow  = false;
			}
			
			$scope.saveUser = function(){
				console.log("test");
				$scope.alertUserShow  = false;
				var params = {
					"name_p" : "",
					"password_p" : "",
					"company_p" : "",
					"homephone_p" : "",
					"mobilephone_p" : ""
				}
				
				var randomstring = Math.random().toString(36).slice(-8);
				
				params.name_p 			= $scope.rEmail;
				params.password_p 		= randomstring;
				params.company_p 		= 4;
				params.homephone_p 		= $scope.rCasa;
				params.mobilephone_p 	= $scope.rMobile;
				 
				 
				generalService.NewUser(params)
				.then(function(data) {
					if(data[0].returnMessage === 'SUCCESS'){
						
						$scope.messageUser 	 = "¡Éxito!, revisa tu correo recibirás tu contraseña para acceder a la aplicación.";
						$scope.alertUserClass = "alert alert-success";
						$scope.alertUserShow  = true;
						$scope.rEmail = "";
						$scope.rNombre = "";
						$scope.rCasa = "";
						$scope.rMobile = "";
						return;		
					}
					
					console.log(data);
					if(data.indexOf('Ya') !== -1){
						console.log("Y");
						$scope.messageUser 	 = "El correo capturado ya existe, accede a la sección recuperar contraseña para recuperar tu cuenta.";
						$scope.alertUserClass = "alert alert-danger";
						$scope.alertUserShow  = true;
						return;
					}
					
						
					$scope.messageUser 	 = "Ocurrió un error en la aplicación, favor de contactar soporte.";
					$scope.alertUserClass = "alert alert-danger";
					$scope.alertUserShow  = true;
						
					
				})
			}
			
			$scope.recoverPasswordS = function(){
				console.log("test");
				$scope.alertRecoverShow  = false;
				var params = {
					"email_p" : ""
				}
				
				var randomstring = Math.random().toString(36).slice(-8);
				
				params.email_p 			= $scope.recoverEmail;
				params.password_p 		= randomstring;
				 
				 
				generalService.RecoverPassword(params)
				.then(function(data) {
					if(data[0].returnMessage === 'SUCCESS'){
						
						$scope.messageRecover 	 = "¡Éxito!, revisa tu correo recibirás tu contraseña para acceder a la aplicación.";
						$scope.alertRecoverClass = "alert alert-success";
						$scope.alertRecoverShow  = true;
						$scope.recoverEmail = "";
						
									
					}else{
						
						$scope.messageRecover 	 = "Ocurrió un error en la aplicación, favor de contactar soporte.";
						$scope.alertRecoverClass = "alert alert-danger";
						$scope.alertRecoverShow  = true;
						
					}
				})
			}
			
			
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
							
							// var payload = {
								// "user_p" : "",
								// "message_p" : "",
								// "campaign_p" : ""
							// }
							
							// payload.user_p		= data[0].id_user;
							// payload.message_p	= "Inició sesión";
							// payload.campaign_p	= 0;
							
							// userService.AddHistory(payload)
							// .then(function(data) {
								// console.log(data);
							// })
							
							userService.currentUser()
							.then(function(data) {
								$scope.currentUser = data;
								console.log($scope.currentUser);
								
								
								var payload = {
								"user_p" : "",
								"message_p" : "",
								"campaign_p" : ""
								}
								
								payload.user_p		= $scope.currentUser.id_user;
								payload.message_p	= "Inició sesión";
								payload.campaign_p	= 0;
								
								generalService.AddHistory(payload)
								.then(function(data) {
									console.log(data);
								});
								$scope.alertShow = false;
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

