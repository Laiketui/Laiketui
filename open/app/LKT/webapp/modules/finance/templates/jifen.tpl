<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
{php}include BASE_PATH."/modules/assets/templates/top.tpl";{/php}

<title>积分列表</title>
{literal}
<style>
td a{
	width: 44%;
	margin: 0 auto!important;
}
.dataTables_wrapper .dataTables_length{
	bottom: 13px;
}
#btn1:hover{
	background-color: #2481e5!important;
}
#btn1{
	height: 36px;
	line-height: 36px;
}
#btn2:hover{
	background-color: #0fa675!important;
}
#btn2{
	background-color: #17ba8e!important;
	height: 36px;
	line-height: 36px;
}
</style>
{/literal}
</head>

<body>

<nav class="breadcrumb">
    财务管理 <span class="c-gray en">&gt;</span> 
    积分列表 
</nav>


<div class="pd-20">
	<div class="text-c">
		<form name="form1" action="index.php?module=finance&action=jifen" method="get">
			<input type="hidden" name="module" value="finance" />
			<input type="hidden" name="action" value="jifen" />
			<input type="hidden" name="pagesize" value="{$pagesize}" id="pagesize" />
			<div>
				<select name="otype" class="select" style="width: 200px;height: 31px;vertical-align: middle;">
					<option value="all" {if $type =='all'} selected{/if}>请选择要查询的类型</option>
					<option value="0" {if $type =='0' } selected{/if}>签到</option>
					<option value="1" {if $type =='1' } selected{/if}>消费</option>
					<option value="2" {if $type =='2' } selected{/if}>关注</option>
					<option value="3" {if $type =='3' } selected{/if}>转积分给好友</option>
					<option value="4" {if $type =='4' } selected{/if}>好友转积分</option>
					<option value="5" {if $type =='5' } selected{/if}>系统扣除</option>
					<option value="6" {if $type =='6' } selected{/if}>系统充值</option>
					<option value="7" {if $type =='7' } selected{/if}>抽奖</option>
				</select>
				<input type="text" class="input-text" style="width:250px" placeholder="用户名/用户ID" autocomplete="off" name="user_name" value="{$user_name}">
				<input type="text" class="input-text" style="width:250px" placeholder="手机号" autocomplete="off" name="mobile" value="{$mobile}">

				{*<div style="position: relative;display: inline-block;">*}
				{*<input name="startdate" value="{$startdate}" size="8" readonly class="scinput_s iptRl" style="" />*}
				{*<img src="images/icon1/rl.png" style="cursor:pointer;position: absolute;right: 25px;top: 7px;" onclick="new Calendar().show(document.form1.startdate);" />~*}
				{*</div>*}
				{*<div style="position: relative;display: inline-block;">*}
				{*<input  name="enddate" value="{$enddate}" size="8" readonly class="scinput_s iptRl" style="" />*}
				{*<img src="images/icon1/rl.png" style="cursor:pointer;position: absolute;right: 10px;top: 7px;" onclick="new Calendar().show(document.form1.enddate);" />*}
				{*</div>*}
				<input type="submit" class="btn btn-success" id="btn1" value="查 询">
				<input type="button" value="导出" class="btn btn-success" id="btn2" onclick="excel('all')">
			</div>
		</form>
	</div>

	<div class="mt-20" style="background: #fff;">
		<table class="table table-border table-bordered table-bg table-hover">
			<thead>
				<tr class="text-c">
					<th width="150" aria-valuetext="user_id">用户ID</th>
					<th width="130" aria-valuetext="user_name">用户名</th>
					<th width="150" aria-valuetext="sign_score">充值积分</th>
					<th width="130" aria-valuetext="source">来源</th>
					<th width="150" aria-valuetext="sign_time">时间</th>
					<th width="150" aria-valuetext="type">充值方式</th>
					<th width="100">操作</th>
				</tr>
			</thead>
            <tbody>
	            {foreach from=$list item=item name=f1}
	                <tr class="text-c">
	                    <td>{$item->user_id}</td>
	                    <td>{$item->user_name}</td>
	         			
	                    <td>
							{if $item->type ==0 ||$item->type ==2|| $item->type ==4 || $item->type ==6 || $item->type ==7}+{$item->sign_score}{/if}
							{if $item->type ==1 ||$item->type ==3 ||$item->type ==5}-{$item->sign_score}{/if}
	         			</td>
						<td>{if $item->source == 1}小程序{elseif $item->source == 2}APP{/if}</td>
						<td>{$item->sign_time}</td>
	                    <td>
	                    	{if $item->type == 0 }签到领积分{/if}
	                    	{if $item->type == 1 }消费积分{/if}
	                    	{if $item->type == 2 }首次关注得积分{/if}
	                    	{if $item->type == 3 }转积分给好友{/if}
	                    	{if $item->type == 4 }好友转积分{/if}
							{if $item->type == 5 }系统扣除{/if}
							{if $item->type == 6 }系统充值{/if}
							{if $item->type == 7 }抽奖{/if}
	                    </td>
	                    <td style="min-width:120px;">
							<a style="text-decoration:none" class="ml-5" href="index.php?module=finance&action=jifen_see&user_id={$item->user_id}" title="查看">
								<div style="align-items: center;font-size: 12px;display: flex;">
	                            	<div style="margin:0 auto;;display: flex;align-items: center;">
	                                <img src="images/icon1/ck.png"/>&nbsp;查看
	                            	</div>
                        		</div>
							</a>
	                    </td>
	                </tr>
	            {/foreach}
            </tbody>
        </table>
    </div>
	<div style="text-align: center;display: flex;justify-content: center;">{$pages_show}</div>
</div>

{php}include BASE_PATH."/modules/assets/templates/footer.tpl";{/php}


{literal}
<script type="text/javascript">
function excel(pageto) {
	var pagesize = $("#pagesize").val();
	location.href=location.href+'&pageto='+pageto+'&pagesize='+pagesize;
}
</script>
{/literal}
</body>

</html>