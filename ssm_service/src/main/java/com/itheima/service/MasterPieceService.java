package com.itheima.service;

import com.itheima.domain.MasterPiece;

import java.util.List;

public interface MasterPieceService {

    public List<MasterPiece> findAll();

    public MasterPiece findById(Integer id);

    public void updateViewNum(Integer i, Integer id);

    public void updateFavorNum(MasterPiece masterPiece);

    public List<MasterPiece> findByUid(Integer uid);

    public void deleteById(Integer mid);
}
