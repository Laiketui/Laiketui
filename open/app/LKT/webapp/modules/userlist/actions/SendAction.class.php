<?php

/**
 * [Laike System] Copyright (c) 2018 laiketui.com
 * Laike is not a free software, it under the license terms, visited http://www.laiketui.com/ for more details.
 */
require_once(MO_LIB_DIR . '/DBAction.class.php');
require_once(MO_LIB_DIR . '/ShowPager.class.php');
require_once(MO_LIB_DIR . '/Tools.class.php');

class SendAction extends Action
{

    public function getDefaultView()
    {
        $db = DBAction::getInstance();
        $request = $this->getContext()->getRequest();
        $recipientid = $request->getParameter('recipientid'); // 收件人ID
        $title = $request->getParameter("title");//标题
        $content = $request->getParameter("content");//内容
        $admin_id = $this->getContext()->getStorage()->read('admin_id');
        $sql = "select id from lkt_admin where name ='$admin_id'";
        $res = $db->select($sql);
        $senderid = $res[0]->id;

        if (empty($senderid)) {
            echo json_encode(array('status' => 105, 'err' => '未传发件人ID'));
            exit;
        }
        if (empty($recipientid)) {
            echo json_encode(array('status' => 105, 'err' => '未传收件人ID'));
            exit;
        }
        $recip = explode(',', $recipientid);//字符串转一维数组
        $cor = count($recip);
        $conr = 0;
        foreach ($recip as $key => $value) {
            $datatime = date('Y-m-d H:i:s', time());
            $sql = "insert into lkt_system_message(senderid,recipientid,title,content,time) " .
                "values('$senderid','$value','$title','$content','$datatime')";
            $r = $db->insert($sql);
            $conr += $r;

        }

        if ($cor == $conr) {
            header("Content-type:text/html;charset=utf-8");
            echo "<script type='text/javascript'>" .
                "alert('发送成功！');" .
                "location.href='index.php?module=userlist';</script>";
            return;
        } else {
            $sql = 'delete from lkt_system_message where time=' . '$datatime';
            $db->delete($sql);
            header("Content-type:text/html;charset=utf-8");
            echo "<script type='text/javascript'>" .
                "alert('发送失败！');" .
                "location.href='index.php?module=userlist';</script>";
            return;
        }

        return View :: INPUT;
    }

    public function execute()
    {

        return $this->getDefaultView();
    }

    public function getRequestMethods()
    {
        return Request :: NONE;
    }

}

?>