package com.bjpowernode.crm.mapper;

import com.bjpowernode.crm.pojo.Clue;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface ClueMapper {
    Integer getCount(@Param("search") Map search);

    List getPageData(@Param("search") Map search, @Param("start") int start, @Param("length") Integer rowsPerPage);

    void save(Clue clue);
}
