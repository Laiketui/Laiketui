<?php

/**
 * [Laike System] Copyright (c) 2017-2020 laiketui.com
 * Laike is not a free software, it under the license terms, visited http://www.laiketui.com/ for more details.
 */


class recordAction extends PluginAction {

    public function getDefaultView() {
        $db = DBAction::getInstance();
        $request = $this->getContext()->getRequest();
        $source = addslashes(trim($request->getParameter('source'))); 
        $name = addslashes(trim($request->getParameter('name'))); 
        $tel = addslashes(trim($request->getParameter('tel'))); 

        $pagesize = $request -> getParameter('pagesize');
        $pagesize = $pagesize ? $pagesize:'10';
        // 每页显示多少条数据
        $page = $request -> getParameter('page');

        // 页码
        if($page){
            $start = ($page-1)*$pagesize;
        }else{
            $start = 0;
        }

        $condition = 'type = 0';
        if($source != ''){
            $condition .= " and b.source like '$source'";
        }
        if($name != ''){
            $condition .= " and a.user_id like '$name'";
        }
        if($tel != ''){
            $condition .= " and b.mobile like '$tel'";
        }
        $sql = "select a.*,b.user_name,b.mobile,b.source from lkt_sign_record as a left join lkt_user as b on a.user_id = b.user_id where $condition ";
        $r_pager = $db->select($sql);
        $total = count($r_pager);
        $pager = new ShowPager($total,$pagesize,$page);

        $sql = "select a.*,b.user_name,b.mobile,b.source from lkt_sign_record as a left join lkt_user as b on a.user_id = b.user_id where $condition order by sign_time desc limit $start,$pagesize";
        
		$r = $db->select($sql);
        if($r){
            $list = $r;
        }else{
            $list = [];
        }
        $url = "index.php?module=pi&p=sign&c=record&source=".urlencode($source)."&name=".urlencode($name)."&tel=".urlencode($tel)."&pagesize=".urlencode($pagesize);
        $pages_show = $pager->multipage($url,$total,$page,$pagesize,$start,$para = '');

        $request->setAttribute("source",$source);
        $request->setAttribute("name",$name);
        $request->setAttribute("tel",$tel);
        $request->setAttribute("list",$list);
        $request -> setAttribute('pages_show', $pages_show);
        $request -> setAttribute('pagesize', $pagesize);

        return View :: INPUT;
    }

    public function execute() {

    }

    public function getRequestMethods(){
        return Request :: NONE;
    }

}

?>