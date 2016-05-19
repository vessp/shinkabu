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

.factory('stocks', ["$http", ($http) ->

    index = []

    $http.get('/stocks.json').success((jStocks) ->
        console.log(jStocks)
        for js in jStocks
            index.push(js)
    )

    return {
        index : index
    }
])

.controller('HomeCtrl', ["$scope", "$http", "stocks", ($scope, $http, stocks) ->
    $scope.stocks = stocks.index
    $scope.isLoading = false
    $scope.result = {}
    $scope.activeSymbol = null

    $scope.$watch(
        () -> $scope.activeSymbol
        () ->
            $scope.onSelectStock($scope.activeSymbol)
    )

    $scope.onSelectStock = (symbol) ->
        if(!symbol)
            return

        if(symbol.length == 0)
            return

        symbol = symbol[0]

        $scope.isLoading = true
        $http({
            method  : 'POST',
            url     : '/stock.json',
            data    : $.param({"symbol": symbol})
            headers : { 'Content-Type': 'application/x-www-form-urlencoded' }  #// set the headers so angular passing info as form data (not request payload)
        })
        .success((data) ->
            console.log(data);
            $scope.isLoading = false

            $scope.timestamp = data.query.created
            $scope.result = data.query.results.quote
        );
])