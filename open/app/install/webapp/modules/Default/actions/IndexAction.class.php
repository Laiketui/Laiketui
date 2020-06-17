<?php
/**
 * [Laike System] Copyright (c) 2017-2020 laiketui.com
 * Laike is not a free software, it under the license terms, visited http://www.laiketui.com/ for more details.
 */

class IndexAction extends Action
{

    public function execute ()
    {

        // we don't need any data here because this action doesn't serve
        // any request methods, so the processing skips directly to the view
    }

    public function getDefaultView ()
    {

        if(is_file('../data/install.lock')){
            header("Content-type: text/html;charset=utf-8");
                echo"<script language='javascript'>" .
                        "alert('已经成功安装了laiketui，请不要重复安装!');" .
                        "location.href='../index.php';</script>";
                    return ;
        }

        $type = true;
        $num = 0;
        $_SESSION['install_error'] = $type;
        $this->getContext()->getStorage()->write('step',$num);
        return View::SUCCESS;
    }

    public function getRequestMethods ()
    {
        return Request::NONE;
    }

}
?>