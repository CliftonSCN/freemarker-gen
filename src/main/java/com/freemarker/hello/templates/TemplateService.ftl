package ${package}.service.api;

import com.zbensoft.dmc.db.domain.${bean};

import java.util.List;

public interface ${bean}Service {

int deleteByPrimaryKey(String id);


int insert(${bean} record);


int insertSelective(${bean} record);


Device selectByPrimaryKey(String id);


int updateByPrimaryKeySelective(${bean} record);


int updateByPrimaryKey(${bean} record);


List<${bean}> selectPage(${bean} record);


int count(${bean} record);
}