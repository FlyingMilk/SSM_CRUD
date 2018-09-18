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
	 * ���ݲ�Ʒ���� �������� �޸Ĳ�Ʒ����
	 * ������ӽ���
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
	 * ɾ����Ʒ ���� ���� ����һ
	 * ����ɾ���� id��- ����  1-2-3
	 * ����ɾ����  1
	 * @param productId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/pro/{productIds}",method=RequestMethod.DELETE)
	public Msg delectProById(@PathVariable("productIds")String productIds){
		//����ɾ��
		if(productIds.contains("-")){
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = productIds.split("-");
			//��װid�ļ���		
			for(String productId : str_ids){
				del_ids.add(Integer.parseInt(productId));
			}
			productService.deteleBatch(del_ids);
		}else{  //����ɾ��	
			Integer productId = Integer.parseInt(productIds);
	//		System.out.println(productId);
			productService.delectProduct(productId);
		}
		return Msg.success();
	}
	
	/**
	 * �޸�����
	 * @param product
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/pro/{productId}",method=RequestMethod.PUT )
	public Msg updatePro(Product product){
		//System.out.println("��Ҫ�޸ĵ�Ա�����ݣ�"+product);
		productService.updatePro(product);
		return Msg.success();
	}
	/**
	 * ��ѯ��Ʒͨ��ID
	 * ��ѯ����
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
	 * ��ͨ�û����� ��ѯ��ʾ���в�Ʒ��Ϣ
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
		// ����PageHelper��ҳ���
		// ֻ��Ҫ�ڲ�ѯ֮ǰ���ã�����ҳ�룬ҳ���С
		PageHelper.startPage(pn, 6);
		// startPage��������������ѯ����һ����ҳ��ѯ
		List<Product> products = productService.getAllBy(order_by,select_type,select_text,coll_flag,loginname);
		// ��PageInfo�Խ�����а�װ��ֻ��Ҫ��PageInfo����ҳ��Ϳ���,
		// PageInfo��װ����ϸ�ķ�ҳ��Ϣ��������ѯ������,����������ʾ��ҳ��
		PageInfo page = new PageInfo(products,5);
		return Msg.success().add("pageInfo",page);
	}
	
	
	@RequestMapping("/export")
	@ResponseBody
	public void export(){
		//��ȡ����
		List<Product>  listAll = productService.getAll();
		//excel����	
				String[] title = {"ID","����","�۸�","����","���","����"};
		//����excel������
				HSSFWorkbook workbook = new HSSFWorkbook();
				//����һ��������sheet
				HSSFSheet sheet = workbook.createSheet();
				//������һ��
				HSSFRow firstrow = sheet.createRow(0);
				HSSFCell cell = null;
				
				for(int i = 0;i<title.length;i++){
					cell=firstrow.createCell(i);
					cell .setCellValue(title[i]);
				}
		
		//excel�ļ���
		String fileName = "��Ʒ��Ϣ��"+System.currentTimeMillis()+".xls";
		//sheet��
        String sheetName = "��Ʒ��Ϣ��";
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
			
			//��excel����
			FileOutputStream stream = new FileOutputStream(file);
			workbook.write(stream);
			stream.close();
		} catch (IOException e) {
			
			e.printStackTrace();
		}
      /*	//����HSSFWorkbook 
        HSSFWorkbook wb = ExcelUtil.getHSSFWorkbook(sheetName, title, content, null);
      //��Ӧ���ͻ���
        File file = new File("D:/poi_test1.xls");
       try {
		FileOutputStream stream = new FileOutputStream(file);
		//��excel����
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
	 * ����Ա������ʾ��Ʒ����
	 * @return
	 */
	@RequestMapping("/product/selectProduct")
	 public String selectProduct(){
		return "product/m_right";
		
	}
	
	/**
	 * ����Ա������ʾ��Ʒ����
	 * @return
	 */
	@RequestMapping("/product/selectMyProduct")
	 public String selectMyProduct(){
		
		return "product/myProductList";
		
	}
	/**
	 * ����Ʒ�����Ƿ����
	 * @param proName
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkproname")
	public Msg checkproname(@RequestParam("proName")String proName){
		//�жϲ�Ʒ�����Ƿ�Ϸ�
		String 	regex = "(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{1,10})";
		if(!proName.matches(regex)){
			return Msg.fail().add("va_msg", "���Ƹ�ʽΪ3-16λӢ�ģ����ֻ�1-10λ���ģ�");
		}
		
		boolean b = productService.checkProName(proName);
		if(b){
			return Msg.success();
		}
		else{
			return Msg.fail().add("va_msg", "��Ʒ�����Ѵ��ڣ�");
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
	 * �������в�Ʒ������Ϣ
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/ProsGenre")
	 public Msg getAllPros(){
		//��������в�Ʒ��Ϣ
		List<String>  AllProGenres= productService.getAllProsGenre();
		return Msg.success().add("Pros", AllProGenres);		
	}
	
	/**
	 * ��ȡ��Ʒ���ƣ��۸�
	 * ������ӽ���
	 * �������в�Ʒ��Ϣ
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/Prosname")
	 public Msg getAll(){
		//��������в�Ʒ��Ϣ
		List<Product>  listAll = productService.getAll();
		return Msg.success().add("Pronps", listAll);		
	}
	/**
	 * ���ݲ�Ʒ���ƻ�ȡ�۸� ,���
	 * ������ӽ���
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/Proprice")
	 public Msg getAllprice(@RequestParam("productName")String  productName){
		//��������в�Ʒ��Ϣ
		List<Product>  AllProprice= productService.getAllprice(productName);
		return Msg.success().add("Proprices", AllProprice);		
	}
	


	
	/**
	 * ��Ʒ��Ϣ����
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/pro",method=RequestMethod.POST)
	public Msg savepros(@Valid Product product,BindingResult result){
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
			productService.savePro(product);
			return Msg.success();

		
		}

	}
	
	//@RequestMapping("/products")
	/*public String  getProducts(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model) {
		
		//����PageHelper��ҳ���
		//ֻ��Ҫ�ڲ�ѯ֮ǰ���ã�����ҳ�룬ҳ���С
		PageHelper.startPage(pn,5);
		//startPage��������������ѯ����һ����ҳ��ѯ
		List<Product> products = productService.getAll();
		//��PageInfo�Խ�����а�װ��ֻ��Ҫ��PageInfo����ҳ��Ϳ���,
		//PageInfo��װ����ϸ�ķ�ҳ��Ϣ��������ѯ������,����������ʾ��ҳ��
		PageInfo page = new PageInfo(products,5);
		model.addAttribute("pageInfo",page);

		return "list";
	}*/
	
	/*
	 * ������Ʒexcel��
	 */
	@RequestMapping(value = "/downLoadExcel", method = RequestMethod.GET)
    public String downLoadExcel(HttpServletRequest request, HttpServletResponse response) throws IOException{
		List<Product>  listAll = productService.getAll();
        if (listAll != null && listAll.size() > 0) {
            String fileName = "��Ʒ��.xls";
            response.setHeader("Content-disposition", "attachment;filename="
                    + new String(fileName.getBytes("gb2312"), "ISO8859-1"));//�����ļ�ͷ�����ʽ
            response.setContentType("APPLICATION/OCTET-STREAM;charset=UTF-8");//��������
            response.setHeader("Cache-Control", "no-cache");//����ͷ
            response.setDateHeader("Expires", 0);//��������ͷ

            HSSFWorkbook proworkbook = new HSSFWorkbook();

            HSSFSheet prosheet = proworkbook.createSheet();
            CellStyle cellStyle = proworkbook.createCellStyle();

            cellStyle.setDataFormat(proworkbook.createDataFormat().getFormat("yyyy-MM-dd HH:mm:ss"));

            
            // ��������
            HSSFFont font = proworkbook.createFont();
            font.setFontHeightInPoints((short) 20); //����߶�
            font.setColor(HSSFFont.COLOR_RED); //������ɫ
            font.setFontName("����"); //����
            font.setItalic(true); //�Ƿ�ʹ��б��
     
            prosheet.setColumnWidth(0, 2000);
            prosheet.setColumnWidth(1, 3000);
            prosheet.setColumnWidth(2, 2000);
            prosheet.setColumnWidth(3, 3500);
            prosheet.setColumnWidth(4, 2000);
            prosheet.setColumnWidth(5, 12000);

            String[] title = {"ID","����","�۸�","����","���","����"};
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
