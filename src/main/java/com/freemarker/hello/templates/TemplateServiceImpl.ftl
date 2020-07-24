package ${package}.service.impl;

import com.zbensoft.dmc.api.service.api.${bean}Service;
import com.zbensoft.dmc.db.domain.${bean};
import com.zbensoft.dmc.db.mapper.${bean}Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ${bean}ServiceImpl implements ${bean}Service {

@Autowired
${bean}Mapper ${lowerBean}Mapper;

@Override
public int deleteByPrimaryKey(String id) {
// TODO Auto-generated method stub
return ${lowerBean}Mapper.deleteByPrimaryKey(id);
}

@Override
public int insert(${bean} record) {
// TODO Auto-generated method stub
return ${lowerBean}Mapper.insert(record);
}

@Override
public int insertSelective(${bean} record) {
// TODO Auto-generated method stub
return ${lowerBean}Mapper.insertSelective(record);
}

@Override
public ${bean} selectByPrimaryKey(String id) {
// TODO Auto-generated method stub
return ${lowerBean}Mapper.selectByPrimaryKey(id);
}

@Override
public int updateByPrimaryKeySelective(${bean} record) {
// TODO Auto-generated method stub
return ${lowerBean}Mapper.updateByPrimaryKeySelective(record);
}

@Override
public int updateByPrimaryKey(${bean} record) {
// TODO Auto-generated method stub
return ${lowerBean}Mapper.updateByPrimaryKey(record);
}

@Override
public List<${bean}> selectPage(${bean} record) {
    // TODO Auto-generated method stub
    return ${lowerBean}Mapper.selectPage(record);
}

@Override
public int count(${bean} record) {
// TODO Auto-generated method stub
return ${lowerBean}Mapper.count(record);
}

}
