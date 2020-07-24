<#list camelColumns as col>
    "${lowerBean}.${col.camelName}":"${col.camelName}",
    "${lowerBean}.${col.camelName}.notEmpty":"${col.camelName} can not be empty",
    "${lowerBean}.${col.camelName}.length":"${col.camelName} cannot exceed 32 bits",
</#list>
    "common.${lowerBean}":"${bean}",
    "common.${lowerBean}M":"${bean} Manage",
    "${lowerBean}.${lowerBean}Add":"${bean} Add",
    "${lowerBean}.${lowerBean}Edit":"${bean} Edit"