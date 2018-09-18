package com.jpj.cpss.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jpj.cpss.bean.Msg;
import com.jpj.cpss.bean.Order;
import com.jpj.cpss.bean.Product;
import com.jpj.cpss.bean.Users;
import com.jpj.cpss.service.OrderService;
import com.jpj.cpss.service.ProductService;


@Controller
public class OrderController {
	
	@Autowired
	OrderService orderService;
	@Autowired
	ProductService productService;
	
	/**
	 * 修改数据
	 * @param product
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/order/{orderId}",method=RequestMethod.PUT )
	public Msg updateOrder(Order order){
		//System.out.println("将要修改的员工数据："+product);
		orderService.updateOrder(order);
		return Msg.success();
	}

	/**
	 * 导航  管理员界面显示订单界面
	 * @return
	 */
	@RequestMapping("/order/selectOrder")
	 public String selectOrder(){
		return "order/orderlist";
	}
	
	
	/**
	 * 导航  普通用户界面显示订单界面
	 * @return
	 */
	@RequestMapping("/order/selectMyOrder")
	 public String selectMyOrder(){
		return "order/ordermylist";
	}

	/**
	 * 查询并分页显示全部信息，
	 * @param pn
	 * @return
	 */
	@RequestMapping("/orders")
	@ResponseBody
	public Msg getOrdersWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		// 引入PageHelper分页插件
		// 只需要在查询之前调用，传入页码，页面大小
		PageHelper.startPage(pn, 6);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Order> orders = orderService.getAll();
		// 用PageInfo对结果进行包装，只需要将PageInfo交给页面就可以,
		// PageInfo封装了详细的分页信息，包括查询的数据,传入连续显示的页数
		PageInfo page = new PageInfo(orders,5);
		return Msg.success().add("pageInfo",page);
	}
	
	
	/**
	 * 查询并分页显示用户自己的订单信息，
	 * @param pn
	 * @return
	 */
	@RequestMapping("/myorder")
	@ResponseBody
	public Msg getMyOrderWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "loginname") String loginname) {
		// 引入PageHelper分页插件
		// 只需要在查询之前调用，传入页码，页面大小
		PageHelper.startPage(pn, 6);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Order> orders = orderService.getAllMyOrder(loginname);
		// 用PageInfo对结果进行包装，只需要将PageInfo交给页面就可以,
		// PageInfo封装了详细的分页信息，包括查询的数据,传入连续显示的页数
		PageInfo page = new PageInfo(orders,5);
		return Msg.success().add("pageInfo",page);
	}
	/**
	 * 订单信息保存
	 * 订单添加界面
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/order",method=RequestMethod.POST)
	public Msg savepros(@Valid Order order,BindingResult result){
		if(result.hasErrors()){
			//校验失败，返回失败，在模态框中显示错误信息
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名："+fieldError.getField());
				System.out.println("错误信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(),fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}
		else{
			orderService.saveOrder(order);
			return Msg.success();	
		}
	}
	
	/**
	 * 查询产品通过ID
	 * 查询界面
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/order/{orderId}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getPro(@PathVariable("orderId")Integer orderId){
		Order order = orderService.getOrderById(orderId);
		return Msg.success().add("order", order);
	}
	
	/**
	 * 删除产品 单个 批量 二合一
	 * 批量删除： id用- 隔开  1-2-3
	 * 单个删除：  1
	 * @param productId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/order/{orderIds}",method=RequestMethod.DELETE)
	public Msg delectProById(@PathVariable("orderIds") String orderIds){
		//批量删除
		if(orderIds.contains("-")){
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = orderIds.split("-");
			//组装id的集合		
			for(String orderId : str_ids){
				del_ids.add(Integer.parseInt(orderId));
			}
			orderService.deteleBatch(del_ids);
		}else{  //单个删除	
			Integer orderId = Integer.parseInt(orderIds);
	//		System.out.println(productId);
			orderService.delectOrder(orderId);
		}
		return Msg.success();
	}
	
	/**
	 * 删除商品的时候同时根据名称发送请求删除相关订单
	 * 管理员商品界面删除
	 * @param productName
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/orderdeletebyname}",method=RequestMethod.DELETE)
	public Msg delectProByName(@RequestParam("productName") String productName){
		orderService.deleteByName(productName);
		
		return Msg.success();
	
	}
	
	@ResponseBody
	@RequestMapping(value="/updateNumbyName",method=RequestMethod.GET)
	public Msg updateNumbyName(@RequestParam("loginname") String loginname){
	
		List<Order> orders = orderService.selectProByName(loginname);
		for (int i = 0; i < orders.size(); i++) {
			Order order = orders.get(i);
			String productName = order.getProductName();
			int orderNum = order.getOrderNum();
			productService.updateProNum(-orderNum, productName);
		}
		return Msg.success();
	
	}
	
	/**
	 * 订单添加  购物车界面
	 * 订单添加界面
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/savemyorder",method=RequestMethod.POST)
	public Msg saveMyOrders(@RequestParam(value = "loginname") String loginname
			,@RequestParam(value = "productName") String productName
			,@RequestParam(value = "productPrice") Integer productPrice
			,@RequestParam(value = "orderNum") Integer orderNum
			,@RequestParam(value = "orderTotal") Integer orderTotal
			){
		
			orderService.saveMyOrder(loginname,productName,productPrice,orderNum,orderTotal);
			return Msg.success();	
		
	}
	
	/*
	 * 导出订单excel表
	 */
	@RequestMapping(value = "/orderdownLoadExcel", method = RequestMethod.GET)
    public String downLoadExcel(HttpServletRequest request, HttpServletResponse response) throws IOException{
		List<Order>  listAll = orderService.getAll();
        if (listAll != null && listAll.size() > 0) {
            String fileName = "订单表.xls";
            response.setHeader("Content-disposition", "attachment;filename="
                    + new String(fileName.getBytes("gb2312"), "ISO8859-1"));//设置文件头编码格式
            response.setContentType("APPLICATION/OCTET-STREAM;charset=UTF-8");//设置类型
            response.setHeader("Cache-Control", "no-cache");//设置头
            response.setDateHeader("Expires", 0);//设置日期头

            HSSFWorkbook orderworkbook = new HSSFWorkbook();

            HSSFSheet ordersheet = orderworkbook.createSheet();
            CellStyle cellStyle = orderworkbook.createCellStyle();

            cellStyle.setDataFormat(orderworkbook.createDataFormat().getFormat("yyyy-MM-dd HH:mm:ss"));

            
            // 设置字体
            HSSFFont font = orderworkbook.createFont();
            font.setFontHeightInPoints((short) 20); //字体高度
            font.setColor(HSSFFont.COLOR_RED); //字体颜色
            font.setFontName("黑体"); //字体
            font.setItalic(true); //是否使用斜体
     
            ordersheet.setColumnWidth(0, 2000);
            ordersheet.setColumnWidth(1, 3000);
            ordersheet.setColumnWidth(2, 4000);
            ordersheet.setColumnWidth(3, 2000);
            ordersheet.setColumnWidth(4, 3000);

            String[] title = {"ID","账号","产品名称","产品价格","产品数量","总价"};
            HSSFRow firstrow = ordersheet.createRow(0);
			for(int i = 0;i<title.length;i++){
				HSSFCell cell=firstrow.createCell(i);
				cell .setCellValue(title[i]);
			}
			
            int rowNum = 1;
            for (Order order:listAll) {
                Row row = ordersheet.createRow(rowNum);

                Cell cell = row.createCell(0);
                cell.setCellValue(order.getOrderId());

                Cell cell1 = row.createCell(1);
                cell1.setCellValue(order.getLoginname());

                Cell cell2 = row.createCell(2);
                cell2.setCellValue(order.getProductName());

                Cell cell3 = row.createCell(3);
                


                cell3.setCellValue(order.getProductPrice());

                Cell cell4 = row.createCell(4);
                cell4.setCellValue(order.getOrderNum());
                
                Cell cell5 = row.createCell(5);
                cell5.setCellValue(order.getOrderTotal());

                rowNum++;
            }

            orderworkbook.write(response.getOutputStream());

            response.getOutputStream().flush();
            response.getOutputStream().close();
        }
        return null;
    }
	
	/**
	 * 导航生成报表界面
	 * @return
	 */
	@RequestMapping(value="/order/showpic")
	 public String showupic(){
		return "order/showpic";	
	}
	
	/**
	 * 根据商品名称分组统计数量  生成报表界面
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/selectnumbyname",method=RequestMethod.GET)
	 public Msg selectnumbyname(){
		List<Integer> sum = orderService.selectnumbyname();
		List<String> names  = orderService.selectnamebyname();
		List<Integer> prices = orderService.selectpricebyname();
		return Msg.success().add("sum", sum).add("names", names).add("prices", prices);	
	}
	
	/**
	 * 
	 * 没用到
	 * 根据商品名称分组统计数量  生成报表界面
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/selectnumbygen",method=RequestMethod.GET)
	 public Msg selectnumbygen(){
		List<Integer> sum = orderService.selectnumbygen();
		List<String> names  = orderService.selectnamebygen();
		List<Integer> prices = orderService.selectpricebyname();
		return Msg.success().add("sum", sum).add("names", names).add("prices", prices);	
	}
}
