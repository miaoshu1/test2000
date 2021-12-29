package com.bjpowernode.crm.services;

import com.bjpowernode.crm.mapper.DeptMapper;
import com.bjpowernode.crm.pojo.Dept;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeptServiceImpl implements DeptService{

    @Autowired
    private DeptMapper deptMapper;

    @Override
    public List getAll() {
        return deptMapper.getAll();
    }

    @Override
    public void save(Dept dept) {
        deptMapper.save(dept);
    }

    @Override
    public void edit(Dept dept) {
        deptMapper.edit(dept);
    }

    @Override
    public Dept get(String id) {
        return deptMapper.get(id);

    }

    @Override
    public void del(String[] ids) {
        deptMapper.del(ids);
    }
}
