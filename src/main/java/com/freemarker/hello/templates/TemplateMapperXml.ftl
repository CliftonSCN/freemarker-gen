<select id="selectPage" parameterType="com.zbensoft.dmc.db.domain.${bean}" resultMap="BaseResultMap">
    select
    <include refid="Base_Column_List" />
    from ${tableName} where 1=1
</select>

<select id="count" parameterType="com.zbensoft.dmc.db.domain.${bean}" resultType="int">
    select
    count(1)
    from ${tableName} where 1=1
</select>