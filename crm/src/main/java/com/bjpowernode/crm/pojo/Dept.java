package com.bjpowernode.crm.pojo;

public class Dept {
    private String id;
    private String no;
    private String name;
    private String manager;
    private String description;
    private String phone;

    public String getId() {
        if (id==null) return "";
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNo() {
        if (no==null) return "";
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    public String getName() {
        if (name==null) return "";
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getManager() {
        if (manager==null) return "";
        return manager;
    }

    public void setManager(String manager) {
        this.manager = manager;
    }

    public String getDescription() {
        if (description==null) return "";
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPhone() {
        if (phone==null) return "";
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}
