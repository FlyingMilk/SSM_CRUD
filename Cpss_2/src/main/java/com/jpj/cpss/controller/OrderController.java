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
	 * �޸�����
	 * @param product
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/order/{orderId}",method=RequestMethod.PUT )
	public Msg updateOrder(Order order){
		//System.out.println("��Ҫ�޸ĵ�Ա�����ݣ�"+product);
		orderService.updateOrder(order);
		return Msg.success();
	}

	/**
	 * ����  ����Ա������ʾ��������
	 * @return
	 */
	@RequestMapping("/order/selectOrder")
	 public String selectOrder(){
		return "order/orderlist";
	}
	
	
	/**
	 * ����  ��ͨ�û�������ʾ��������
	 * @return
	 */
	@RequestMapping("/order/selectMyOrder")
	 public String selectMyOrder(){
		return "order/ordermylist";
	}

	/**
	 * ��ѯ����ҳ��ʾȫ����Ϣ��
	 * @param pn
	 * @return
	 */
	@RequestMapping("/orders")
	@ResponseBody
	public Msg getOrdersWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		// ����PageHelper��ҳ���
		// ֻ��Ҫ�ڲ�ѯ֮ǰ���ã�����ҳ�룬ҳ���С
		PageHelper.startPage(pn, 6);
		// startPage��������������ѯ����һ����ҳ��ѯ
		List<Order> orders = orderService.getAll();
		// ��PageInfo�Խ�����а�װ��ֻ��Ҫ��PageInfo����ҳ��Ϳ���,
		// PageInfo��װ����ϸ�ķ�ҳ��Ϣ��������ѯ������,����������ʾ��ҳ��
		PageInfo page = new PageInfo(orders,5);
		return Msg.success().add("pageInfo",page);
	}
	
	
	/**
	 * ��ѯ����ҳ��ʾ�û��Լ��Ķ�����Ϣ��
	 * @param pn
	 * @return
	 */
	@RequestMapping("/myorder")
	@ResponseBody
	public Msg getMyOrderWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "loginname") String loginname) {
		// ����PageHelper��ҳ���
		// ֻ��Ҫ�ڲ�ѯ֮ǰ���ã�����ҳ�룬ҳ���С
		PageHelper.startPage(pn, 6);
		// startPage��������������ѯ����һ����ҳ��ѯ
		List<Order> orders = orderService.getAllMyOrder(loginname);
		// ��PageInfo�Խ�����а�װ��ֻ��Ҫ��PageInfo����ҳ��Ϳ���,
		// PageInfo��װ����ϸ�ķ�ҳ��Ϣ��������ѯ������,����������ʾ��ҳ��
		PageInfo page = new PageInfo(orders,5);
		return Msg.success().add("pageInfo",page);
	}
	/**
	 * ������Ϣ����
	 * ������ӽ���
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/order",method=RequestMethod.POST)
	public Msg savepros(@Valid Order order,BindingResult result){
		if(result.hasErrors()){
			//У��ʧ�ܣ�����ʧ�ܣ���ģ̬������ʾ������Ϣ
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("������ֶ�����"+fieldError.getField());
				System.out.println("������Ϣ��"+fieldError.getDefaultMessage());
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
	 * ��ѯ��Ʒͨ��ID
	 * ��ѯ����
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
	 * ɾ����Ʒ ���� ���� ����һ
	 * ����ɾ���� id��- ����  1-2-3
	 * ����ɾ����  1
	 * @param productId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/order/{orderIds}",method=RequestMethod.DELETE)
	public Msg delectProById(@PathVariable("orderIds") String orderIds){
		//����ɾ��
		if(orderIds.contains("-")){
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = orderIds.split("-");
			//��װid�ļ���		
			for(String orderId : str_ids){
				del_ids.add(Integer.parseInt(orderId));
			}
			orderService.deteleBatch(del_ids);
		}else{  //����ɾ��	
			Integer orderId = Integer.parseInt(orderIds);
	//		System.out.println(productId);
			orderService.delectOrder(orderId);
		}
		return Msg.success();
	}
	
	/**
	 * ɾ����Ʒ��ʱ��ͬʱ�������Ʒ�������ɾ����ض���
	 * ����Ա��Ʒ����ɾ��
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
	 * �������  ���ﳵ����
	 * ������ӽ���
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
	 * ��������excel��
	 */
	@RequestMapping(value = "/orderdownLoadExcel", method = RequestMethod.GET)
    public String downLoadExcel(HttpServletRequest request, HttpServletResponse response) throws IOException{
		List<Order>  listAll = orderService.getAll();
        if (listAll != null && listAll.size() > 0) {
            String fileName = "������.xls";
            response.setHeader("Content-disposition", "attachment;filename="
                    + new String(fileName.getBytes("gb2312"), "ISO8859-1"));//�����ļ�ͷ�����ʽ
            response.setContentType("APPLICATION/OCTET-STREAM;charset=UTF-8");//��������
            response.setHeader("Cache-Control", "no-cache");//����ͷ
            response.setDateHeader("Expires", 0);//��������ͷ

            HSSFWorkbook orderworkbook = new HSSFWorkbook();

            HSSFSheet ordersheet = orderworkbook.createSheet();
            CellStyle cellStyle = orderworkbook.createCellStyle();

            cellStyle.setDataFormat(orderworkbook.createDataFormat().getFormat("yyyy-MM-dd HH:mm:ss"));

            
            // ��������
            HSSFFont font = orderworkbook.createFont();
            font.setFontHeightInPoints((short) 20); //����߶�
            font.setColor(HSSFFont.COLOR_RED); //������ɫ
            font.setFontName("����"); //����
            font.setItalic(true); //�Ƿ�ʹ��б��
     
            ordersheet.setColumnWidth(0, 2000);
            ordersheet.setColumnWidth(1, 3000);
            ordersheet.setColumnWidth(2, 4000);
            ordersheet.setColumnWidth(3, 2000);
            ordersheet.setColumnWidth(4, 3000);

            String[] title = {"ID","�˺�","��Ʒ����","��Ʒ�۸�","��Ʒ����","�ܼ�"};
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
	 * �������ɱ������
	 * @return
	 */
	@RequestMapping(value="/order/showpic")
	 public String showupic(){
		return "order/showpic";	
	}
	
	/**
	 * ������Ʒ���Ʒ���ͳ������  ���ɱ������
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
	 * û�õ�
	 * ������Ʒ���Ʒ���ͳ������  ���ɱ������
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
