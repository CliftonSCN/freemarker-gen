package ${package}.api.service.api;

import com.zbensoft.${projectName}.db.domain.${bean};
import java.util.List;

public interface ${bean}Service {

int deleteByPrimaryKey(String id);


int insert(${bean} record);


int insertSelective(${bean} record);


${bean} selectByPrimaryKey(String id);


int updateByPrimaryKeySelective(${bean} record);


int updateByPrimaryKey(${bean} record);


List<${bean}> selectPage(${bean} record);


int count(${bean} record);
}