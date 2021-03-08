package com.itheima.service.Imp;

import com.itheima.dao.Categorydao;
import com.itheima.domain.Category;
import com.itheima.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class CategoryServiceImp implements CategoryService {

    @Autowired
    private Categorydao categorydao;

    @Override
    public List<Category> findAll() {
        return categorydao.findAll();
    }
}
