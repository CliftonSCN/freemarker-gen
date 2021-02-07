<select id="selectPage" parameterType="com.zbensoft.${projectName}.db.domain.${bean}" resultMap="BaseResultMap">
    <!--
      WARNING - @mbg.generated
      当保留注释时，再次运行mybatis generator会删除这个标签
    -->
    select
    <include refid="Base_Column_List" />
    from ${tableName} where 1=1
    <#if p_k??>
    <if test="${lowerPk} != null and ${lowerPk} !=''">
        and ${p_k} = <#noparse>#{</#noparse>${lowerPk},jdbcType=VARCHAR<#noparse>}</#noparse>
    </if>
    </#if>
</select>

<select id="count" parameterType="com.zbensoft.${projectName}.db.domain.${bean}" resultType="int">
    <!--
      WARNING - @mbg.generated
      当保留注释时，再次运行mybatis generator会删除这个标签
    -->
    select
    count(1)
    from ${tableName} where 1=1
    <#if p_k??>
        <if test="${lowerPk} != null and ${lowerPk} !=''">
            and ${p_k} = <#noparse>#{</#noparse>${lowerPk},jdbcType=VARCHAR<#noparse>}</#noparse>
        </if>
    </#if>
</select>