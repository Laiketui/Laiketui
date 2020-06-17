<?php
require_once(MO_LIB_DIR . '/DBAction.class.php');
require_once(MO_LIB_DIR . '/ShowPager.class.php');
require_once(MO_LIB_DIR . '/Tools.class.php');

class IndexAction extends Action {

    public function getDefaultView() {
        $db = DBAction::getInstance();
        $request = $this->getContext()->getRequest();
        $sql = "select * from lkt_config where id = '1'";
        $r = $db->select($sql);
        $uploadImg = $r[0]->uploadImg; // 图片上传位置

        $con = '';
        foreach ($_GET as $key => $value001) {
            $con .= "&$key=$value001";
        }
        // 查询插件表
        $sql = "select * from lkt_plug_ins";
        $total = $db->selectrow($sql);
        // 导出
        $pagesize = $request -> getParameter('pagesize');
        $pagesize = $pagesize ? $pagesize:10;
        // 页码
        $page = $request -> getParameter('page');
        if($page){
            $start = ($page-1)*$pagesize;
        }else{
            $start = 0;
        }
        $sql .= " order by add_time desc limit $start,$pagesize ";
        $r = $db->select($sql);

        $pager = new ShowPager($total,$pagesize,$page);
        $url = 'index.php?module=plug_ins'.$con;
        $pages_show = $pager->multipage($url,$total,$page,$pagesize,$start,$para = '');

        if($r){
            foreach ($r as $k => $v) {
                if(strstr($v->code,'YHQ') == true){
                    $v->http = 'coupon';
                }
                if(strstr($v->code,'QB') == true){
                    $v->http = 'finance';
                }
                if(strstr($v->code,'QD') == true){
                    $v->http = 'sign';
                }
                if(strstr($v->code,'PT') == true){
                    $v->http = 'go_group';
                }

                $software_id = $v->software_id;
                $sql = "select id,name from lkt_software where id = '$software_id'";
                $rr = $db->select($sql);
                $v->software_id = $rr[0]->id;
                $v->software_name = $rr[0]->name;
            }
        }
        
        $request->setAttribute("pages_show",$pages_show);
        $request->setAttribute("uploadImg",$uploadImg);
        $request->setAttribute("list",$r);

        return View :: INPUT;
    }

    public function execute() {

    }

    public function getRequestMethods(){
        return Request :: NONE;
    }

}

?>