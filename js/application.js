
function template (name) {
    return 'templates/' + name + '.html';
}

angular.module('pybuilder', []).
    config(['$routeProvider', function($routeProvider) {
    $routeProvider
        .when('/', {templateUrl: template('home'), controller: null})
        .when('/documentation', {templateUrl: template('documentation'), controller: null})
        .when('/releasenotes', {templateUrl: template('releasenotes'), controller: null})
        .otherwise({redirectTo: '/'})
    ;
}]);
