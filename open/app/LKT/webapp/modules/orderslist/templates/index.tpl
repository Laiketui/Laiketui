<!DOCTYPE HTML>
<html>
<head>
	<meta charset="utf-8">
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport"
		content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	{php}include BASE_PATH."/modules/assets/templates/top.tpl";{/php}

	{literal}
	<style type="text/css">

		.tab_content {
		    background-color: white;
		    text-align: center;
		}

		#delorderdiv {
			margin-left: 20px;
			display: inline;
			color: red;
		}

		.order-item {
			border: 1px solid transparent;
			margin-bottom: 1rem;
		}

		.order-item table {
			margin: 0;
		}

		.order-item:hover {
			border: 1px solid #3c8ee5;
		}

		.goods-item {
			margin-bottom: .75rem;
		}

		.goods-item:last-child {
			margin-bottom: 0;
		}

		.btn-success:focus,
		.btn-success:active,
		.btn-success.active {
			background-color: #2890FF !important;
		}

		.btn-success:hover,
		.btn-success:focus,
		.btn-success:active,
		.btn-success.active {
			border: 0 !important;
		}

		.goods-name {
			white-space: nowrap;
			text-overflow: ellipsis;
			overflow: hidden;
		}

		.status-item.active {
			color: inherit;
		}

		.badge {
			display: inline-block;
			padding: .25em .4em;
			font-size: 75%;
			font-weight: 700;
			line-height: 1;
			color: #fff;
			text-align: center;
			white-space: nowrap;
			vertical-align: baseline;
			border-radius: .25rem
		}

		.badge:empty {
			display: none
		}

		.btn .badge {
			position: relative;
			top: -1px
		}

		a.badge:focus,
		a.badge:hover {
			color: #fff;
			text-decoration: none;
			cursor: pointer
		}

		.badge-pill {
			padding-right: .6em;
			padding-left: .6em;
			border-radius: 10rem
		}

		.badge-default {
			background-color: #636c72
		}

		.badge-default[href]:focus,
		.badge-default[href]:hover {
			background-color: #4b5257
		}

		.badge-primary {
			background-color: #0275d8
		}

		.badge-primary[href]:focus,
		.badge-primary[href]:hover {
			background-color: #025aa5
		}

		.badge-success {
			background-color: #5cb85c
		}

		.badge-success[href]:focus,
		.badge-success[href]:hover {
			background-color: #449d44
		}

		.badge-info {
			background-color: #5bc0de
		}

		.badge-info[href]:focus,
		.badge-info[href]:hover {
			background-color: #31b0d5
		}

		.badge-warning {
			background-color: #f0ad4e
		}

		.badge-warning[href]:focus,
		.badge-warning[href]:hover {
			background-color: #ec971f
		}

		.badge-danger {
			background-color: #d9534f
		}

		.badge-danger[href]:focus,
		.badge-danger[href]:hover {
			background-color: #c9302c
		}

		.mask {
			position: absolute;
			top: 0;
			bottom: 0;
			left: 0;
			right: 0;

		}

		a:hover {
			color: red;
			text-decoration: none;
		}

		.table-bordered th,
		.table-bordered td {
			border: none;
			text-align: center;
			vertical-align: middle;
		}

		.txc th {
			text-align: center;
		}

		.imgTd img {
			width: 50px;
			height: 50px;
			margin-right: 10px;
		}

		.maskLeft {
			width: 30%;
			float: left;
			text-align: right;
			padding-right: 20px;
			height: 36px;
			line-height: 36px;
		}

		.maskRight {
			width: 70%;
			float: left;
		}

		.ipt1 {
			padding-left: 10px;
			width: 300px;
			height: 36px;
			border: 1px solid #eee;
		}

		.wl_maskNew {
			position: fixed;
			z-index: 9999999;
			top: 0;
			bottom: 0;
			left: 0;
			right: 0;
			background: rgba(0, 0, 0, 0.6);
			display: block;
		}

		.wl_maskNewContent {
			width: 920px;
			height: 600px;
			background: rgba(255, 255, 255, 1);
			border-radius: 4px;
			margin: 0 auto;
			position: relative;
			top: 10%;
		}

		.dc {
			position: fixed;
			z-index: 999;
			top: 0;
			bottom: 0;
			left: 0;
			right: 0;
			background: rgba(0, 0, 0, 0.6);
			display: block;
		}

		.table-bordered td {
			border-bottom: 1px solid #eee !important;
		}

		.table {
			border-collapse: collapse;
		}

		form[name=form1] {
			/*background: #f7f7f7;*/
			padding: 10px;
			text-align: left;
			height: 36 !important;
		}

		input::-webkit-input-placeholder {
			/* placeholder颜色  */
			color: #cccccc;
			/* placeholder字体大小  */
			font-size: 14px;
			/* placeholder位置  */
			text-align: left;
		}

		option {
			/* placeholder颜色  */
			color: #cccccc;
			/* placeholder字体大小  */
			font-size: 14px;
			/* placeholder位置  */
			text-align: center;
		}

		.seach_test {
			font-family: 'MicrosoftYaHei', 'Microsoft YaHei';
			font-weight: 400;
			font-style: normal;
			font-size: 12px;
			color: #666666;
			text-align: right;
			line-height: 18px;
		}

		.butten_o {
			width: 69px;
			height: 28px;
			background: inherit;
			background-color: rgba(153, 153, 153, 1);
			border: none;
			border-radius: 4px;
			-moz-box-shadow: none;
			-webkit-box-shadow: none;
			box-shadow: none;
			font-family: 'MicrosoftYaHei', 'Microsoft YaHei';
			font-weight: 400;
			font-style: normal;
			font-size: 14px;
			color: #FFFFFF;
			text-align: center;
			line-height: 21px;
		}

		.seach_span {
			position: relative;
		}

		#u2386_img {
			position: absolute;
			right: 10px;
			top: 5px;
			width: 14px;
			height: 14px;
		}

		.txc {
			background: #fff;
		}

		.custom-control {
			position: relative;
			display: -webkit-inline-box;
			display: -webkit-inline-flex;
			display: -ms-inline-flexbox;
			display: inline-flex;
			min-height: 1.5rem;
			padding-left: 1.5rem;
			margin-right: 1rem;
			cursor: pointer;
			float: left;
		}

		.goods-item {
			padding: 10px;
			margin-top: -1px;
		}

		.goods-item:last-child {
			margin-bottom: 0;
		}

		.goods-pic {
			width: 5.5rem;
			height: 5.5rem;
			display: inline-block;
			background-color: #ddd;
			background-size: cover;
			background-position: center;
			margin-right: 1rem;
		}

		.ml-ttt {
			margin-left: 20px;
		}

		.goods-info {
			text-align: left;
		}

		.fs-0 {
			margin-left: 35px;
		}

		.ttt_tr {
			margin-top: 10px;
		}

		span {
			color: #818181;
		}

		th {
			color: #818181;
		}

		.u2523 {
			font-family: 'PingFangSC-Semibold', 'PingFang SC Semibold', 'PingFang SC';
			font-weight: 650;
			font-style: normal;
			font-size: 14px;
			color: #414658;
		}

		#u2554 {
			font-size: 13px;
			color: #818181;
		}

		.ax_label {
			font-size: 14px;
			text-align: left;
		}

		.ax_default {
			font-family: 'ArialMT', 'Arial';
			font-weight: 400;
			font-style: normal;
			font-size: 13px;
			color: #333333;
			text-align: left;
			line-height: normal;
		}

		.caozuo_b:hover {
			color: #38b4ed;
		}

		label {
			display: inline-block;
			margin-bottom: 0;
		}

		.tml-5 {
			margin: 5px 0;
		}

		p {
			margin: 0;
		}

		.wlmk_div {
			display: flex;
			justify-content: flex-start;
		}

		.wlmk_box {
			text-align: right;
			visibility: visible;
			color: #818181;
		}

		.wlmk_box_2 {
			text-align: left;
		}

		.btn-success:hover {
			background: #2481e5;
		}

		.fs-0 {
			display: flex;
			align-items: center;
		}

		form .select {
			height: 100%;
		}

		form[name=form1] input {
			height: 100%;
		}

		.f9e {
			color: #888F9E;
		}

		#btn8:hover {
			border: 1px solid #2890FF !important;
			color: #2890FF !important;
		}

		.nmor {
			border: 0;
			border-radius: 4px;
			background-color: #2890FF !important;
			color: white !important;
		}

		.nmor:hover {
			background-color: #2481e5 !important;
		}

		.tab_dat a {
			width: 88px !important;
			color: #888f9e !important;
			cursor: pointer;
		}

		.tab_dat a img {
			margin-top: -3px;
		}

		.float_right {
			float: right;
		}

		.unable {
			color: #d6dce9 !important;
			border-color: #E9ECEF !important;

		}

		.stopCss:hover {
			cursor: not-allowed;
		}

		.stopCss {
			width: 88px;
			height: 20px;
			border: 1px solid #e9ecef;
			color: #d8dbe8 !important;
			font-size: 12px;
			border-radius: 2px;
			line-height: 20px;
			display: inline-block;
			margin-left: -2%;
			margin-bottom: 8px;
		}

		.textColor {
			color: #414658;
		}

		.tab_dat .hover_a:hover {
			color: rgb(40, 144, 255) !important;
		}

		.tab_news label {
			margin-left: 10px !important;
		}

		.tab_tb_news label {
			padding-left: 10px !important;
		}

		.custom-control {
			padding-left: 0px !important;
		}

		.custom-control-indicator {
			margin-top: 0px !important;
		}
	</style>

	{/literal}
	<title>订单列表</title>
</head>

<body>


<nav class="breadcrumb">
    订单管理 <span class="c-gray en">&gt;</span> 
    订单列表 
</nav>

	<div class="pd-20">
		<div class="text-c">
			<form name="form1" id="form1" action="index.php" method="get">

				<input type="hidden" name="module" value="orderslist" />
				<input type="hidden" name="having" value="123" />
				<input type="hidden" name="ordtype" value="{$otype}" />
				<input type="hidden" name="gcode" value="{$status}" />
				<input type="hidden" name="ocode" value="{$ostatus}" />
				<div>
					<input type="text" name="sNo" id="sNo_" size='8' value="{$sNo}" placeholder="请输入订单编号/姓名/电话/会员ID"
						style="width:230px;height: 31px;" class="input-text seach_bottom">

					<select name="otype" class="select seach_bottom" id="otype_"
						style="width: 130px;font-size: 14px;height: 31px;color: #cccccc;vertical-align: middle;">
						<option value="">请选择订单类型</option>

						{foreach from=$ordtype item="item" key="key"}
						<option value="{$key}" {if $otype==$key}selected{/if}>{$item} </option> {/foreach} </select> <select
							name="status" class="select seach_bottom" id="status_"
							style="width: 130px;font-size: 14px;height: 31px;color: #cccccc;vertical-align: middle;">
						<option value="">请选择订单状态</option>
						{$class}
					</select>

					<input type="text" class="input-text seach_bottom" value="{$startdate}" placeholder="请输入开始时间" id="startdate"
						name="startdate" style="width:150px;">
					<span style='display: inline-block;height: 36px;'>
						<span style='display: flex;align-items:center;'>
							至
						</span>
					</span>
					<input type="text" class="input-text seach_bottom" value="{$enddate}" placeholder="请输入结束时间" id="enddate"
						name="enddate" style="width:150px;margin-left:5px;">

					<input class="btn btn-success" id="btn1" type="submit" value="查询">
					<input type="button" value="重置" id="btn8" style="border: 1px solid #D5DBE8; color: #6a7076; height: 31px;"
						class="reset" onclick="empty()" />

					<input type="button" value="导出" id="btn2" style="margin-right: 0px;float: right;" class="btn btn-success"
						onclick="excel(location.href)">
					<input type="button" value="批量删除" id="btn2" style="margin-right: 8px;float: right;width: 80px!important;"
						class="btn btn-success" onclick="del_orders()">
				</div>
			</form>



		</div>
		<div class="mt-20 table-scroll" style="overflow: scroll; width: 101%; height: 495px;">
			<table class="table table-bordered tab_content">
				<thead>
					<tr class="txc tab_tr">

						<th class="tab_news">
							<label class="custom-control custom-checkbox">
								<input name="orders_all" value="all" type="checkbox" class="custom-control-input orders_all">
								<span class="custom-control-indicator"></span>
							</label>
							订单信息
						</th>

						<th >订单总计</th>
						<th >数量</th>
						<th s>订单状态</th>
						{if $otype == 't2'}
						<th >拼团状态</th>
						{/if}
						<th >订单类型</th>

						<th >买家信息</th>
						<th >支付方式</th>
						<th >物流信息</th>
						<th class="tab_dat">操作</th>
					</tr>

				</thead>
				<tbody>
					{foreach from=$order item=item name=f1}

					<tr class="tab_head">
						<td colspan="{if $otype == 't2'}10{else}9{/if}" class="tab_tb_news">
							<label class="custom-control custom-checkbox">

								<input name="orders[]" value="{$item->id}" type="checkbox" class="custom-control-input orders_select"
									title="{$item->status}">
								<span class="custom-control-indicator"></span>

								<span class="custom-control-description">
									<span class="ml-ttt f9e">订单编号：{$item->sNo}</span>
									<span class="ml-ttt f9e">创单时间：{$item->add_time}</span>
								</span>

							</label>
						</td>
					</tr>

					<tr class="tab_td">
						<!-- 订单信息 -->
						<td class="tab_news">

							{foreach from=$item->products item=item2 name=f2 key=key2}
							<!-- 只显示一个 -->
							{if $key2 < 1} <div class="goods-item" flex="dir:left box:first">

								<div class="fs-0 f9e" style="float:left">
									<div class="goods-pic" style="background-image: url('{$uploadImg}{$item2->imgurl}')"></div>
								</div>

								<div class="goods-info">
									<div class="goods-name u2523">
										{$item2->product_title}
									</div>
									<div class="mt-1">
										<span class="fs-sm f9e">
											规格：
											<span class="text-danger">
												<span class="mr-3 c658 textColor">
													{$item2->size}
												</span>
											</span>
										</span>
									</div>

									<div class="mt-1">
										<span class="fs-sm f9e">
											数量：
											<span class="text-danger  textColor">
												{$item2->num}件
											</span>
										</span>
									</div>

									<div>
										<span class="fs-sm f9e">
											小计：
											<span class="text-danger mr-4  textColor">
												{$item2->num*$item2->p_price}元
											</span>
										</span>
									</div>

								</div>
		</div>
		{/if}
		{/foreach}
		</td>

		<td>
			<div>&yen;{$item->z_price}</div>
		</td>

		<td>
			<div>{$item->num}</div>
		</td>

		<!-- 订单状态 -->
		<td>
			<div class="text" style="visibility: visible;">
				<p>
					<span style="font-size: 18px;font-family:'Helvetica';color:{$item->bgcolor}">●</span><span
						style="font-family:'MicrosoftYaHei', 'Microsoft YaHei';color:#414658;"> </span><span
						style="font-family:'MicrosoftYaHei', 'Microsoft YaHei';color:#888f9e;">{$item->status}</span>
				</p>
			</div>
		</td>

		{if $otype == 't2'}
		<td>
			<div>
				<span class='f9e'>{$item->pt_status}</span>
			</div>
		</td>
		{/if}

		<!-- 订单类型 -->
		<td>
			<div>
				<span>
					{if $item->otype == 'pt'}
					拼团订单
					{else}
					普通订单
					{/if}
				</span>
			</div>
		</td>

		<!-- 买家信息 -->
		<td>
			<div id="u2554" class="ax_default ax_label">
				<div id="u2554_div" class=""></div>
				<div id="u2555" class="text" style="visibility: visible;">

					<p>
						<span class='f9e' style="display: inline-block;width: 60px;">会员ID：</span>
						<span class="textColor">{if $item->user_id}{$item->user_id}{else}暂无{/if}</span>
					</p>

					<p>
						<span class='f9e' style="display: inline-block;width: 60px;">联系人：</span>
						<span class="textColor">{if $item->name}{$item->name}{else}暂无{/if}</span>
					</p>

					<p class="tab_nowrap ">
						<span class="f9e" style="display: inline-block;width: 60px;">电 &nbsp;&nbsp;&nbsp;话：</span>
						<span class="textColor">{if $item->mobile}{$item->mobile}{else}暂无{/if}</span>
					</p>

					<p>
						<span class="f9e" style="display: inline-block;width: 60px;">地 &nbsp;&nbsp;&nbsp;址：</span>
						<span class="textColor">{if $item->address}{$item->address}{else}暂无{/if}</span>
					</p>

				</div>
			</div>
		</td>

		<!-- 支付方式 -->
		<td>
			<div>
				<span>
					{if $item->pay == 'wxPay'}
					微信支付
					{elseif $item->pay == 'wallet_Pay'}
					余额支付
					{elseif $item->pay == 'consumer_pay'}
					消费金支付
					{else}组合支付{/if}
				</span>
			</div>
		</td>

		<!-- 物流信息 -->
		<td>
			<div class="wlmk_div">

				<div class="wlmk_box" style="width: 100px;">

					{if !empty($item->courier_num)}
					{foreach from=$item->courier_num item=item3 name=f3 key=key3}
					{if !empty($item3.courier_num)}
					<div id="wl" class="f9e">物流单号 {$key3+1}: </div>
					{/if}
					{/foreach}
					{else}
					<div class="f9e">物流单号：</div>
					{/if}

					<div class="f9e">运费：</div>
				</div>

				<div class="wlmk_box_2">
					{if !empty($item->courier_num)}
					{foreach from=$item->courier_num item=item3 name=f3 key=key3}
					{if !empty($item3.courier_num)}

					<div class="goods-name doods-span" style="width:200px;">
						<span>{$item3.courier_num}({$item3.kuaidi_name})</span>
						<span class="vieworder" onclick="send_btn1(this,'{$item->sNo}','{$item3.courier_num}',true)"
							style="display: none">查看物流</span>
					</div>

					{/if}
					{/foreach}
					{else}
					<div>暂无</div>
					{/if}

					<div>{if $item->freight}￥{$item->freight}{else}免邮{/if}</div>
				</div>
			</div>
		</td>

		<!-- 操作 -->
		<td class="tab_dat">

			<a class="hover_a" onclick="navto('index.php?module=orderslist&action=Detail&id={$item->id}')" title="订单详情">
				<img src="images/icon1/ck.png" />&nbsp;订单详情
			</a>


			{if $item->statu <= 3} <a class="hover_a"
				onclick="navto('index.php?module=orderslist&action=Modify&id={$item->id}&type=updata')" title="编辑订单">
				<img src="images/icon1/xg.png" />&nbsp;编辑订单
				</a>
				{else}
				<div class="stopCss">
					<img style="margin-top: -3px;" src="images/icon1/xg.png" />&nbsp;编辑订单
				</div>
				{/if}

				{if $item->statu == 1}
				<a class="hover_a" onclick=send_btn(this,'{$item->otype}','{$item->sNo}',{$item->statu})>
					<img src="images/icon1/ck.png" />&nbsp;发货
				</a>
				{elseif !empty($item->courier_num[0].courier_num)}
				<a class="hover_a" onclick="send_btn1(this,'{$item->sNo}','{$item->products[0]->courier_num}')">
					<img src="images/iIcon/wul.png" />&nbsp;查看物流
				</a>
				{/if}

				{if $item->statu == 0}
				<a class="hover_a" onclick="colse('{$item->sNo}')">
					<img src="images/iIcon/chaaG.png" />&nbsp;关闭订单
				</a>
				{/if}

		</td>
		</tr>
		<tr class="page_h16">
			<td colspan="{if $otype == 't2'}10{else}9{/if}"></td>
		</tr>
		{/foreach}
		</tbody>
		</table>
	</div>
	<div style="text-align: center;display: flex;justify-content: center;">{$pages_show}</div>

	</div>

	<div class="dc" style="display:none;">
		<div class="maskNewContent">
			<div class="maskTitle ">
				添加快递信息
			</div>
			<a href="javascript:void(0);" class="closeA qx" style="display: block;"><img src="images/icon1/gb.png" /></a>
			<form action="" method="post" class="form form-horizontal" id="form-category-add" enctype="multipart/form-data">
				<div id="tab-category" class="HuiTab">
					<div class="" style="margin-top: 35px;">
						<div class="">
							<input type="hidden" name="sNo" value="" class="order_id">
							<input type="hidden" name="otype" value="{$otype}" class="otype">
							<input type="hidden" name="trade" value="3">
							<label class="maskLeft" style="">快递公司：</label>
							<div class="formControls maskRight" style="width: 60%;float: left;">
								<form name="hh" action="" method="post">
									<span class="search">
										<input class="ww ipt1" id="makeInput" autocomplete="off" onkeyup="setContent(this,event);"
											onfocus="setDemo(this,event)" type="text" placeholder="请选择或输入快递名称">
										<select name="kuaidi" class="selectName" id="hh"
											style="display: none; position: absolute;z-index:99;width: 153px;margin-top: 1px;margin-left: 0px;"
											onkeyup="getfocus(this,event)" onclick="choose(this)" size="10" id="num1">
											{foreach from=$express item = item name=f1}
											<option value="{$item->id}">{$item->kuaidi_name}</option>
											{/foreach}
										</select>
									</span>
								</form>
							</div>
							<div class="clearfix"></div>
							<div class="col-3">
							</div>
						</div>
						<div class="">
							<label class="maskLeft" style="">快递单号：</label>
							<div class="maskRight" style="">
								<input type="text" class="ipt1" value="" name="danhao" placeholder="请输入正确的快递单号" />
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
				</div>
				<div class="row cl">
					<div class="col-9 " style="margin-left:40%">
						<input class="qd closeMask" type="submit" value="提交">
					</div>
				</div>
			</form>
		</div>
	</div>
	<div class="maskNew dd" style="display: none;">
		<div class="maskNewContent">
			<div class="maskTitle ">
				查看物流信息
			</div>
			<a href="javascript:void(0);" class="closeA qx"><img src="images/icon1/gb.png" /></a>
			<div class="page-container" style="margin: 0 auto;">
				{if $res ==1 }
				<p style=" text-align: center;height: 100%;">未查询到物流信息</p>
				{else}
				{foreach from=$res item="item" key="key"}
				<div class='time' style="    margin-left: 30px;">{$item->time}</div>
				<div class='step' style="font-size: 0.5rem; padding: 5px 20px;    margin-left: 30px;">{$item->context}</div>
				{/foreach}
				{/if}

			</div>
			<div style="text-align:center;margin-top:30px">
				<button class="closeMask" onclick=hm()>确认</button>
			</div>
		</div>
	</div>

	{php}include BASE_PATH."/modules/assets/templates/footer.tpl";{/php}

	<script language="javascript" src="style/js/ssd1.js"> </script>


	{literal}
	<script type="text/javascript">

		$(".orders_all").bind("click",
            function () {
                $(".orders_select").prop("checked", $(this).prop("checked"));
            });
        $(".orders_select").bind("click",
            function () {
                var $sel = $(".orders_select");
                var b = true;
                for (var i = 0; i < $sel.length; i++) {
                    if ($sel[i].checked == false) {
                        b = false;
                        break;
                    }
                }
                $(".orders_all").prop("checked", b);
            })
        
		// 查看物流
		// 移入
		$('.doods-span').on('mouseenter', function (vm) {
			var son = vm.currentTarget.children[0]
			var span = vm.currentTarget.children[1]


			span.style.display = 'inline-flex'
			son.style.display = 'none'
		})
		// 移出
		$('.doods-span').on('mouseleave', function (vm) {
			var son = vm.currentTarget.children[0]
			var span = vm.currentTarget.children[1]

			span.style.display = 'none'
			son.style.display = 'inline-flex'
		})

		// 订单查询
		$('.vieworder').on('click', function (vm) {
			console.log(vm.target.title)
		})

		// 删除订单

		var deIsOpn = 0
		var conStr = ''
		function del_orders() {



			var $sel = $(".orders_select");
			var b = true;
			var con_str = ''
			for (var i = 0; i < $sel.length; i++) {
				if ($sel[i].checked == true) {
					if ($sel[i].title === '拼团中') {
						parent.appendMask2('存在拼团中的订单不能删除')
						deIsOpn = 0
						return
					}
					con_str += $sel[i].value + ',';
				}
			}



			if (con_str.length) {
				deIsOpn = 1
				conStr = con_str

				parent.appendMask2('确认删除此所选订单？此操作不可恢复！')

				// confirm123("确认删除此所选订单？此操作不可恢复！", con_str, 'index.php?module=orderslist&action=del&data=', '删除');

			} else {
				parent.appendMask2('请选择需要删除的订单')
			}
		}

		// 关闭订单
		var colsEsno = ''
		function colse(sNo) {
			colsEsno = sNo
			deIsOpn = 2
			parent.appendMask2('确认关闭此订单？', { colsEsno, deIsOpn })
		}

		function navto(URI) {
			var parma = $('#form1').serializeArray()
			var urllist = []
			parma.forEach(function (item) {
				if (item.name === 'sNo') {
					item.name = item.name + 1
				}
				urllist.push(item.name + '=' + item.value)
			})
			parma = "&" + urllist.join('&') + '&page=' + $('.active').children('a').text()
			location.href = URI + parma
		}

		function check(f) {
			if (Trim(f.product_title.value) == "") {
				alert("产品名称不能为空！");
				f.product_title.value = '';
				return false;
			}
			if (Trim(f.keyword.value) == "") {
				alert("关键词不能为空！");
				f.keyword.value = '';
				return false;
			}
			if (Trim(f.sort.value) == "") {
				alert("排序不能为空！");
				f.sort.value = '';
				return false;
			}
			f.sort.value = Trim(f.sort.value);
			if (!/^(([1-9][0-9]*)|0)(\.[0-9]{1,2})?$/.test(f.sort.value)) {
				alert("排序号必须为数字，且格式为 ####.## ！");
				f.sort.value = '';
				return false;
			}
			console.log(1);
			return true;
		}

		$(".qd").click(function () {
			var id = $('.order_id').val(); // 订单号
			var express = $('select[name=kuaidi]').val(); // 快递公司id
			var express_name = $('select[name=kuaidi]').find("option:selected").text(); // 快递公司名称
			var courier_num = $('input[name=danhao]').val(); // 快递单号
			// var freight = $('input[name=yunfei]').val();
			var otype = $(".otype").val(); // 类型
			console.log(courier_num, express_name, express, "as4d65");
			console.log(express_name.length, express.length)
			if (express_name.length < 1) {
				appendMask_tj('请选择快递公司', "ts");
			} else if (courier_num.length < 10) {
				appendMask_tj('请填写正确快递单号', "ts");
			} else {
				$.ajax({
					url: "index.php?module=orderslist&action=addsign",
					type: "post",
					data: { sNo: id, trade: 3, express: express, courier_num: courier_num, otype: otype, express_name: express_name },
					dataType: "json",
					success: function (data) {
						console.log(data);
						$(".dc").hide();
						if (data == 1) {
							console.log(1)
							appendMask1('发货成功', "cg");
						} else {
							appendMask('快递单号已存在，请勿重复', "ts");
						}
					},
				});
			}

		});

		function system_category_add(title, url, w, h) {
			appendMask(title, url, w, h);
		}

		$(".qx").click(function () {
			$(".dc").hide();
		})
		function send_btn(obj, otype, id, status, sNo) {
			// console.log(otype, id, status, drawid);
			var dingdan = id;
			var stu = status;
			$('.order_id').val(id);
			$('.otype').val(otype ? otype : 'yb');

			if (stu == 6) {
				appenMask1('订单已关闭，不能发货!', "ts");
			}
			if (stu >= 2 && stu != 6) {
				appenMask1('订单已发货，请勿重复操作!', "ts");
			}

			if (stu == 0) {
				appenMask1('订单还没付款!', "ts");
			}

			if (stu == 1) {
				// $(".dc").show();
				location.href = 'index.php?module=orderslist&action=addsign&sNo=' + dingdan
			}

		};

		function send_btn1(obj, id, courier_num, is = false) {

			var r_sNo = id;

			$.ajax({
				url: 'index.php?module=orderslist&action=kuaidishow&r_sNo=' + r_sNo + '&courier_num=' + courier_num,
				type: "post",
				success: function (res) {
					var data = JSON.parse(res);

					if (!data[0].data.length) {
						appendMask('暂无物流信息！', "ts");
						return
					}

					if (is) {
						d = []
						for (var item of data) {
							if (item.courier_num === courier_num) {
								d.push(item)
							}
						}
						data = d
					}

					if (data.length) {
						closeMask1();
						var str = '';
						var title = ''

						// for(var item of data){
						// 	title +='<div style="margin-bottom: 30px;">' + item.kuaidi_name + ":" + item.courier_num

						// 	for(var aaa of item.data){
						// 		str += '<div class="time" style="margin-left: 30px;">' + aaa.time + '</div><div class="step" style="font-size: 0.5rem; padding: 5px 20px;    margin-left: 30px;">' + aaa.context + '</div>';
						// 	}

						// 	title += str + '</div>'
						// }

						// for (var i = 0; i < data.data.length; i++) {
						// 	str += '<div class="time" style="margin-left: 30px;">' + data.data[i].time + '</div><div class="step" style="font-size: 0.5rem; padding: 5px 20px;    margin-left: 30px;">' + data.data[i].context + '</div>';
						// }


						function getnr(data) {
							for (var aaa of data) {

								str += `

								
									<li>
										<i style="color:rgba(151,160,180,1);font-size:14px;font-style: initial;">${aaa.time}</i>
										<i style="color:rgba(65,70,88,1);font-size:14px;font-style: initial;">${aaa.context}</i>
									</li>
								
								
								`


							}
								// <div class="time">
								// 	${aaa.time}
								// </div>
								
								// <div class="step">
								// ${aaa.context}
								// </div>
							return str
						}

						for (var item of data) {
							title = `

						<div class="row">
						
							<div class="col-2" style="text-align: end;color: rgba(65,70,88,1);font-size: 14px;">物流公司：</div>
							<div class="col-9" style="color:rgba(65,70,88,1);font-size: 14px;">${ item.kuaidi_name}</div>
						</div>

						<div class="row">
							<div class="col-2" style="text-align: end;color: rgba(65,70,88,1);font-size: 14px;">运单号码：</div>
							<div class="col-9" style="color:rgba(65,70,88,1);font-size: 14px;">${ item.courier_num}</div>
						</div>

						<div class="row">
							<div class="col-2" style="text-align: end;color: rgba(65,70,88,1);font-size: 14px;">物流跟踪：</div>
							<div class="col-9">
									<ul>
							${

								getnr(item.data)

								}
							</ul>
							</div>
						</div>
						`
						}

						wl_appendMask(title, "cg");
					} else {
						appendMask('暂无物流信息！', "ts");
					}
				},
			});
		};


		function excel(url) {
			export_popup(url);
		}

		function export_popup(url) {
			var res = `<div class="pup_div" id="pup_div">
                        <div class="pup_flex">
                            <div class="pup_auto">
                                <div class="pup_head"><span>导出数据</span>
                                    <img src="images/icon/cha.png" onclick="export_close('${url}','')">
                                </div>
                                
                                <div class="pup_dc">
                                    <div class="pup_dcv" onclick="export_close('${url}','This_page')">
                                        <div>
                                            <img src="images/iIcon/scby.png" />
                                            <p>导出本页</p>
                                        </div>
                                    </div>
                                    <div class="pup_dcv" onclick="export_close('${url}','whole')">
                                        <div>
                                            <img src="images/iIcon/dcqb.png" />
                                            <p>导出全部</p>
                                        </div>
                                    </div>
                                    <div class="pup_dcv" onclick="export_close('${url}','inquiry')"> 
                                        <div>
                                            <img src="images/iIcon/dcss.png" />
                                            <p>导出查询</p>
                                        </div>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                    </div>`;
			$("body").append(res);
		}
		function export_close(url, type) {
			$("#pup_div").remove();
			location.href = location.href + '&pageto=' + type;
		}
		var i = 0;
		$('select[name=otype]').change(function () {
			let ss = $(this).children('option:selected').val();
			if (ss == 't2') {
				$('select[name=status]').empty();
				$('select[name=status]').append("<option value=''>拼团状态</option><option value='g0'>未付款</option><option value='g1'>拼团中</option><option value='g2'>拼团成功</option><option value='g3'>拼团失败</option>");
			} else {
				$('select[name=status]').empty();
				$('select[name=status]').append("<option value=''>请选择订单状态</option><option value='0'>未付款</option><option value='1'>未发货</option><option value='2'>已发货</option><option value='3'>待评论</option><option value='4'>退货</option><option value='5'>已完成</option><option value='6'>订单关闭</option>");
				$('select[name=ostatus]').remove();
			}
		})

		$('select[name=status]').change(function () {
			let ss = $('select[name=otype]').children('option:selected').val();
			let gg = $(this).children('option:selected').val();
			if (gg == 'g2') {
				$('#fail').remove();
				$('select[name=status]').after("<select name='ostatus' class='select' id='success' style='width: 80px;height: 31px;vertical-align: middle;margin-left: 5px;'><option value='g1' selected>未发货</option><option value='g2'>已发货</option><option value='g3'>已签收</option></select>");
			} else if (gg == 'g3') {
				$('#success').remove();
				$('select[name=status]').after("<select name='ostatus' class='select' id='fail' style='width: 80px;height: 31px;vertical-align: middle;margin-left: 5px;'><option value='g10' selected>未退款</option><option value='g11'>已退款</option></select>");
			} else {
				$('select[name=ostatus]').remove();
			}
		})

		var having = $('input[name=having]').val();
		var otype = $('input[name=ordtype]').val();
		var gstatus = $('input[name=gcode]').val();
		var ostatus = $('input[name=ocode]').val();
		if (having == '123') {
			var tv = $('select[name=otype]').children('option:selected').val();
			if (tv == 't2') {
				$('select[name=status]').empty();
				$('select[name=status]').append("<option value=''>拼团状态</option>");
				var options = {
					g0: '未付款',
					g1: '拼团中',
					g2: '拼团成功',
					g3: '拼团失败'
				};
				var str = '';

				$.each(options, function (index, element) {
					str = '<option value="' + index + '"';
					if (gstatus == index) {
						str += ' selected';
					}
					str += '>' + element + '</option>';
					$('select[name=status]').append(str);
				})


				var gv = $('select[name=status]').children('option:selected').val();
				if (gstatus == 'g2') {
					$('#fail').remove();
					$('select[name=status]').after("<select name='ostatus' class='select' id='success' style='width: 80px;height: 31px;vertical-align: middle;margin-left: 5px;'></select>");
					var options = {
						g1: '未发货',
						g2: '已发货',
						g3: '已签收'
					};
					var str = '';
					$.each(options, function (index, element) {
						str = '<option value="' + index + '"';
						if (ostatus == index) {
							str += ' selected';
						}
						str += '>' + element + '</option>';
						$('select[name=ostatus]').append(str);
					})
				} else if (gstatus == 'g3') {
					$('#success').remove();
					$('select[name=status]').after("<select name='ostatus' class='select' id='fail' style='width: 80px;height: 31px;vertical-align: middle;margin-left: 5px;'><select>");
					var options = {
						g10: '未退款',
						g11: '已退款'
					};
					var str = '';
					$.each(options, function (index, element) {
						str = '<option value="' + index + '"';
						if (ostatus == index) {
							str += ' selected';
						}
						str += '>' + element + '</option>';
						$('select[name=ostatus]').append(str);
					})
				} else {
					$('select[name=ostatus]').remove();
				}
			}

		}

		//实现全选与反选
		var ids = [];
		$("#allAndNotAll").click(function () {
			if (this.checked) {
				$("input[name=checkid]").each(function (index) {
					$(this).prop("checked", true);
					var val = $(this).val();
					arrModify(ids, val, 1);
				});
			} else {
				$("input[name=checkid]").each(function (index) {
					$(this).prop("checked", false);
					var val = $(this).val();
					arrModify(ids, val, 2);
				});
			}

		});

		Array.prototype.indexOf = function (val) {
			for (var i = 0; i < this.length; i++) {
				if (this[i] == val) return i;
			}
			return -1;
		}
		Array.prototype.remove = function (val) {
			var index = this.indexOf(val);
			if (index > -1) {
				this.splice(index, 1);
			}
		}

		function arrModify(arr, val, type) { //１为增加元素  2为删除元素
			if (type == 1) {
				var index = $.inArray(val, arr);
				if (index === -1) arr.push(val);
			} else if (type == 2) {
				arr.remove(val);
			}
			return arr;
		}

		function selectId(i) {
			i = i.toString();
			var index = $.inArray(i, ids); //判断数组中是否存在该值,如存在返回下标值,如不存在，返回-1
			if ($('#checkid' + i).prop('checked') == true) {
				if (index === -1) ids.push(i);
			} else {
				ids.remove(i);
			}
		}
		Array.prototype.distinct = function () { //数组去重
			var arr = this,
				result = [],
				i,
				j,
				len = arr.length;
			for (i = 0; i < len; i++) {
				for (j = i + 1; j < len; j++) {
					if (arr[i] === arr[j]) {
						j = ++i;
					}
				}
				result.push(arr[i]);
			}
			return result;
		}

		$('#getAllSelectedId').click(function () {

			if (ids.length === 0) {
				layer.alert('没有选择订单！', {
					icon: 5,
					title: "提示"
				});
			} else {
				layer.confirm('确定要删除吗？', function (index) {
					ids = ids.distinct();
					var delIds = ids.join(",");
					$.ajax({
						url: "index.php?module=orderslist&action=delorder",
						type: "post",
						data: {
							ids: delIds
						},
						dataType: "json",
						success: function (data) {
							if (data.code == 1) {
								layer.alert(data.msg, {
									skin: 'layui-layer-lan',
									closeBtn: 0,
									anim: 4 //动画类型
								}, function () {
									location.reload();
								});

							}
						},
					});
				});
			}
		});
		function confirm1(content, id, content1) {
			$("body").append(`
				<div class="maskNew">
					<div class="maskNewContent">
						<a href="javascript:void(0);" class="closeA" onclick=closeMask1() ><img src="images/icon1/gb.png"/></a>
						<div class="maskTitle">提示</div>
						<div style="text-align:center;margin-top:30px"><img src="images/icon1/ts.png"></div>
						<div style="height: 50px;position: relative;top:20px;font-size: 22px;text-align: center;">
							${content}
						</div>
						<div style="text-align:center;margin-top:30px">
							<button class="closeMask" style="margin-right:20px" onclick=closeMask2("${id}","${content1}") >确认</button>
							<button class="closeMask" onclick=closeMask1() >取消</button>
						</div>
					</div>
				</div>
			`)
		}
		function closeMask2(id, content) {
			$(".maskNew").remove();
			$.ajax({
				type: "post",
				url: "index.php?module=coupon&action=whether&id=" + id,
				async: true,
				success: function (res) {
					console.log(res);
					if (content == "启用") {
						if (res == 1) {
							appendMask("启用成功", "cg");
						}
						else {
							appendMask("启用失败", "ts");
						}
					}
					else {
						if (res == 1) {
							appendMask("禁用成功", "cg");
						}
						else {
							appendMask("禁用失败", "ts");
						}
					}
				}
			});
		}
		function wl_appendMask(content, src) {
			$("body").append(`
				<div class="wl_maskNew">

					<div class="wl_maskNewContent">
						<a href="javascript:void(0);" class="closeA" onclick=close_wl_Mask1() ><img src="images/icon1/gb.png"/></a>
						<div class="maskTitle" style="display: block;font-size:16px;font-weight:bold;">物流信息</div>
						<div style="height: 470px;position: relative;top:20px;font-size: 22px;overflow: scroll;">
							${content}
						</div>
						<div style="text-align:center;margin-top:30px">
					<button class="closeMask" onclick=close_wl_Mask1() >确认</button>
				</div>
					</div>
				</div>


			`)
		}

		function close_wl_Mask1() {
			$(".wl_maskNew").remove();
		}

		function appendMask(content, src) {
			$("body").append(`
				<div class="maskNew ">
					<div class="maskNewContent">
						<a href="javascript:void(0);" class="closeA" onclick=closeMask1() ><img src="images/icon1/gb.png"/></a>
						<div class="maskTitle">提示</div>
						<div style="text-align:center;margin-top:30px"><img src="images/icon1/${src}.png"></div>
						<div style="height: 50px;position: relative;top:20px;font-size: 22px;text-align: center;">
							${content}
						</div>
						<div style="text-align:center;margin-top:30px">
							<button class="closeMask" onclick=closeMask1() >确认</button>
						</div>
					</div>
				</div>
			`)
		}

		function appendMask_tj(content, src) {
			$(".dc").hide();
			$("body").append(`
				<div class="maskNew ">
					<div class="maskNewContent">
						<a href="javascript:void(0);" class="closeA" onclick=closeMask1() ><img src="images/icon1/gb.png"/></a>
						<div class="maskTitle">提示</div>
						<div style="text-align:center;margin-top:30px"><img src="images/icon1/${src}.png"></div>
						<div style="height: 50px;position: relative;top:20px;font-size: 22px;text-align: center;">
							${content}
						</div>
						<div style="text-align:center;margin-top:30px">
							<button class="closeMask" onclick=closeMask_tj() >确认</button>
						</div>
					</div>
				</div>
			`)
		}

		function closeMask_tj() {
			$(".maskNew").remove();
			$(".dc").show();
		}

		function appendMask1(content, src) {
			$("body").append(`
				<div class="maskNew maskNew1">
					<div class="maskNewContent">
						<a href="javascript:void(0);" class="closeA" onclick=closeMask4() ><img src="images/icon1/gb.png"/></a>
						<div class="maskTitle">提示</div>
						<div style="text-align:center;margin-top:30px"><img src="images/icon1/${src}.png"></div>
						<div style="height: 50px;position: relative;top:20px;font-size: 22px;text-align: center;">
							${content}
						</div>
						<div style="text-align:center;margin-top:30px">
							<button class="closeMask" onclick=closeMask4() >确认</button>
						</div>

					</div>
				</div>
			`)
		}
		function closeMask(id) {
			$(".maskNew").remove();
			$.ajax({
				type: "post",
				url: "index.php?module=coupon&action=del&id=" + id,
				async: true,
				success: function (res) {
					console.log(res)
					if (res == 1) {
						appendMask("删除成功", "cg");
					}
					else {
						appendMask("删除失败", "ts");
					}
				}
			});
		}

		// 删除订单
		function deleteS() {
			$.ajax({
				url: 'index.php?module=orderslist&action=delorder&ids=' + conStr,
				type: "post",
				data: {},
				success: function (res) {
					// 刷新
					location.replace(location.href);
					// debugger
				}
			})
		}

		// 关闭订单
		function openS() {
			$.ajax({
				url: 'index.php?module=orderslist&action=addsign&m=close&sNo=' + colsEsno,
				type: "post",
				data: {},
				success: function (res) {
					location.replace(location.href);
					// debugger
				}
			})
		}

		function closeMask1() {
			$(".maskNew").remove();
			if (deIsOpn === 1) {
				deleteS()
			} else if (deIsOpn === 2) {
				openS()
			}
		}

		function deletes() {
			if (deIsOpn === 1) {
				deleteS()
			} else if (deIsOpn === 2) {
				openS()
			}
		}

		function closeMask4() {
			$(".maskNew1").remove();
			location.replace(location.href);
		}
		function confirm(content, id) {
			$("body").append(`
				<div class="maskNew">
					<div class="maskNewContent">
						<a href="javascript:void(0);" class="closeA" onclick=closeMask1() ><img src="images/icon1/gb.png"/></a>
						<div class="maskTitle">提示</div>
						<div style="text-align:center;margin-top:30px"><img src="images/icon1/ts.png"></div>
						<div style="height: 50px;position: relative;top:20px;font-size: 22px;text-align: center;">
							${content}
						</div>
						<div style="text-align:center;margin-top:30px">
							<button class="closeMask" style="margin-right:20px" onclick=closeMask("${id}") >确认</button>
							<button class="closeMask" onclick=closeMask1() >取消</button>
						</div>
					</div>
				</div>
			`)
		}
		function hm() {
			$(".dd").hide();
		}

		window.onload = function () {
			$(".imgTd").each(function () {
				$(this).find("div").each(function () {
					$(this).hide();
				})
				$(this).find("div").eq(0).show()
			})
			$(".tbText").each(function () {
				$(this).find("span").each(function () {
					$(this).hide();
				})
				$(this).find("span").eq(0).show()
			})

			laydate.render({
				elem: '#startdate', //指定元素
				type: 'datetime'
			});

			laydate.render({
				elem: '#enddate',
				type: 'datetime'
			});


		}
		function empty() {
			// 

			$("input[name='sNo']").val('');
			$("input[name='startdate']").val('');
			$("input[name='enddate']").val('');

			$("#otype_").val(null).trigger("change");
			$("#status_").val(null).trigger("change");

			$("#otype").val('');
			$("#status").val('');
			$("#source").val('');
			$("#brand").val('');
			// location.reload()

		}




	</script>
	{/literal}
</body>

</html>