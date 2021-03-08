package com.itheima.service.Imp;


import com.itheima.dao.Commentsdao;
import com.itheima.dao.MasterPiecedao;
import com.itheima.dao.Picturedao;
import com.itheima.domain.MasterPiece;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MasterPieceServiceImp implements com.itheima.service.MasterPieceService {

    @Autowired
    private Commentsdao commentsdao;

    @Autowired
    private Picturedao picturedao;

    @Autowired
    private MasterPiecedao masterPiecedao;

    @Override
    public List<MasterPiece> findAll() {
        return masterPiecedao.findAll();
    }

    @Override
    public MasterPiece findById(Integer id) {
        return masterPiecedao.findById(id);
    }

    @Override
    public void updateViewNum(Integer i, Integer id) {
        masterPiecedao.updateViewNum(i, id);
    }

    @Override
    public void updateFavorNum(MasterPiece masterPiece) {
        masterPiecedao.updateFavorNum(masterPiece);
    }

    @Override
    public List<MasterPiece> findByUid(Integer uid) {
        return masterPiecedao.findByUid(uid);
    }


    /**
     * 删除作品
     * @param mid
     */
    @Override
    public void deleteById(Integer mid) {

        commentsdao.deleteByMid(mid);
        picturedao.deleteByMid(mid);
        masterPiecedao.deleteById(mid);
    }
}
