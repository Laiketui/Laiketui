<?php
require_once(MO_LIB_DIR . '/DBAction.class.php');

class modifyAction extends Action {

	public function getDefaultView() {
        $db = DBAction::getInstance();
        $request = $this->getContext()->getRequest();
        // 接收信息
        $id = intval($request->getParameter("id")); // 插件id
        $uploadImg = addslashes(trim($request->getParameter('uploadImg'))); // 图片上传位置
        $http = addslashes(trim($request->getParameter('http'))); // 图片上传位置
        $http = "index.php?module=$http&action=config";
       
        // 根据插件id，查询插件信息
        $sql = "select * from lkt_plug_ins where id = '$id'";
        $r = $db->select($sql);

        if($r){
            $software_id = $r[0]->software_id; // 软件id
            $name = $r[0]->name; // 首页插件名称
            $subtitle_name = $r[0]->subtitle_name; // 个人中心插件名称
            $type = $r[0]->type; // 软件类型
            $image = $r[0]->image; // 首页图标
            $subtitle_image = $r[0]->subtitle_image; // 个人中心图标
            $url = $r[0]->url ; // 首页链接
            $subtitle_url = $r[0]->subtitle_url ; // 个人中心链接
            $sort = $r[0]->sort ; // 排序
            $code = $r[0]->code ; // code
        }
        $sql = "select id,name from lkt_software where id = '$software_id'";
        $rr = $db->select($sql);
        $software_name = $rr[0]->name;
        $rew = "<option value='$software_id' >$software_name</option>";

        $sql = "select id,name from lkt_software where type = '$type'";
        $rrr = $db->select($sql);


        if($rrr){
            $rew .= '<option value="0" >全部</option>';
            $arr = json_decode(json_encode($rrr),true);
            $new_arr = array();
            foreach($arr as $k => $v){
                if(array_key_exists($v['name'],$new_arr)){
                    $new_arr[$v['name']] = $new_arr[$v['name']].','.$v['id']; 
                }else{
                    $new_arr[$v['name']] = $v['id'];
                }
            }
            foreach ($new_arr as $key => $value) {
                $arr_list['id'] = $value;
                $arr_list['name'] = $key;
                $rew .= "<option  value='".$arr_list['id']."'>".$arr_list['name']."</option>";
            } 
        }

        $dd = $_SERVER['PHP_SELF'];
        $ddd =explode('/', $dd);//打散成数组
        array_pop($ddd);//去除数组最后一个元素
        if($ddd){
            $pic = implode('/', $ddd);

        }else{
             $pic = "/LKT";
        }
        $pic =str_replace('..', '', $pic);
        $request->setAttribute('pic', $pic.'/images');
        $request->setAttribute('id', $id);
        $request->setAttribute('uploadImg', $uploadImg);
        $request->setAttribute('name', $name);
        $request->setAttribute('subtitle_name', $subtitle_name);
        $request->setAttribute('type', $type);
        $request->setAttribute("image",$image);
        $request->setAttribute("subtitle_image",$subtitle_image);
        $request->setAttribute('url', $url);
        $request->setAttribute('subtitle_url', $subtitle_url);
        $request->setAttribute('sort', $sort);
        $request->setAttribute('http', $http);
        $request->setAttribute('list', $rew);
        $request->setAttribute('code', $code);

        return View :: INPUT;
	}

	public function execute(){
		$db = DBAction::getInstance();
		$request = $this->getContext()->getRequest();
        $admin_id = $this->getContext()->getStorage()->read('admin_id');

        // 接收信息
		$id = intval($request->getParameter('id'));
        $uploadImg = addslashes(trim($request->getParameter('uploadImg'))); // 图片上传位置
        $name = addslashes(trim($request->getParameter('name'))); // 首页插件名称
        $subtitle_name = addslashes(trim($request->getParameter('subtitle_name'))); // 个人中心插件名称
        $type = addslashes(trim($request->getParameter('type'))); // 软件类型
        $software_id = addslashes(trim($request->getParameter('software_id'))); // 软件id
        $image = addslashes($request->getParameter('image')); // 新首页插件图标
        $oldpic1 = addslashes($request->getParameter('oldpic1')); // 原首页插件图标
        $subtitle_image = addslashes($request->getParameter('subtitle_image')); // 新个人中心插件图标
        $oldpic2 = addslashes($request->getParameter('oldpic2')); // 原个人中心插件图标
        $url = addslashes(trim($request->getParameter('url'))); // 首页链接
        $subtitle_url = addslashes(trim($request->getParameter('subtitle_url'))); // 个人中心链接
        $sort = trim($request->getParameter('sort')); // 排序

        if($image){
            $image = preg_replace('/.*\//','',$image);
            if($image != $oldpic1){
                @unlink ($uploadImg.$oldpic1);
            }
        }else{
            $image = $oldpic1;
        }
        if($subtitle_image){
            $subtitle_image = preg_replace('/.*\//','',$subtitle_image);
            if($subtitle_image != $oldpic2){
                @unlink ($uploadImg.$oldpic2);
            }
        }else{
            $subtitle_image = $oldpic2;
        }


        //更新数据表
        $sql = "update lkt_plug_ins " .
            "set image = '$image',subtitle_image = '$subtitle_image',url = '$url',subtitle_url = '$subtitle_url', name = '$name',subtitle_name = '$subtitle_name',add_time = CURRENT_TIMESTAMP,sort = '$sort',type = 0  "
            ."where id = '$id'";
        $r = $db->update($sql);

        if($r == -1) {
            $db->admin_record($admin_id,' 修改插件id为 '.$id.' 的信息失败 ',2);
            echo "<script type='text/javascript'>" .
                "alert('未知原因，修改失败！');" .
                "location.href='index.php?module=plug_ins';</script>";
            return $this->getDefaultView();
        } else {
            $db->admin_record($admin_id,' 修改插件id为 '.$id.' 的信息 ',2);
            header("Content-type:text/html;charset=utf-8");
            echo "<script type='text/javascript'>" .
                "alert('修改成功！');" .
                "location.href='index.php?module=plug_ins';</script>";
        }

		return;
	}

	public function getRequestMethods(){
		return Request :: POST;
	}

}

?>