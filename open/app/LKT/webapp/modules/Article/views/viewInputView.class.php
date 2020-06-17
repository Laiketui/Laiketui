﻿<?php

/**

 * [Laike System] Copyright (c) 2017-2020 laiketui.com

 * Laike is not a free software, it under the license terms, visited http://www.laiketui.com/ for more details.

 */
class viewInputView extends SmartyView {
    public function execute() {
		$request = $this->getContext()->getRequest();
		$this->setAttribute("Article_title",$request->getAttribute("Article_title"));
		$this->setAttribute("total",$request->getAttribute("total"));
		$this->setAttribute("list",$request->getAttribute("list"));
		$this->setTemplate("view.tpl");
    }
}
?>
