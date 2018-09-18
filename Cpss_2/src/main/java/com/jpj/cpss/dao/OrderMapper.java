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
    
    //�Զ��巽�� ���ݲ�Ʒ���Ʋ�ѯ����
    List<Integer> countNumByName();
    //�Զ��巽�� ���ݲ�Ʒ���Ʋ�ѯ����
    List<String> countNameByName();
    //�Զ��巽�� ���ݲ�Ʒ���Ͳ�ѯ����
	List<Integer> countNumByGen();
	//�Զ��巽�� ���ݲ�Ʒ���Ͳ�ѯ����
	List<String> countNameByGen();
	//�Զ��巽�� ���ݲ�Ʒ���Ʋ�ѯ�۸�
	List<Integer> selectpricebyname();
}