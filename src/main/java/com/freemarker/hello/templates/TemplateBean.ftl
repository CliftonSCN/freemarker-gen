    <#list camelColumns as col>
        <#if col.foreignKey??>
        private String ${col.camelForeignTable}Name;

        public String get${col.upperForeignTable}Name() {
            return ${col.camelForeignTable}Name;
        }

        public void set${col.upperForeignTable}Name(String ${col.camelForeignTable}Name) {
            this.${col.camelForeignTable}Name = ${col.camelForeignTable}Name;
        }
        </#if>
    </#list>
