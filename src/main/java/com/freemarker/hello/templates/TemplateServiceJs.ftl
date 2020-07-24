'use strict';

App.factory('${bean}Service', ['$http', '$q', function($http, $q){

return {

create${bean}: function(bean){
return $http.post(apiUrl +"/${lowerBean}", bean)
.then(
function(response){
return response.data;
},
function(errResponse){
handleAjaxError(errResponse);
return $q.reject(errResponse);
}
);
},

update${bean}: function(bean, id){
return $http.put(apiUrl +"/${lowerBean}/"+id, bean)
.then(
function(response){
return response.data;
},
function(errResponse){
handleAjaxError(errResponse);
return $q.reject(errResponse);
}
);
},

delete${bean}: function(id){
return $http['delete'](apiUrl +"/${lowerBean}/"+id)
.then(
function(response){
return response.data;
},
function(errResponse){
handleAjaxError(errResponse);
return $q.reject(errResponse);
}
);
},

<#list camelColumns as col>
    <#if (col.foreignKey)??>
        sel${col.foreignTable}: function(){
        return $http['get'](apiUrl +"/${col.foreignTable}")
        .then(
        function(response){
        return response.data;
        },
        function(errResponse){
        handleAjaxError(errResponse);
        return $q.reject(errResponse);
        }
        );
        },
    </#if>
</#list>

};

}]);
