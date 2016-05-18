angular.module('flapperNews', ['ui.router'])
.config(($stateProvider, $urlRouterProvider, $httpProvider) ->

    $stateProvider
        .state('home', {
            url: '/home',
            templateUrl: '/home.html',
            controller: 'HomeCtrl'
        })

    $urlRouterProvider.otherwise('home')

    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
)

# .factory('stocks',
# ($http) ->

#     stocks = []

#     # $http.get('/stock.json').success((resultJson) ->
#     #     # // angular.copy(data, o.posts);
#     #     quotes = resultJson.query.results.quote
#     #     for item in quotes
#     #         stocks.push(item)
#     # )

#     # // stocks.push({"name": "asdf"}, {"name": "asdf2"})

#     return {
#         stocks : stocks
#     }
# )

.controller('HomeCtrl',
($scope, $http) ->
    # $scope.stocks = stocks.stocks

    $scope.formData = {
        name: "MSFT"
    }

    $scope.processForm = () ->
        $http({
            method  : 'POST',
            url     : '/stock.json',
            data    : $.param($scope.formData),  #// pass in data as strings
            headers : { 'Content-Type': 'application/x-www-form-urlencoded' }  #// set the headers so angular passing info as form data (not request payload)
        })
        .success((data) ->
            console.log(data);

            timestamp = data.query.created
            $scope.result = data.query.results.quote
        );

    $scope.result = null
)