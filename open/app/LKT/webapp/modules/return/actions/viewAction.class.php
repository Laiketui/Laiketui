<?php

/**

 * [Laike System] Copyright (c) 2017-2020 laiketui.com

 * Laike is not a free software, it under the license terms, visited http://www.laiketui.com/ for more details.

 */

require_once(MO_LIB_DIR . '/DBAction.class.php');

class viewAction extends Action {


	public function getDefaultView() {
        $db = DBAction::getInstance();
        $request = $this->getContext()->getRequest();
        $id = intval($request->getParameter("id")); // 产品id
        $sql = "select * from lkt_order_details where id = '$id'";
        $r = $db->select($sql);
       
        $request->setAttribute("list",$r);

        return View :: INPUT;

	}



	public function execute(){


		return;

	}



	public function getRequestMethods(){

		return Request :: POST;

	}


}

?>