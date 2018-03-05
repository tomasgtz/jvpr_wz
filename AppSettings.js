'use strict';

/**
 * @ngdoc function
 * @name newappApp.controller:UtilsFactory
 * @description
 * # UtilsFactory
 * Controller of the newappApp
 */

angular.module('newApp')
  .factory('AppSettings', function () {
	
	var AppSettings = {
	  appTitle: 'Wizad',
	  apiUrl: '/api/v1',
	  maxStorageSpace: 5024
	};
		
  });
