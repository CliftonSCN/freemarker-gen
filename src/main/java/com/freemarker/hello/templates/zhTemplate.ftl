<#list camelColumns as col>
    "${lowerBean}.${col}":"${col}",
    "${lowerBean}.${col}.notEmpty":"${col} can not be empty",
    "${lowerBean}.${col}.length":"${col} cannot exceed 32 bits",
</#list>
    "common.${lowerBean}":"${bean}",
    "common.${lowerBean}M":"${bean} Manage",
    "${lowerBean}.${lowerBean}Add":"${bean} Add",
    "${lowerBean}.${lowerBean}Edit":"${bean} Edit"