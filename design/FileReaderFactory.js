'use strict';

/**
 * @ngdoc function
 * @name newappApp.controller:FileReaderFactory
 * @description
 * # FileReaderFactory
 * Controller of the newappApp
 */

angular.module('newApp')
  .factory('FileReaderFactory', function ($q) {
	
		
	var factory = {};

    var onLoad = function onLoad(reader, deferred, scope) {
        return function () {
            scope.$apply(function () {
                deferred.resolve(reader.result);
            });
        };
    };

    var onError = function onError(reader, deferred, scope) {
        return function () {
            scope.$apply(function () {
                deferred.reject(reader.result);
            });
        };
    };

    var onProgress = function onProgress(reader, scope) {
        return function (event) {
            scope.$broadcast("fileProgress", {
                total: event.total,
                loaded: event.loaded
            });
        };
    };

    var getReader = function getReader(deferred, scope) {
        var reader = new FileReader();
        reader.onload = onLoad(reader, deferred, scope);
        reader.onerror = onError(reader, deferred, scope);
        reader.onprogress = onProgress(reader, scope);
        return reader;
    };

    factory.readAsDataUrl = function (file, scope) {
        var deferred = $q.defer();

        var reader = getReader(deferred, scope);
        reader.readAsDataURL(file);

        return deferred.promise;
    };

    return factory;
		
		
  });
