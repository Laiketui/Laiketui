<?php
/**
 * [Laike System] Copyright (c) 2017-2020 laiketui.com
 * Laike is not a free software, it under the license terms, visited http://www.laiketui.com/ for more details.
 */


class modifyAction extends PluginAction {

	public function getDefaultView() {
        $db = DBAction::getInstance();
        $request = $this->getContext()->getRequest();
        // 接收信息
        $id = intval($request->getParameter("id")); // 活动id
        $uploadImg = addslashes(trim($request->getParameter('uploadImg'))); // 图片上传位置
        // 根据插件id，查询插件信息
        $sql = 'select * from lkt_sign_activity where id='.$id;
        $res = $db -> select($sql);
        if($res){
            $id = $res[0]->id;
            $image = $res[0]->image;
            $starttime = $res[0]->starttime;
            $endtime = $res[0]->endtime;
            $detail = $res[0]->detail;
            $status = $res[0]->status;
        }

        $request->setAttribute("uploadImg",$uploadImg);
        $request->setAttribute("id",$id);
        $request->setAttribute("image",$image);
        $request->setAttribute("starttime",$starttime);
        $request->setAttribute("endtime",$endtime);
        $request->setAttribute("detail",$detail);
        $request->setAttribute("status",$status);
        return View :: INPUT;
	}

	public function execute(){
		$db = DBAction::getInstance();
		$request = $this->getContext()->getRequest();

        $id = addslashes(trim($request->getParameter('id'))); // 签到活动id
        $uploadImg = addslashes(trim($request->getParameter('uploadImg'))); // 图片上传位置
        $image = addslashes(trim($request->getParameter('image'))); // 新活动图片
        $oldpic = addslashes(trim($request->getParameter('oldpic'))); // 原活动图片
        $starttime = $request->getParameter('starttime'); // 活动开始时间
        $endtime = $request->getParameter('endtime'); // 活动结束时间
        $detail = addslashes(trim($request->getParameter('detail'))); // 活动介绍

        if($image){
            $image = preg_replace('/.*\//','',$image);
            if($image != $oldpic){
                @unlink ($uploadImg.$oldpic);
            }
        }else{
            $image = $oldpic;
        }
        if($starttime == ''){
            goBack("活动开始时间不能为空!");
        }
        $starttime = date('Y-m-d H:i:s',strtotime($starttime));
        if($endtime == ''){
            goBack("活动结束时间不能为空!");
        }
        // $endtime = date('Y-m-d 23:59:59',strtotime($endtime));
        if($starttime >= $endtime){
            goBack("活动开始时间不能大于等于活动结束时间!");
        }
        $time = date('Y-m-d H:i:s');
        if($time >= $endtime){
            goBack("活动还没开始就已经结束!");
        }
        // 查询所有签到活动
        $sql = "select * from lkt_sign_activity where id != '$id'";
        $r = $db->select($sql);
        if($r){
          for ($i=0; $i < count($r); $i++) {
            if($starttime >= $r[$i]->starttime && $starttime < $r[$i]->endtime || $endtime > $r[$i]->starttime && $endtime <= $r[$i]->endtime){
                goBack("活动有冲突!");
            }
          }
        }
        if($starttime > $time){
            //更新数据表
            $sql = "update lkt_sign_activity " .
                "set image = '$image',starttime = '$starttime',endtime = '$endtime',detail = '$detail',add_time = '$time',status = 0 " . "where id = '$id'";
            $r = $db->update($sql);
        }else{
            //更新数据表
            $sql = "update lkt_sign_activity " .
                "set image = '$image',starttime = '$starttime',endtime = '$endtime',detail = '$detail',add_time = '$time',status = 1 " . "where id = '$id'";
            $r = $db->update($sql);
        }
        if($r == -1) {
            goBack("未知原因,活动修改失败!");
        } else {
            jump("index.php?module=pi&p=sign","活动修改成功!");
        }
	}

	public function getRequestMethods(){
		return Request :: POST;
	}
}
?>