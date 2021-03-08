package com.itheima.service.Imp;


import com.itheima.dao.Commentsdao;
import com.itheima.domain.Comments;
import com.itheima.service.CommentsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentsServiceImp implements CommentsService {

    @Autowired
    private Commentsdao commentsdao;

    @Override
    public void save(Comments comments) {
        commentsdao.save(comments);
    }
}
