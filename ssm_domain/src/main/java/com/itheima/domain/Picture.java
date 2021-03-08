package com.itheima.domain;

public class Picture {

    private Integer id;
    private String url;
    private Integer mid;

    private MasterPiece masterPiece;

    public MasterPiece getMasterPiece() {
        return masterPiece;
    }

    public void setMasterPiece(MasterPiece masterPiece) {
        this.masterPiece = masterPiece;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getMid() {
        return mid;
    }

    public void setMid(Integer mid) {
        this.mid = mid;
    }

    @Override
    public String toString() {
        return "Picture{" +
                "id=" + id +
                ", url='" + url + '\'' +
                ", mid=" + mid +
                '}';
    }
}
