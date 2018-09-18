package com.jpj.cpss.controller;


import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jpj.cpss.bean.Msg;
import com.jpj.cpss.bean.Product;
import com.jpj.cpss.service.ProductService;
import com.jpj.cpss.utils.ExcelUtil;

@Controller
public class ProductController {

	@Autowired
	ProductService productService;
	
	
	
/*	@ResponseBody
	@RequestMapping(value="/proselectby",method=RequestMethod.GET)
	public Msg ProSelectBy(@RequestParam("select_type")String select_type,@RequestParam("select_text")String select_text){
		List<Product> products = productService.ProSelectBy(select_type, select_text);
		return Msg.success();
	}*/

	/**
	 * 根据产品名称 订单数量 修改产品数量
	 * 订单添加界面
	 * @param proNum
	 * @param proName
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/proNum",method=RequestMethod.POST)
	public Msg updateProNum(@RequestParam("proNum")Integer proNum,@RequestParam("proName")String proName){
		productService.updateProNum(proNum, proName);
		return Msg.success();
	}
	
	/**
	 * 删除产品 单个 批量 二合一
	 * 批量删除： id用- 隔开  1-2-3
	 * 单个删除：  1
	 * @param productId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/pro/{productIds}",method=RequestMethod.DELETE)
	public Msg delectProById(@PathVariable("productIds")String productIds){
		//批量删除
		if(productIds.contains("-")){
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = productIds.split("-");
			//组装id的集合		
			for(String productId : str_ids){
				del_ids.add(Integer.parseInt(productId));
			}
			productService.deteleBatch(del_ids);
		}else{  //单个删除	
			Integer productId = Integer.parseInt(productIds);
	//		System.out.println(productId);
			productService.delectProduct(productId);
		}
		return Msg.success();
	}
	
	/**
	 * 修改数据
	 * @param product
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/pro/{productId}",method=RequestMethod.PUT )
	public Msg updatePro(Product product){
		//System.out.println("将要修改的员工数据："+product);
		productService.updatePro(product);
		return Msg.success();
	}
	/**
	 * 查询产品通过ID
	 * 查询界面
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/pro/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getPro(@PathVariable("id")Integer id){
		Product product = productService.getPro(id);
		return Msg.success().add("pro", product);
	}
	
	
	
	/**
	 * 普通用户界面 查询显示所有产品信息
	 * @param pn
	 * @return
	 */
	@RequestMapping("/products")
	@ResponseBody
	public Msg getProductsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "order_by") String order_by,
			@RequestParam(value = "select_type") String select_type,
			@RequestParam(value = "select_text") String select_text,
			@RequestParam(value = "coll_flag") String coll_flag,
			@RequestParam(value = "loginname") String loginname) {
		// 引入PageHelper分页插件
		// 只需要在查询之前调用，传入页码，页面大小
		PageHelper.startPage(pn, 6);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Product> products = productService.getAllBy(order_by,select_type,select_text,coll_flag,loginname);
		// 用PageInfo对结果进行包装，只需要将PageInfo交给页面就可以,
		// PageInfo封装了详细的分页信息，包括查询的数据,传入连续显示的页数
		PageInfo page = new PageInfo(products,5);
		return Msg.success().add("pageInfo",page);
	}
	
	
	@RequestMapping("/export")
	@ResponseBody
	public void export(){
		//获取数据
		List<Product>  listAll = productService.getAll();
		//excel标题	
				String[] title = {"ID","名称","价格","分类","库存","描述"};
		//创建excel工作薄
				HSSFWorkbook workbook = new HSSFWorkbook();
				//创建一个工作表sheet
				HSSFSheet sheet = workbook.createSheet();
				//创建第一行
				HSSFRow firstrow = sheet.createRow(0);
				HSSFCell cell = null;
				
				for(int i = 0;i<title.length;i++){
					cell=firstrow.createCell(i);
					cell .setCellValue(title[i]);
				}
		
		//excel文件名
		String fileName = "商品信息表"+System.currentTimeMillis()+".xls";
		//sheet名
        String sheetName = "商品信息表";
        String[][] content = new String[15][];
        for (int i = 0; i < listAll.size(); i++) {
           
		   content[i] = new String[title.length];
           Product obj = listAll.get(i);
           content[i][0] = obj.getProductId().toString();
           content[i][1] = obj.getProductName().toString();
           content[i][2] = obj.getProductPrice().toString();
           content[i][3] = obj.getProductGenre().toString();
           content[i][4] = obj.getProductNum().toString();
           content[i][5] = obj.getProductDescribe().toString();
      	}
       /* for(int i = 0;i<content.length;i++){
        	for(int j = 0;j<content[0].length;j++){
        		System.out.print(content[i][j]);
        	}System.out.println();
        }*/
        for (int i = 1; i < content.length; i++) {
			HSSFRow nextrow = sheet.createRow(i);
			for(int j = 0;j<content[i].length;j++){
				HSSFCell cell2 = nextrow.createCell(j);
				cell2.setCellValue(content[i][j]);
			}
        }
	
        File file = new File("D:/poi_test.xls");
		try {
			file.createNewFile();
			
			//将excel存盘
			FileOutputStream stream = new FileOutputStream(file);
			workbook.write(stream);
			stream.close();
		} catch (IOException e) {
			
			e.printStackTrace();
		}
      /*	//创建HSSFWorkbook 
        HSSFWorkbook wb = ExcelUtil.getHSSFWorkbook(sheetName, title, content, null);
      //响应到客户端
        File file = new File("D:/poi_test1.xls");
       try {
		FileOutputStream stream = new FileOutputStream(file);
		//将excel存盘
		wb.write(stream);
		stream.close();
       } catch (FileNotFoundException e) {
    	   // TODO Auto-generated catch block
    	   e.printStackTrace();
       } catch (IOException e) {
    	   // TODO Auto-generated catch block
    	   e.printStackTrace();
       }*/
	}
	
	
	/**
	 * 管理员导航显示产品界面
	 * @return
	 */
	@RequestMapping("/product/selectProduct")
	 public String selectProduct(){
		return "product/m_right";
		
	}
	
	/**
	 * 管理员导航显示产品界面
	 * @return
	 */
	@RequestMapping("/product/selectMyProduct")
	 public String selectMyProduct(){
		
		return "product/myProductList";
		
	}
	/**
	 * 检查产品名称是否可用
	 * @param proName
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkproname")
	public Msg checkproname(@RequestParam("proName")String proName){
		//判断产品名称是否合法
		String 	regex = "(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{1,10})";
		if(!proName.matches(regex)){
			return Msg.fail().add("va_msg", "名称格式为3-16位英文，数字或1-10位中文！");
		}
		
		boolean b = productService.checkProName(proName);
		if(b){
			return Msg.success();
		}
		else{
			return Msg.fail().add("va_msg", "产品名称已存在！");
		}	
	}
	
	@RequestMapping("/top")
	 public String showTop(){
		
		return "m_top";
		
	}
	@RequestMapping("/left")
	 public String showleft(){
		
		return "m_left";	
	}
	
	@RequestMapping("/userleft")
	 public String showuserleft(){
		
		return "userleft";	
	}
	
	/**
	 * 返回所有产品分类信息
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/ProsGenre")
	 public Msg getAllPros(){
		//查出的所有产品信息
		List<String>  AllProGenres= productService.getAllProsGenre();
		return Msg.success().add("Pros", AllProGenres);		
	}
	
	/**
	 * 获取产品名称，价格
	 * 订单添加界面
	 * 返回所有产品信息
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/Prosname")
	 public Msg getAll(){
		//查出的所有产品信息
		List<Product>  listAll = productService.getAll();
		return Msg.success().add("Pronps", listAll);		
	}
	/**
	 * 根据产品名称获取价格 ,库存
	 * 订单添加界面
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/Proprice")
	 public Msg getAllprice(@RequestParam("productName")String  productName){
		//查出的所有产品信息
		List<Product>  AllProprice= productService.getAllprice(productName);
		return Msg.success().add("Proprices", AllProprice);		
	}
	


	
	/**
	 * 产品信息保存
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/pro",method=RequestMethod.POST)
	public Msg savepros(@Valid Product product,BindingResult result){
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
			productService.savePro(product);
			return Msg.success();

		
		}

	}
	
	//@RequestMapping("/products")
	/*public String  getProducts(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model) {
		
		//引入PageHelper分页插件
		//只需要在查询之前调用，传入页码，页面大小
		PageHelper.startPage(pn,5);
		//startPage后面紧跟的这个查询就是一个分页查询
		List<Product> products = productService.getAll();
		//用PageInfo对结果进行包装，只需要将PageInfo交给页面就可以,
		//PageInfo封装了详细的分页信息，包括查询的数据,传入连续显示的页数
		PageInfo page = new PageInfo(products,5);
		model.addAttribute("pageInfo",page);

		return "list";
	}*/
	
	/*
	 * 导出产品excel表
	 */
	@RequestMapping(value = "/downLoadExcel", method = RequestMethod.GET)
    public String downLoadExcel(HttpServletRequest request, HttpServletResponse response) throws IOException{
		List<Product>  listAll = productService.getAll();
        if (listAll != null && listAll.size() > 0) {
            String fileName = "产品表.xls";
            response.setHeader("Content-disposition", "attachment;filename="
                    + new String(fileName.getBytes("gb2312"), "ISO8859-1"));//设置文件头编码格式
            response.setContentType("APPLICATION/OCTET-STREAM;charset=UTF-8");//设置类型
            response.setHeader("Cache-Control", "no-cache");//设置头
            response.setDateHeader("Expires", 0);//设置日期头

            HSSFWorkbook proworkbook = new HSSFWorkbook();

            HSSFSheet prosheet = proworkbook.createSheet();
            CellStyle cellStyle = proworkbook.createCellStyle();

            cellStyle.setDataFormat(proworkbook.createDataFormat().getFormat("yyyy-MM-dd HH:mm:ss"));

            
            // 设置字体
            HSSFFont font = proworkbook.createFont();
            font.setFontHeightInPoints((short) 20); //字体高度
            font.setColor(HSSFFont.COLOR_RED); //字体颜色
            font.setFontName("黑体"); //字体
            font.setItalic(true); //是否使用斜体
     
            prosheet.setColumnWidth(0, 2000);
            prosheet.setColumnWidth(1, 3000);
            prosheet.setColumnWidth(2, 2000);
            prosheet.setColumnWidth(3, 3500);
            prosheet.setColumnWidth(4, 2000);
            prosheet.setColumnWidth(5, 12000);

            String[] title = {"ID","名称","价格","分类","库存","描述"};
            HSSFRow firstrow = prosheet.createRow(0);
			for(int i = 0;i<title.length;i++){
				HSSFCell cell=firstrow.createCell(i);
				cell .setCellValue(title[i]);
			}
			
            int rowNum = 1;
            for (Product product:listAll) {
                Row row = prosheet.createRow(rowNum);

                Cell cell = row.createCell(0);
 //               cell.setCellStyle(cellStyle);
                cell.setCellValue(product.getProductId());

                Cell cell1 = row.createCell(1);
                cell1.setCellValue(product.getProductName());

                Cell cell2 = row.createCell(2);
                cell2.setCellValue(product.getProductPrice());

                Cell cell3 = row.createCell(3);
                cell3.setCellValue(product.getProductGenre());

                Cell cell4 = row.createCell(4);
                cell4.setCellValue(product.getProductNum());

                Cell cell5 = row.createCell(5);
                cell5.setCellValue(product.getProductDescribe());

                rowNum++;
            }

            proworkbook.write(response.getOutputStream());

            response.getOutputStream().flush();
            response.getOutputStream().close();
        }
        return null;
    }
	
	
}
