package com.bjpowernode.crm.services;

import com.bjpowernode.crm.mapper.DeptMapper;
import com.bjpowernode.crm.pojo.Dept;
import com.bjpowernode.crm.utils.UUIDUtil;
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
        dept.setId(UUIDUtil.getUUID());
        String no = dept.getNo();
        if (deptMapper.getRepeat(no)){
            throw new RuntimeException("部门编码重复！");
        }
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
