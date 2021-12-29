package com.bjpowernode.crm.services;

import com.bjpowernode.crm.mapper.ValueMapper;
import com.bjpowernode.crm.pojo.Value;
import com.bjpowernode.crm.utils.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ValueServiceImpl implements ValueService{

    @Autowired
    private ValueMapper valueMapper;

    @Override
    public List getAll() {
        return valueMapper.getAll();
    }

    @Override
    public void changeOrderNo(String id, String orderNo) {
        valueMapper.changeOrderNo(id,orderNo);
    }

    @Override
    public void changeOrderNos(String[] ids) {
        for (int i = 0; i < ids.length; i++) {
            valueMapper.changeOrderNo(ids[i],i+1+"");
        }
    }

    @Override
    public void save(Value value) {
        value.setId(UUIDUtil.getUUID());
        valueMapper.save(value);
    }

    @Override
    public Value get(String id) {
        return valueMapper.get(id);
    }

    @Override
    public void edit(Value value) {
        valueMapper.edit(value);
    }

    @Override
    public void del(String[] id) {
        valueMapper.del(id);
    }


}
