<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1">
    <script src="js/common.js"></script>
    <script src="js/controller/${lowerBean}_controller_server.js"></script>
    <script src="js/service/${lowerBean}_service.js"></script>
</head>


<body class="hold-transition skin-blue sidebar-mini" ng-app="${lowerBean}Module"
      ng-controller="ServerSideCtrl as ctrl">

    <div class="content-wrapper">
        <section class="content-header">
            <h1 translate="common.${lowerBean}"></h1>
            <button class="c-g-header-button" ng-click="ctrl.addInit()">
                <span translate="common.add"></span>
            </button>
            <#--<ol class="breadcrumb">
                <li translate="common.home"><a href="#"><i class="fa fa-dashboard"></i></a></li>
                <li class="active" translate="common.${lowerBean}M"></li>
            </ol>-->
        </section>
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div  class="c-g-searBox">
                        <#if lowerPk?? >

                            <div class="c-g-searDiv">
                                <label translate="${lowerBean}.${lowerPk}" class="c-g-searLable"></label>
                                <div >
                                    <input type="text" class="c-g-searInput"  ng-model="ctrl.beanSer.${lowerPk}"
                                           autocomplete="off" placeholder="{{'${lowerBean}.${lowerPk}'   | translate }}">
                                </div>
                                <button id="bth-searchDate" ng-click="ctrl.reloadData()" class="c-g-searButton" translate="search" ></button>
                                <button ng-click="ctrl.searchReset()" class="c-g-searButton" translate="common.reset" ></button>
                            </div>

                        </#if>
                    </div>
                    <!-- table start -->
                    <div class="box box-primary" id="example">
                        <div class="box-body">
                            <table datatable="" id="table_id" dt-options="ctrl.dtOptions"
                                   dt-columns="ctrl.dtColumns" dt-instance="ctrl.dtInstance"
                                   class="row-border hover">
                            </table>
                        </div>
                        <!-- /.box-body -->
                    </div>
                    <!-- table end -->
                </div>
            </div>
        </section>


        <!-- 模态框（Modal） -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
             aria-labelledby="myModalLabel" aria-hidden="true">
            <form class="form-horizontal" ng-submit="ctrl.submit()"
                  name="addEditForm">
                <div class="modal-dialog">
                    <div class="modal-content" style="padding: 3px;">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"
                                    aria-hidden="true">&times;</button>
                            <h4 class="modal-title" id="myModalLabel" ng-model="ctrl.modelTitle"><span ng-bind="ctrl.modelTitle"></span></h4>
                            <!-- 校验start -->
                            <div ng-include="'html/tips.html'"></div>
                            <!-- 校验end -->
                        </div>

                        <div class="box box-primary">
                            <div class="row">
                                <div class="col-xs-12">
                                    <section class="content-header"></section>
                                    <section class="content">
                                        <#list camelColumns as col>
                                            <#if col.primaryKey == 1>

                                                <input type="hidden" ng-model="ctrl.bean.${lowerPk}"/>

                                            <#else >
                                                <#if (col.type == "Date" || col.type == "TimeStamp")>
                                                    <div class="row">
                                                        <div class="col-xs-12">
                                                            <div class="form-group col-sm-12">
                                                                <label
                                                                       class="col-sm-4 control-label control-label-zb" translate="${lowerBean}.${col.camelName}"></label>
                                                                <div class="col-sm-7">
                                                                    <input type="text" class="form-control" id="${col.camelName}" name="${col.camelName}"
                                                                           placeholder="{{'${lowerBean}.${col.camelName}'   | translate }}" ng-model="ctrl.bean.${col.camelName}"  required>
                                                                    <div ng-show="addEditForm.${col.camelName}.$error.required" style="color:red" translate="${lowerBean}.${col.camelName}">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                <#else>
                                                    <#if col.camelName == "remark">
                                                    <#--String-->
                                                        <div class="row">
                                                            <div class="col-xs-12">
                                                                <div class="form-group col-sm-12">
                                                                    <label
                                                                            class="col-sm-4 control-label control-label-zb"
                                                                            translate="${lowerBean}.${col.camelName}"></label>
                                                                    <div class="col-sm-7">
                                                                        <textarea type="text" class="form-control" id="${col.camelName}"
                                                                                  name="${col.camelName}" ng-pattern="/^(?!.*[~!@$#%^&*<>)/(])/"
                                                                                  placeholder="{{'${lowerBean}.${col.camelName}'   | translate }}"
                                                                                  ng-model="ctrl.bean.${col.camelName}"
                                                                                  ng-maxlength="1000"></textarea>
                                                                        <div ng-show="addEditForm.${col.camelName}.$error.required"
                                                                             style="color:red" translate="${lowerBean}.${col.camelName}.notEmpty">
                                                                        </div>
                                                                        <div ng-show="addEditForm.${col.camelName}.$error.maxlength"
                                                                             style="color:red" translate="${lowerBean}.${col.camelName}.length">
                                                                        </div>
                                                                        <div ng-show="addEditForm.${col.camelName}.$error.pattern"
                                                                             style="color:red" translate="common.illegalChar">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    <#else>
                                                        <#--String-->
                                                        <div class="row">
                                                            <div class="col-xs-12">
                                                                <div class="form-group col-sm-12">
                                                                    <label
                                                                            class="col-sm-4 control-label control-label-zb"
                                                                            translate="${lowerBean}.${col.camelName}"></label>
                                                                    <div class="col-sm-7">
                                                                        <input type="text" class="form-control" id="${col.camelName}"
                                                                               placeholder="{{'${lowerBean}.${col.camelName}' | translate }}"
                                                                               ng-model="ctrl.bean.${col.camelName}" <#if (col.primaryKey == 1 || col.readOnly == 1)>ng-readonly="ctrl.readonlyID"</#if>
                                                                               name="${col.camelName}" ng-maxlength="32" <#if col.type == "Number">ng-pattern="/^[0-9]*$/"</#if>
                                                                               required>
                                                                        <div ng-show="addEditForm.${col.camelName}.$error.required"
                                                                             style="color:red" translate="${lowerBean}.${col.camelName}.notEmpty">
                                                                        </div>
                                                                        <div ng-show="addEditForm.${col.camelName}.$error.maxlength"
                                                                             style="color:red" translate="${lowerBean}.${col.camelName}.length">
                                                                        </div>
                                                                        <div ng-show="addEditForm.${col.camelName}.$error.pattern"
                                                                             style="color:red" translate="common.illegalChar">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </#if>
                                                </#if>
                                            </#if>
                                        </#list>

                                    </section>
                                </div>
                            </div>
                        </div>
                        <!-- end box box-primary -->
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default"
                                    data-dismiss="modal" translate="common.cancel"></button>
                            <button type="submit" class="btn btn-primary" ng-disabled="addEditForm.$invalid"
                                    translate="common.save"></button>
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
            </form>
            <!-- /.modal -->
        </div>
    </div>

</body>

</html>