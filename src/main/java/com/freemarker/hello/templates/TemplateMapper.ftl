package ${package}.db.mapper;

import com.zbensoft.${projectName}.db.domain.${bean};

import java.util.List;

public interface ${bean}Mapper {

int deleteByPrimaryKey(String ${lowerPk});

int insert(${bean} record);

int insertSelective(${bean} record);

${bean} selectByPrimaryKey(String ${lowerPk});

int updateByPrimaryKeySelective(${bean} record);

int updateByPrimaryKey(${bean} record);

List<${bean}> selectPage(${bean} record);

int count(${bean} record);
}