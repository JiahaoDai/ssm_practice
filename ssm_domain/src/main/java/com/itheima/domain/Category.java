package com.itheima.domain;

import java.util.List;

public class Category {
    private Integer id;
    private String categoryName;
    private String categoryDesc;
    private List<MasterPiece> masterPieces;

    public List<MasterPiece> getMasterPieces() {
        return masterPieces;
    }

    public void setMasterPieces(List<MasterPiece> masterPieces) {
        this.masterPieces = masterPieces;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getCategoryDesc() {
        return categoryDesc;
    }

    public void setCategoryDesc(String categoryDesc) {
        this.categoryDesc = categoryDesc;
    }


    @Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", categoryName='" + categoryName + '\'' +
                ", categoryDesc='" + categoryDesc + '\'' +
                '}';
    }
}
