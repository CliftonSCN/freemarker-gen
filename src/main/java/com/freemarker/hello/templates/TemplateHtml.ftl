<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1">
    <title></title>
    <link rel="icon" type="image/x-icon" href="imgs/title.ico"><!-- css -->
    <link rel="stylesheet" href="lib/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="lib/AdminLTE/css/AdminLTE.min.css">
    <link rel="stylesheet" href="lib/AdminLTE/css/skins/_all-skins.min.css">
    <link rel="stylesheet" href="lib/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet"
          href="lib/datatables/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="lib/ColVis/css/dataTables.colVis.min.css">
    <link rel="stylesheet"
          href="lib/FixedColumns/css/dataTables.fixedColumns.min.css">
    <link rel="stylesheet"
          href="lib/datatables/extensions/Buttons/css/buttons.dataTables.css">
    <link rel="stylesheet"
          href="lib/bootstrap3-dialog/dist/css/bootstrap-dialog.min.css">
    <link rel="stylesheet" href="css/zben.css">
    <!-- js -->
    <script src="lib/jquery/jquery-2.2.3.min.js"></script>
    <script src="lib/jquery/jQuery.resizeEnd.js"></script>
    <script src="lib/bootstrap/js/bootstrap.min.js"></script>
    <script src="lib/datatables/js/jquery.dataTables.min.js"></script>
    <script src="lib/angularjs/angular.min.js"></script>
    <script src="lib/angularjs/angular-cookies.min.js"></script>
    <script src="lib/angular-translate/angular-translate.min.js"></script>
    <script
            src="lib/angular-translate/angular-translate-storage-cookie/angular-translate-storage-cookie.min.js"></script>
    <script
            src="lib/angular-translate/angular-translate-loader-static-files/angular-translate-loader-static-files.min.js"></script>
    <script
            src="lib/angular-translate/angular-translate-loader-url/angular-translate-loader-url.min.js"></script>
    <script src="lib/angularjs/angular-sanitize.min.js"></script>
    <script src="lib/angular-datatables/angular-datatables.min.js"></script>
    <script src="lib/FixedColumns/js/dataTables.fixedColumns.min.js"></script>
    <script
            src="lib/angular-datatables/plugins/fixedcolumns/angular-datatables.fixedcolumns.min.js"></script>
    <script
            src="lib/datatables/extensions/Buttons/js/dataTables.buttons.min.js"></script>
    <script src="lib/datatables/extensions/Buttons/js/buttons.colVis.min.js"></script>
    <script src="lib/datatables/extensions/Buttons/js/buttons.colVis.js"></script>
    <script src="lib/datatables/extensions/Buttons/js/buttons.flash.min.js"></script>
    <script src="lib/datatables/extensions/Buttons/js/buttons.html5.min.js"></script>
    <script src="lib/datatables/extensions/Buttons/js/buttons.print.min.js"></script>
    <script
            src="lib/angular-datatables/plugins/buttons/angular-datatables.buttons.min.js"></script>
    <script src="lib/datatables-columnfilter/dataTables.columnFilter.js"></script>
    <script
            src="lib/angular-datatables/plugins/columnfilter/angular-datatables.columnfilter.min.js"></script>
    <script src="lib//bootstrap3-dialog/dist/js/bootstrap-dialog.min.js"></script>
    <script src="lib/angular-local-storage/angular-local-storage.min.js"></script>
    <script src="lib/jQueryUI/jquery-ui.min.js"></script>
    <script src="lib/angular-ui-tree/angular-ui-tree.min.js"></script>
    <script src="lib/AdminLTE/js/app.js"></script>
    <script src="lib/AdminLTE/js/demo.js"></script>
    <script src="js/zben.js"></script>
    <script src="js/controller/${lowerBean}_controller_server.js"></script>
    <script src="js/service/${lowerBean}_service.js"></script>
</head>


<body class="hold-transition skin-blue sidebar-mini" ng-app="${lowerBean}Module"
      ng-controller="ServerSideCtrl as ctrl">
<div class="wrapper">

    <!-- 头部和左侧 开始 -->
    <div>
        <header class="main-header" ng-include="'html/top.html'">
        </header>

        <aside class="main-sidebar" ng-include="'html/left.html'">
        </aside>
    </div>

    <div class="content-wrapper">
        <section class="content-header">
            <h1 translate="common.${lowerBean}"></h1>
            <ol class="breadcrumb">
                <li translate="common.home"><a href="#"><i class="fa fa-dashboard"></i></a></li>
                <li class="active" translate="common.${lowerBean}M"></li>
            </ol>
        </section>
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box box-primary collapsed-box">
                        <form class="form-horizontal" ng-submit="ctrl.reloadData()"
                              name="searchForm">
                            <div class="box-search-info">
                                <div class="box-header with-border">
                                    <div class="row">
                                        <div class="col-sm-8 pull-left">
                                            <button type="button"
                                                    class="btn btn-primary btn-sm table-tool-left" id="btn-add"
                                                    data-toggle="modal" data-target="#myModal"
                                                    ng-click="ctrl.addInit()" translate="common.add"></button>
                                        </div>
                                        <div class="col-sm-4 pull-right">
                                            <button type="button" class="btn btn-info btn-sm table-tool-right"
                                                    data-widget="collapse" data-toggle="tooltip" title="">
                                                <i class="fa  fa-angle-double-down" translate="common.expand.query">&nbsp;</i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <!-- table start -->
                            <div class="box-body" style="display: none">
                                <div class="row">
                                    <div class="form-group col-sm-6">
                                        <label
                                               class="col-sm-4 control-label control-label-zb"
                                               translate="${lowerBean}.${lowerPk}"></label>
                                        <div class="col-sm-7">
                                            <input type="text" class="form-control"
                                                   ng-model="ctrl.beanSer.${lowerPk}"
                                                   placeholder="{{'${lowerBean}.${lowerPk}'   | translate }}">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-10">
                                        <button type="submit" class="btn btn-block btn-info btn-sm"
                                                style="float: right; width: 75px;" id="bth-searchDate"
                                                translate="search"></button>
                                    </div>
                                </div>
                            </div>
                            <!-- end box-body -->
                        </form>
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
                        <div id="loadDiv" style="position: absolute;top: 50%; left: 50%;width: 100%; height: 40px;margin-left: -50%;
margin-top: -25px;padding-top: 20px;text-align: center;font-size: 1.2em;" translate="common.loading"></div>
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
                                    aria-hidden="true">&times;
                            </button>
                            <h4 class="modal-title" id="myModalLabel"><span ng-bind="ctrl.modelTitle"></span></h4>
                            <!-- 校验start -->
                            <div ng-include="'html/tips.html'"></div>
                            <!-- 校验end -->
                        </div>

                        <div class="box box-primary">
                            <div class="row">
                                <div class="col-xs-12">
                                    <section class="content-header"></section>
                                    <section class="content">
                                        <#--<input type="hidden" ng-model="ctrl.bean.${lowerPk}" />-->

                                        <#list camelColumns as col>
                                            <div class="row">
                                                <div class="col-xs-12">
                                                    <div class="form-group col-sm-12">
                                                        <label
                                                               class="col-sm-4 control-label control-label-zb"
                                                               translate="${lowerBean}.${col}"></label>
                                                        <div class="col-sm-7">
                                                            <input type="text" class="form-control" id="${col}"
                                                                   placeholder="{{'${lowerBean}.${col}' | translate }}"
                                                                   ng-model="ctrl.bean.${col}" <#if col = lowerPk>ng-readonly="ctrl.readonlyID"</#if>
                                                                   name="${col}" ng-maxlength="32" required>
                                                            <div ng-show="addEditForm.${col}.$error.required"
                                                                 style="color:red" translate="${lowerBean}.${col}.notEmpty">
                                                            </div>
                                                            <div ng-show="addEditForm.${col}.$error.maxlength"
                                                                 style="color:red" translate="${lowerBean}.${col}.length">
                                                            </div>
                                                            <div ng-show="addEditForm.${col}.$error.pattern"
                                                                 style="color:red" translate="common.illegalChar">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
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

</div><!-- end controller -->
</body>

</html>