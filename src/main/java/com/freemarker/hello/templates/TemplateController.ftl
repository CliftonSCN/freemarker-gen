package ${package}.api.control;

import com.github.pagehelper.PageHelper;
import com.zbensoft.${projectName}.api.common.*;
import com.zbensoft.${projectName}.api.service.api.${bean}Service;
import com.zbensoft.${projectName}.db.domain.${bean};
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;
import com.zbensoft.${projectName}.common.util.DateUtil;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

<#list camelColumns as col>
    <#if col.foreignKey??>
        import com.zbensoft.${projectName}.api.service.api.${col.upperForeignTable}Service;
        import com.zbensoft.${projectName}.db.domain.${col.upperForeignTable};
    </#if>
</#list>

@RequestMapping(value = "/${lowerBean}")
@RestController
public class ${bean}Controller {

@Autowired
${bean}Service ${lowerBean}Service;

<#list camelColumns as col>
<#if col.foreignKey??>
    @Autowired
    ${col.upperForeignTable}Service ${col.camelForeignTable}Service;
</#if>
</#list>

@Resource
private LocaleMessageSourceService localeMessageSourceService;

@PreAuthorize("hasRole('R_${authorize}_Q')")
@ApiOperation(value = "Query ${bean}，Support paging", notes = "")
@RequestMapping(value = "", method = RequestMethod.GET)
public ResponseRestEntity<List<${bean}>> selectPage(@RequestParam(required = false) String id,
    @RequestParam(required = false) String start,
    @RequestParam(required = false) String length) {
    ${bean} bean = new ${bean}();
    bean.set${pk}(id);
    int count = ${lowerBean}Service.count(bean);
    if (count == 0) {
        return new ResponseRestEntity<List<${bean}>>(new ArrayList<${bean}>(), HttpRestStatus.NOT_FOUND);
    }
    List<${bean}> list = null;
    // 分页 start
    if (start != null && length != null) {// 需要进行分页
        /*
        * 第一个参数是第几页；第二个参数是每页显示条数。
        */
        int pageNum = PageHelperUtil.getPageNum(start, length);
        int pageSize = PageHelperUtil.getPageSize(start, length);
        PageHelper.startPage(pageNum, pageSize);
        list = ${lowerBean}Service.selectPage(bean);

    } else {
        list = ${lowerBean}Service.selectPage(bean);
    }
    if (list == null || list.isEmpty()) {
        return new ResponseRestEntity<List<${bean}>>(new ArrayList<${bean}>(),HttpRestStatus.NOT_FOUND);
    }

    <#if hasForeign??>
        for(${bean} item:list){
        <#list camelColumns as col>
            <#if col.foreignKey??>
                ${col.upperForeignTable} ${col.camelForeignTable} = ${col.camelForeignTable}Service.selectByPrimaryKey(item.get${col.upperName}());
                if (${col.camelForeignTable} != null) {
                    item.set${col.upperForeignTable}Name(${col.camelForeignTable}.getName());
                }
            </#if>
        </#list>
        }
    </#if>

    return new ResponseRestEntity<List<${bean}>>(list, HttpRestStatus.OK, count, count);
}

@PreAuthorize("hasRole('R_${authorize}_Q')")
@ApiOperation(value = "Query ${bean}", notes = "")
@RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
public ResponseRestEntity<${bean}> selectByPrimaryKey(@PathVariable("id") String id) {
    ${bean} bean = ${lowerBean}Service.selectByPrimaryKey(id);
    if (bean == null) {
        return new ResponseRestEntity<${bean}>(HttpRestStatus.NOT_FOUND);
    }
    return new ResponseRestEntity<${bean}>(bean, HttpRestStatus.OK);
}

@PreAuthorize("hasRole('R_${authorize}_E')")
@ApiOperation(value = "Add ${bean}", notes = "")
@RequestMapping(value = "", method = RequestMethod.POST)
public ResponseRestEntity<Void> create${bean}(@Valid @RequestBody ${bean} bean,BindingResult result, UriComponentsBuilder ucBuilder) {
    if (result.hasErrors()) {
        List<ObjectError> list = result.getAllErrors();
        return new ResponseRestEntity<Void>(HttpRestStatusFactory.createStatus(list),
        HttpRestStatusFactory.createStatusMessage(list));
    }
    ${bean} beanSelect = ${lowerBean}Service.selectByPrimaryKey(bean.get${pk}());
    if (beanSelect !=null) {
        return new ResponseRestEntity<Void>(HttpRestStatus.CONFLICT,localeMessageSourceService.getMessage("common.create.conflict.message"));
    }
    <#list camelColumns as col>
        <#if col.type == "TimeStamp">
            bean.set${col.upperName}(DateUtil.dateToTimeStamp(bean.get${col.upperName}()));
        </#if>
    </#list>

    <#if pk??>
        bean.set${pk}("${tableNameAbbr}"+ IDGenerate.generateCommTwo(IDGenerate.${authorize}));
    </#if>

    <#if pk??>
        bean.set${pk}("${tableNameAbbr}"+ DateUtil.convertDateToString(new Date(), DateUtil.DATE_FORMAT_THIRTEEN));
    </#if>


    ${lowerBean}Service.insert(bean);
    //新增日志
    CommonLogImpl.insertLog(CommonLogImpl.OPERTYPE_INSERT, bean,CommonLogImpl.ALARM);
    HttpHeaders headers = new HttpHeaders();
    headers.setLocation(ucBuilder.path("/${lowerBean}/{id}").buildAndExpand(bean.get${pk}()).toUri());
    return new ResponseRestEntity<Void>(headers, HttpRestStatus.CREATED,localeMessageSourceService.getMessage("common.create.created.message"));
}

@PreAuthorize("hasRole('R_${authorize}_E')")
@ApiOperation(value = "Edit ${bean}", notes = "")
@RequestMapping(value = "{id}", method = RequestMethod.PUT)
public ResponseRestEntity<${bean}> update${bean}(@PathVariable("id") String id,@Valid @RequestBody ${bean} bean, BindingResult result) {

    ${bean} beanSelect = ${lowerBean}Service.selectByPrimaryKey(id);

    if (beanSelect == null) {
        return new ResponseRestEntity<${bean}>(HttpRestStatus.NOT_FOUND,localeMessageSourceService.getMessage("common.update.not_found.message"));
    }

    if (result.hasErrors()) {
        List<ObjectError> list = result.getAllErrors();
        for (ObjectError error : list) {
            System.out.println(error.getCode() + "---" + error.getArguments() + "---" + error.getDefaultMessage());
        }
        return new ResponseRestEntity<${bean}>(beanSelect,HttpRestStatusFactory.createStatus(list),HttpRestStatusFactory.createStatusMessage(list));
    }
    <#list camelColumns as col>
        <#if col.type == "TimeStamp">
            beanSelect.set${col.upperName}(DateUtil.dateToTimeStamp(bean.get${col.upperName}()));
        <#else>
            beanSelect.set${col.upperName}(bean.get${col.upperName}());
        </#if>
    </#list>

    ${lowerBean}Service.updateByPrimaryKey(beanSelect);
    //修改日志
    CommonLogImpl.insertLog(CommonLogImpl.OPERTYPE_UPDATE, beanSelect,CommonLogImpl.ALARM);
    return new ResponseRestEntity<${bean}>(beanSelect, HttpRestStatus.OK,localeMessageSourceService.getMessage("common.update.ok.message"));
}


@PreAuthorize("hasRole('R_${authorize}_E')")
@ApiOperation(value = "Delete ${bean}", notes = "")
@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
public ResponseRestEntity<${bean}> delete${bean}(@PathVariable("id") String id) {

    ${bean} bean = ${lowerBean}Service.selectByPrimaryKey(id);
    if (bean == null) {
        return new ResponseRestEntity<${bean}>(HttpRestStatus.NOT_FOUND);
    }
    ${lowerBean}Service.deleteByPrimaryKey(bean.get${pk}());
    //删除日志开始
    ${bean} delBean = new ${bean}();
    delBean.set${pk}(id);
    CommonLogImpl.insertLog(CommonLogImpl.OPERTYPE_DELETE, delBean,CommonLogImpl.ALARM);
    //删除日志结束
    return new ResponseRestEntity<${bean}>(HttpRestStatus.NO_CONTENT);
}

}