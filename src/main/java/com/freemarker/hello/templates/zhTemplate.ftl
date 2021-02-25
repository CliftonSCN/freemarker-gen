<#list camelColumns as col>
    "${lowerBean}.${col.camelName}":"${col.upperName}",
    "${lowerBean}.${col.camelName}.notEmpty":"${col.upperName} can not be empty",
    "${lowerBean}.${col.camelName}.length":"${col.upperName} cannot exceed 32 bits",
</#list>
<#if foreignNames??>
<#list foreignNames as foreignName>
    "${lowerBean}.${foreignName}":"${foreignName}",
</#list>
</#if>
    "common.${lowerBean}":"${bean}",
    "common.${lowerBean}M":"${bean} Manage",
    "${lowerBean}.${lowerBean}Add":"${bean} Add",
    "${lowerBean}.${lowerBean}Edit":"${bean} Edit"