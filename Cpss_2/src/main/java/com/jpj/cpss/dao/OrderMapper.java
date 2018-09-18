package com.jpj.cpss.dao;

import com.jpj.cpss.bean.Order;
import com.jpj.cpss.bean.OrderExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface OrderMapper {
    long countByExample(OrderExample example);

    int deleteByExample(OrderExample example);

    int deleteByPrimaryKey(Integer orderId);

    int insert(Order record);

    int insertSelective(Order record);

    List<Order> selectByExample(OrderExample example);

    Order selectByPrimaryKey(Integer orderId);

    int updateByExampleSelective(@Param("record") Order record, @Param("example") OrderExample example);

    int updateByExample(@Param("record") Order record, @Param("example") OrderExample example);

    int updateByPrimaryKeySelective(Order record);

    int updateByPrimaryKey(Order record);
    
    List<Order> selectByloginname(String loginname);
    
    //自定义方法 根据产品名称查询数量
    List<Integer> countNumByName();
    //自定义方法 根据产品名称查询数量
    List<String> countNameByName();
    //自定义方法 根据产品类型查询数量
	List<Integer> countNumByGen();
	//自定义方法 根据产品类型查询数量
	List<String> countNameByGen();
	//自定义方法 根据产品名称查询价格
	List<Integer> selectpricebyname();
}