<?php

/**

 * [Laike System] Copyright (c) 2018 laiketui.com

 * Laike is not a free software, it under the license terms, visited http://www.laiketui.com/ for more details.

 */

class pageindexInputView extends SmartyView {

	

    public function execute() {

		$request = $this->getContext()->getRequest();

		$this->setAttribute("list",$request->getAttribute("list"));

		$this->setAttribute("uploadImg",$request->getAttribute("uploadImg"));

		$this->setAttribute("down_file",$request->getAttribute("upload_file"));

        $this->setTemplate("pageindex.tpl");

    }

}

?>