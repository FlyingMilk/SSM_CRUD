package com.jpj.cpss.dao;

import com.jpj.cpss.bean.Product;
import com.jpj.cpss.bean.ProductExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ProductMapper {

	long countByExample(ProductExample example);

    int deleteByExample(ProductExample example);

    int deleteByPrimaryKey(Integer productId);

    int insert(Product record);

    int insertSelective(Product record);

    List<Product> selectByExample(ProductExample example);

    Product selectByPrimaryKey(Integer productId);

    int updateByExampleSelective(@Param("record") Product record, @Param("example") ProductExample example);

    int updateByExample(@Param("record") Product record, @Param("example") ProductExample example);

    int updateByPrimaryKeySelective(Product record);

    int updateByPrimaryKey(Product record);

    List<String>   getAllProsGenre();

    /**
     * 自定义方法  计算剩余库存
     * @param proNum
     * @param proName
     */
	void updateProNum(@Param("proNum") Integer proNum,@Param("proName") String proName);





}