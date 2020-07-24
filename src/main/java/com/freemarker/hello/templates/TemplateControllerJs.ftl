'use strict';
var App = angular.module('${lowerBean}Module', [ 'datatables',
'datatables.columnfilter', 'datatables.fixedcolumns',
'datatables.buttons', 'pascalprecht.translate', 'ngSanitize','LocalStorageModule', 'ui.tree' ]);
configAppModule(App);
App.controller('ServerSideCtrl', ServerSideCtrl);

$(function() {
<#list camelColumns as col>
    <#if (col.type == "Date" || col.type == "TimeStamp")>
    $("#${col.camelName}").datetimepicker({
        language: "zh-CN",
        autoclose: true,
        clearBtn: true,//清除按钮
        todayBtn: 'linked',
        //        minView: 'month',
        format: timeFormat()//日期格式，详见 http://bootstrap-datepicker.readthedocs.org/en/release/options.html#format
    });
    </#if>
</#list>

});


function ServerSideCtrl(DTOptionsBuilder, DTColumnBuilder, $translate, $scope,
$filter, $compile, ${bean}Service,localStorageService,topleftService) {
var vm = this;
vm.modelTitle = "";
vm.readonlyID = false;
vm.beanSer = {};
//列的状态start
vm.columnStatusData=[];
//列的状态end
vm.reloadData = reloadData;
vm.dtOptions = DTOptionsBuilder.fromSource(getFromSource(apiUrl + '/${lowerBean}')).withOption(
'createdRow', createdRow);

setDtOptionsServerSide(vm);
vm.dtColumns = [
<#list camelColumns as col>
    DTColumnBuilder.newColumn('${col.camelName}').withTitle($translate('${lowerBean}.${col.camelName}')).notSortable()
    <#if col.type == "TimeStamp">.renderWith(timeStampRender)</#if><#if col.type == "Date">.renderWith(dateRender)</#if><#if col.inVisible == 1>.notVisible()</#if>,
</#list>
DTColumnBuilder.newColumn(null).withTitle($translate('Actions')).withOption('width', '10%').notSortable()
.renderWith(actionsHtml) ];

vm.addInit = addInit;
vm.edit = edit;
vm.submit = submit;
vm.deleteBean = deleteBean;

//获取外键数据
<#list camelColumns as col>
    <#if (col.foreignKey)??>var ${col.foreignTable}Data = [];</#if>
</#list>

selAll();

function selAll() {
    <#list camelColumns as col>
        <#if (col.foreignKey)??>
            ${bean}Service.sel${col.foreignTable}()
            .then(
            function(a) {
                vm.${col.foreignTable}Data = a.body;
            },
            function(errResponse){
                console.error('Error while fetching ${col.foreignTable}Data');
            }
            );
        </#if>
    </#list>
}


//表头start
tableHandle();
//表头end
initltCommon(vm,localStorageService,topleftService);
$("#loadDiv").hide();

//超长备注处理start
function remarkDetail(data, type, full, meta){
if(data!=null){
return '<span class="spanFun" style=" display: inline-block;width: 200px;white-space:nowrap;word-break:keep-all;overflow:hidden;text-overflow:ellipsis;">'+data+'</span>'
}else{
return '';
}
}
//超长备注处理end
function actionsHtml(data, type, full, meta) {
vm.beans[data.${lowerPk}] = data;
return '<button class="btn btn-warning" data-toggle="modal" data-target="#myModal" title="'+$translate.instant('common.edit')+'" ng-click="ctrl.edit(ctrl.beans[\''
            + data.${lowerPk}
            + '\'])">'
    + '   <i class="fa fa-edit"></i>'
    + '</button>&nbsp;'
+ '<button class="btn btn-danger" title="'+$translate.instant('common.delete')+'" ng-click="ctrl.deleteBean(ctrl.beans[\''
            + data.${lowerPk}
            + '\'])">'
    + '   <i class="fa fa-trash-o"></i>'
    + '</button>';
}

function addInit() {
vm.modelTitle = $translate.instant('${lowerBean}.${lowerBean}Add');
vm.readonlyID = false;
vm.bean = {};
vm.statusCode="";
vm.statusMessage="";
}
function edit(bean) {
reloadData();
vm.modelTitle = $translate.instant('${lowerBean}.${lowerBean}Edit');
vm.readonlyID = true;
vm.bean = bean;
vm.statusCode="";
vm.statusMessage="";
}

function timeStampRender(data, type, full, meta) {
    if(data==null||data==''){
        return '';
    }else{
        var naLan = navigator.language;
        if (naLan == undefined || naLan == "") {
            naLan = navigator.browserLanguage;
        }
        const timeStamp = parseInt(data);
        let date = new Date(timeStamp);
        if(naLan=='zh'){
            return  moment(date).format("YYYY-MM-DD HH:mm:ss");
        }else if(naLan.indexOf("zh") >= 0){
            return  moment(date).format("YYYY-MM-DD HH:mm:ss");
        }else{
            return  moment(date).format("DD/MM/YYYY HH:mm:ss");
        }

    }
}

function dateRender(data) {
    if(data==null||data==''){
        return '';
    }else{
        var naLan = navigator.language;
        if (naLan == undefined || naLan == "") {
            naLan = navigator.browserLanguage;
        }
        if(naLan=='zh'){
            return  moment(date).format("YYYY-MM-DD HH:mm:ss");
        }else if(naLan.indexOf("zh") >= 0){
            return  moment(date).format("YYYY-MM-DD HH:mm:ss");
        }else{
            return  moment(date).format("DD/MM/YYYY HH:mm:ss");
        }
    }
}

function statusRender(data, type, full, meta) {
if (data == '0'){
return $translate.instant('common.inactivate');
}
if (data == '1'){
return $translate.instant('common.activate');
}
return '';
}

function submit() {
if (!vm.readonlyID) {
    $.fn.dataTable.ext.errMode = 'none';
    ${bean}Service.create${bean}(vm.bean).then(onSubmitSuccess,
    function(errResponse) {
        handleAjaxError(errResponse);
        console.error('Error while creating ${bean}.');
    });
    vm.reset();
} else {
    ${bean}Service.update${bean}(vm.bean, vm.bean.${lowerPk}).then(onSubmitSuccess,
    function(errResponse) {
        handleAjaxError(errResponse);
        console.error('Error while updating ${bean}.');
    });
}
}

function onSubmitSuccess(data){
    vm.statusCode=data.statusCode;
    vm.statusMessage=data.statusMessage;
    reloadData();
}

function deleteBean(bean) {

BootstrapDialog.show({
title : $translate.instant('common.delete'),
message : $translate.instant('common.delete.message'),
buttons : [ {
label : $translate.instant('common.yes'),
cssClass : 'btn btn-danger model-tool-right',
action : function(dialogItself) {
${bean}Service.delete${bean}(bean.${lowerPk}).then(reloadData,
function(errResponse) {
handleAjaxError(errResponse);
console.error('Error while updating ${bean}.');
});
dialogItself.close();
}

}, {
label : $translate.instant('common.cancel'),
cssClass : 'btn btn-default model-tool-left',
action : function(dialogItself) {
dialogItself.close();
}
} ]
});

}
//超长备注处理start
$("#example").on("click", ".spanFun", function(){
var remarkDetail = $(this).text();
BootstrapDialog.show({
title: $translate.instant('user.remark'),
message: function(dialog) {
var $message=$(
'<span id="content_detail" style="word-break:normal; width:auto; display:block; white-space:pre-wrap;word-wrap:break-word ;overflow: hidden"'+
'</span>'
);
return $message;
},
onshown: function(dialogRef){//打开完成
$("#content_detail").text(remarkDetail);
},
buttons: [
{
label: $translate.instant('common.yes'),
cssClass: 'btn-primary',
action: function(dialogItself){
dialogItself.close();
}
}]
});
});

function selectBank(){
// $("#selectCouponFun").select2();
//解决 select2在模态框使用，模糊输入框无效

<#list camelColumns as col>
    <#if col.foreign??>
        $("#${col.camelName}").select2();
    </#if>
</#list>

}

//超长备注处理end
//解决查询后保持列的显示start
$('#table_id').on( 'init.dt', function ( e, settings, column, state ) {
vm.columnStatusData = settings.aoColumns;
} );
//解决查询后保持列的显示end
//start
$('#table_id').on('draw.dt',function() {
setTimeout(function(){
$("#loadDiv").hide();
$("#bth-searchDate").attr("disabled",false);
},500);
});

$("#bth-searchDate").click(function(){
$("#loadDiv").show();

})
//end

function reloadData() {
    $("#bth-searchDate").attr("disabled",true);
    //解决查询后保持列的显示start
    var columuFinalStatus = vm.columnStatusData;
    if(columuFinalStatus.length>0){
        for(var i = 0; i < columuFinalStatus.length; i++){
            vm.dtColumns[i].bVisible = columuFinalStatus[i].bVisible;
        }
    }
    //解决查询后保持列的显示end
    var ${lowerPk} = vm.beanSer.${lowerPk};
    //TODO 需要查询字段赋值

    vm.dtInstance.changeData(getFromSource(apiUrl + '/${lowerBean}?id='
    + getValueForSelect(${lowerPk})
    ));
    var resetPaging = false;
    vm.dtInstance.reloadData(callback, resetPaging);
}
function callback(json) {
//console.log(json);
}
function createdRow(row, data, dataIndex) {
$compile(angular.element(row).contents())($scope);
}
vm.reset = function() {
addInit();
};
}