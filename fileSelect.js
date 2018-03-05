"use strict";
angular.module('ngFileSelect', [])
.directive('ngFileSelect', ['$parse', function( $parse) {
  return {
    restrict: 'A',
    scope: {
      images: "=",
      fileType: "@",
      callback: '&'
    },
    link: function ($scope,el) {
      el.bind("change", function(e){
        $scope.file = (e.srcElement || e.target).files[0];
        //Handle multiple file types
        switch($scope.fileType) {
          case "image":
            var imageType = /image.*/;
            if ($scope.file.type.match(imageType)) {
              $scope.getFile();
            } else {
              alert("Invalid " + $scope.fileType + " type!");
            }
            break;
           default:
            break; 
        }
      });
    },
    controller: function ($scope, FileReaderFactory) {
      $scope.getFile = function () {
        $scope.progress = 0;
        FileReaderFactory.readAsDataUrl($scope.file, $scope)
        .then(function(result) {
          $scope.images.push(result);
          if (typeof $scope.callback === "function") {
            $scope.callback();
          }
        });
      };
    }
  };
 }]);
