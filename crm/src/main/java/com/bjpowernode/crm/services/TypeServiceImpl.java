package com.bjpowernode.crm.services;

import com.bjpowernode.crm.mapper.TypeMapper;
import com.bjpowernode.crm.mapper.ValueMapper;
import com.bjpowernode.crm.pojo.Type;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TypeServiceImpl implements  TypeService{
    @Autowired
    TypeMapper typeMapper;

    @Autowired
    ValueMapper valueMapper;

    @Override
    public List getAll() {
        return typeMapper.getAll();
    }

    @Override
    public Object getRepeat(String id) {
        return typeMapper.getRepeat(id);
    }

    @Override
    public void save(Type type) {
        typeMapper.save(type);
    }

    @Override
    public Type get(String id) {
        return typeMapper.get(id);
    }

    @Override
    public void edit(Type type) {
        typeMapper.edit(type);
    }

    @Override
    public List getRelValue(String[] id) {
        return valueMapper.getRelValue(id);
    }

    @Override
    public void delete(String[] id) {
        typeMapper.delete(id);
    }

    @Override
    public void delForce(String[] id) {
        valueMapper.delForce(id);
        delete(id);
    }
}
