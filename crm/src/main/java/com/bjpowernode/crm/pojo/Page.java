package com.bjpowernode.crm.pojo;

import java.util.List;

public class Page {
    // 一下两个参数是分页的关键查询条件
    private Integer currentPage = 1;    // 页码(第几页)
    private Integer rowsPerPage = 10;   // 每页显示的记录条数

    private Integer maxRowsPerPage = 100;// 每页最多显示的记录条数
    private Integer visiblePageLinks = 10;// 显示几个卡片

    // 以下三个参数需要在业务层进行处理（查询或计算）
    private Integer totalRows;// 总记录数
    private Integer totalPages;// 总页数
    private List data;

    public Integer getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(Integer currentPage) {
        this.currentPage = currentPage;
    }

    public Integer getRowsPerPage() {
        return rowsPerPage;
    }

    public void setRowsPerPage(Integer rowsPerPage) {
        this.rowsPerPage = rowsPerPage;
    }

    public Integer getMaxRowsPerPage() {
        return maxRowsPerPage;
    }

    public void setMaxRowsPerPage(Integer maxRowsPerPage) {
        this.maxRowsPerPage = maxRowsPerPage;
    }

    public Integer getVisiblePageLinks() {
        return visiblePageLinks;
    }

    public void setVisiblePageLinks(Integer visiblePageLinks) {
        this.visiblePageLinks = visiblePageLinks;
    }

    public Integer getTotalRows() {
        return totalRows;
    }

    public void setTotalRows(Integer totalRows) {
        this.totalRows = totalRows;
    }

    public Integer getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(Integer totalPages) {
        this.totalPages = totalPages;
    }

    public List getData() {
        return data;
    }

    public void setData(List data) {
        this.data = data;
    }
}
