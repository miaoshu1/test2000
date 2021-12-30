package com.bjpowernode.crm.web.controller;

import com.bjpowernode.crm.constants.Constants;
import com.bjpowernode.crm.pojo.Activity;
import com.bjpowernode.crm.pojo.User;
import com.bjpowernode.crm.services.ActService;
import com.bjpowernode.crm.utils.DateTimeUtil;
import com.bjpowernode.crm.utils.UUIDUtil;
import org.apache.ibatis.annotations.Param;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("act")
public class ActivityController {

    @Autowired
    ActService actService;

    @GetMapping("activities.json")
    // @RequestParam: 将参数封装成map，参数名为map的key
    public List getActivities(@RequestParam Map conditions){
        return actService.getAll(conditions);
    }

    @PostMapping("save.do")
    public Map save(Activity activity, HttpSession session){
        User user = (User) session.getAttribute(Constants.LOGIN_USER);
        String createBy = user.getLoginAct() + "_" + user.getName();
        activity.setCreateBy(createBy);
        actService.save(activity);
        return Constants.Result.SUC_WITH_MSG;
    }

    @GetMapping("activity.json")
    public Activity getActivity(String id){
        Activity activity = actService.get(id);
        return activity;
    }

    @PutMapping("edit.do")
    public Map edit(Activity activity,HttpSession session){
        User user = (User) session.getAttribute(Constants.LOGIN_USER);
        String editBy = user.getLoginAct() + "_" + user.getName();
        activity.setEditBy(editBy);
        actService.edit(activity);
        return Constants.Result.SUC_WITH_MSG;
    }

    @DeleteMapping("del.do")
    public Map del(String[] ids){
        actService.delete(ids);
        return Constants.Result.SUC_WITH_MSG;
    }

    @GetMapping("export.do")
    public void export(HttpServletResponse response) throws IOException {
        //创建一个Excel文件
        HSSFWorkbook excel = new HSSFWorkbook();
        //创建页签(Sheet)
        HSSFSheet sheet = excel.createSheet();
        //创建行：第1行，索引为0，一般第一行为标题
        int rowIndex = 0;
        HSSFRow row = sheet.createRow(rowIndex++);
        //创建单元格，并设置值
        int cellIndex = 0;
        row.createCell(cellIndex++).setCellValue("名称");
        row.createCell(cellIndex++).setCellValue("所有者");
        row.createCell(cellIndex++).setCellValue("开启日期");
        row.createCell(cellIndex++).setCellValue("结束日期");

        //查询需要导出的数据
        List<Activity> data = actService.getAll(null);

        //生成数据行
        for (Activity activity : data) {
            row = sheet.createRow(rowIndex++);

            cellIndex = 0;
            row.createCell(cellIndex++).setCellValue(activity.getName());
            row.createCell(cellIndex++).setCellValue(activity.getOwner());
            row.createCell(cellIndex++).setCellValue(activity.getStartDate());
            row.createCell(cellIndex++).setCellValue(activity.getEndDate());
        }

        //设置文件名
        response.setHeader("Content-Disposition","attachment;filename=\"activity.xls\"");

        //将文件输出到客户端（下载）
        excel.write(response.getOutputStream());
    }

    @PostMapping("import.do")
    public Map _import(MultipartFile upFile,HttpSession session) throws IOException {
        User user = (User) session.getAttribute(Constants.LOGIN_USER);
        String createBy = user.getLoginAct() + "_" + user.getName();
        String createTime = DateTimeUtil.getSysTime();

        List data = new ArrayList();

        HSSFWorkbook excel = new HSSFWorkbook(upFile.getInputStream());
        HSSFSheet sheetAt = excel.getSheetAt(0);//获取第一个标签
        HSSFRow row;

        //第1行为标题行，所以数据行的索引从1开始
        int rowIndex = 1;
        while ((row = sheetAt.getRow(rowIndex++)) != null){
            int cellIndex = 0;
            Activity activity = new Activity();

            String name = row.getCell(cellIndex++).getStringCellValue();
            String owner = row.getCell(cellIndex++).getStringCellValue();
            String startDate = row.getCell(cellIndex++).getStringCellValue();
            String endDate = row.getCell(cellIndex++).getStringCellValue();

            activity.setId(UUIDUtil.getUUID());
            activity.setName(name);
            activity.setOwner(owner);
            activity.setStartDate(startDate);
            activity.setEndDate(endDate);

            activity.setCreateBy(createBy);
            activity.setCreateTime(createTime);

            data.add(activity);

        }

        actService.saveList(data);

        return Constants.Result.SUC_WITH_MSG;
    }
}
