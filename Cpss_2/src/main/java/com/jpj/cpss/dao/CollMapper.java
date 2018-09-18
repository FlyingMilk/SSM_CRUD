package com.jpj.cpss.dao;

import com.jpj.cpss.bean.Coll;
import com.jpj.cpss.bean.CollExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface CollMapper {
    long countByExample(CollExample example);

    int deleteByExample(CollExample example);

    int deleteByPrimaryKey(Integer collId);

    int insert(Coll record);

    int insertSelective(Coll record);

    List<Coll> selectByExample(CollExample example);

    Coll selectByPrimaryKey(Integer collId);

    int updateByExampleSelective(@Param("record") Coll record, @Param("example") CollExample example);

    int updateByExample(@Param("record") Coll record, @Param("example") CollExample example);

    int updateByPrimaryKeySelective(Coll record);

    int updateByPrimaryKey(Coll record);
}