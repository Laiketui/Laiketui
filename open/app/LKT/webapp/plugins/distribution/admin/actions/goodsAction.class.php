<?php

/**
 * [Laike System] Copyright (c) 2020 laiketui.com
 * Laike is not a free software, it under the license terms, visited http://www.laiketui.com/ for more details.
 */


class goodsAction extends PluginAction
{

    public function getDefaultView()
    {
        $request = $this->getContext()->getRequest();
        $name = $request->getParameter("username"); // 商品名称
        $pagesize = $request->getParameter('pagesize');
        $status = $request->getParameter('status') ? $request->getParameter('status') : 2;
        $pagesize = $pagesize ? $pagesize : 10;
        $res1 = array();
        // 每页显示多少条数据
        $page = $request->getParameter('page');
        if ($page) {
            $start = ($page - 1) * $pagesize;
        } else {
            $start = 0;
        }
        
        $appConfig = $this->getAppInfo();
        $img = $appConfig['imageRootUrl'];

        $condition = '';
        if ($name) {
            $condition .= "  AND b.product_title like '%$name%' ";
        }

        $db = DBAction::getInstance();
        $res = $db->select("select a.*,b.product_title,b.volume,b.imgurl,b.num,b.status as sta,b.initial  from lkt_detailed_pro AS a,lkt_product_list AS b where a.pro_id = b.id AND b.num > 0  " . $condition . " order by a.id desc  ");

        $total = count($res);
        if ($res) {
            $res1 = array_slice($res, $start, $pagesize); //分页

            foreach ($res1 as $k => $v) {

                $attr = unserialize($v->initial);
                $res1[$k]->price = $attr['sj'];
                $attr = array_values($attr);
                if ($attr) {
                    if (gettype($attr[0]) != 'string') unset($attr[0]);
                }
                $res1[$k]->imgurl = $img . $v->imgurl;
                $res1[$k]->attr =  implode(',', $attr);

            }

        }

        $pager = new ShowPager($total, $pagesize, $page);
        $url = "index.php?module=pi&p=distribution&c=goods&name=$name&pagesize=" . urlencode($pagesize);
        $pages_show = $pager->multipage($url, $total, $page, $pagesize, $start, $para = '');
        $request->setAttribute("list", $res1);
        $request->setAttribute("name", $name);
        $request->setAttribute("status", $status);
        $request->setAttribute("pages_show", $pages_show);
        return View::INPUT;
    }

    //商品上下架
    public function status()
    {
        $request = $this->getContext()->getRequest();
        $id = intval($request->getParameter('id'));
        $status = intval($request->getParameter('status')); //1上架，2下架
        $data = array();
        $data[] = $status;
        $data[] = $id;
        $db = DBAction::getInstance();
        $res = $db->preUpdate("update lkt_detailed_pro set status=? where id = ?",$data);
        if ($res > 0) {
            echo json_encode(array('code' => 200, 'message' => '修改成功!'));
            exit();
        } else {
            echo json_encode(array('code' => 400, 'message' => '未知原因，修改失败!'));
            exit();
        }
        return;
    }


    public function del()
    {
        $request = $this->getContext()->getRequest();
        $id = $request->getParameter('id');
        $type = $request->getParameter('type');
        $db = DBAction::getInstance();
        $res = 0;
        if ($id) {
            $data = explode(',', $id);
            foreach ($data as $key => $value) {
                $res = $db->preUpdate("delete from lkt_detailed_pro where id =  ?",array($value));
                if ($res==0){
                    break;
                }
            }
        }

        if ($res > 0) {
            if ($type==1){
                header("Content-type:text/html;charset=utf-8");
                echo "<script type='text/javascript'>" .
                    "alert('删除成功！');" .
                    "location.href='index.php?module=pi&p=distribution&c=goods';</script>";
            }else{
                echo json_encode(array('code' => 200, 'message' => '删除成功!'));
            }
            exit();
        } else {
            if ($type==1){
                header("Content-type:text/html;charset=utf-8");
                echo "<script type='text/javascript'>" .
                    "alert('删除失败！');" .
                    "location.href='index.php?module=pi&p=distribution&c=goods';</script>";
            }else{
                echo json_encode(array('code' => 400, 'message' => '未知原因，删除失败!'));
            }
            exit();
        }
        return;
    }


    public function execute()
    {

    }

    public function getRequestMethods()
    {
        return Request::NONE;
    }


}
