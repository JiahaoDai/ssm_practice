package com.itheima.controller;

import com.itheima.domain.Comments;
import com.itheima.domain.MasterPiece;
import com.itheima.domain.UserInfo;
import com.itheima.service.CommentsService;
import com.itheima.service.MasterPieceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/masterPiece")
public class MasterPieceController {

    @Autowired
    private CommentsService commentsService;

    @Autowired
    private MasterPieceService masterPieceService;

    @RequestMapping("/findAll")
    public @ResponseBody List<MasterPiece> findAll(){

        return masterPieceService.findAll();

    }
// 利用jsp中EL和jstl写的页面
//    @RequestMapping("/findById")
//    public ModelAndView findById(@RequestParam(value = "id", required = true) Integer id, @RequestParam(value = "viewNum", required = false) Integer viewNum){
//        ModelAndView mv = new ModelAndView();
//
//        MasterPiece masterPiece = masterPieceService.findById(id);
//        //自动更新访问数量ViewNum
//        if(viewNum != null){
//            masterPieceService.updateViewNum(viewNum+1, id);
//            masterPiece.setViewNum(viewNum+1);
//        }
//
//
//        mv.addObject("masterPiece", masterPiece);
//
//        mv.setViewName("surf/masterpiece");
//        return mv;
//    }

    @RequestMapping("/findById")
    @ResponseBody
    public MasterPiece findById(@RequestBody MasterPiece masterPiece, HttpServletRequest request){

        MasterPiece masterPiece_all = masterPieceService.findById(masterPiece.getId());
        HttpSession session = request.getSession();
        // 判断用户是否登录
        UserInfo userLogin = (UserInfo) session.getAttribute("userInfo");
        masterPiece_all.setUserLogin(userLogin);

        Integer viewNum = masterPiece.getViewNum();
        if(viewNum !=  0){
            // 说明不是评论完刷新，更新访问次数
            masterPieceService.updateViewNum(viewNum+1, masterPiece_all.getId());
            masterPiece_all.setViewNum(viewNum+1);
        }

        return masterPiece_all;
    }

    @RequestMapping("/updateFavorNum")
    @ResponseBody
    public boolean updateFavorNum(@RequestBody MasterPiece masterPiece, HttpServletRequest request){
        HttpSession session = request.getSession();
        UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
        if(userInfo != null){
            masterPiece.setFavorNum(masterPiece.getFavorNum()+1);
            masterPieceService.updateFavorNum(masterPiece);
            return true;
        }else{
            return false;
        }
    }

    @RequestMapping("/saveComments")
    @ResponseBody
    public void saveComments(@RequestBody Comments comments, HttpServletRequest request){
        HttpSession session = request.getSession();
        UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
        if(userInfo != null){
            comments.setUid(userInfo.getId());
            commentsService.save(comments);
        }
    }

    @RequestMapping("/findByUid")
    @ResponseBody
    public List<MasterPiece> findByUid(@RequestParam(value = "uid") Integer uid){

        return masterPieceService.findByUid(uid);
    }

    @RequestMapping("/deleteById")
    @ResponseBody
    public void deleteById(@RequestParam(value = "mid") Integer mid){
        masterPieceService.deleteById(mid);
    }

}
