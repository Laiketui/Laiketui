<?php

/**

 * [Laike System] Copyright (c) 2017-2020 laiketui.com

 * Laike is not a free software, it under the license terms, visited http://www.laiketui.com/ for more details.

 */

require_once(MO_LIB_DIR . '/DBAction.class.php');

class ModifyAction extends Action {

	public function getDefaultView() {
       $db = DBAction::getInstance();
	   $request = $this->getContext()->getRequest();

	   $id = addslashes(trim($request->getParameter('id')));

	   $sql_c = "select a.id,a.add_time,a.content,a.CommentType,a.size,m.user_name,m.headimgurl from lkt_comments AS a LEFT JOIN lkt_user AS m ON a.uid = m.wx_id where a.id = '$id'";
       $r_c = $db->select($sql_c);
       $cid = $r_c[0]->id;
       $headimgurl = $r_c[0]->headimgurl;
       $user_name = $r_c[0]->user_name;
       $content = $r_c[0]->content;
       $add_time = $r_c[0]->add_time;
       $CommentType = $r_c[0]->CommentType;

	   $request -> setAttribute("cid",$cid);
	   $request -> setAttribute("add_time",$add_time);
	   $request -> setAttribute("CommentType",$CommentType);
	   $request -> setAttribute("headimgurl",$headimgurl);
       $request -> setAttribute("user_name",$user_name);
       $request -> setAttribute("content",$content);
       return View :: INPUT;
	}

	public function execute(){
	   $db = DBAction::getInstance();
	   $request = $this->getContext()->getRequest();
        $admin_id = $this->getContext()->getStorage()->read('admin_id');

	   $id = addslashes(trim($request->getParameter('id')));
	   $comment_input = addslashes(trim($request->getParameter('comment_input')));
	   $comment_type = addslashes(trim($request->getParameter('comment_type')));

	   $sql = "update lkt_comments set content= '$comment_input' ,CommentType='$comment_type'  where id= '$id' ";
	   $up = $db -> update($sql);
        $db->admin_record($admin_id,' 修改评论id为 '.$id.' 的信息 ',2);

	   echo $up;
	   exit;
	}

	public function getRequestMethods(){
		return Request :: POST;
	}
}
?>