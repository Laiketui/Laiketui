
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
{php}include BASE_PATH."/modules/assets/templates/top.tpl";{/php}

{literal}
<style>
td a{
	width: 28%;
	margin: 2%!important;
	float: left;
}
.dataTables_wrapper .dataTables_length{
	bottom: 13px;
}
.btn1{
	width: 80px;
	height: 40px;
	line-height: 40px;
	display: flex;
	justify-content: center;
	align-items: center;
	float: left;
	color: #6a7076;
	background-color: #fff;
}
.btn1:hover{
	text-decoration: none;
}
</style>
{/literal}
<title>财务管理</title>
</head>
<body>

<nav class="breadcrumb">
    财务管理 <span class="c-gray en">&gt;</span> 
    提现列表 
</nav>


<div class="pd-20">
	<div>
		<a href="index.php?module=finance" class="btn1" style="background-color: #62b3ff;color: #fff;">待审核</a> 
		<a href="index.php?module=finance&action=list" class="btn1" style="color:#6a7076;">已通过</a>
		<a href="index.php?module=finance&action=list1" class="btn1" style="color:#6a7076;">已拒绝</a>
		<div class="clearfix"></div>
	</div>
	<div class="mt-20 text-c">
		<form name="form1" action="index.php?module=finance" method="get">
			<input type="hidden" name="module" value="finance" />
			<input type="hidden" name="pagesize" value="{$pagesize}" id="pagesize" />

			<input type="text" class="input-text" style="width:250px" autocomplete="off" placeholder="用户ID" name="name" value="{$name}">
			<input type="text" class="input-text" style="width:250px" autocomplete="off" placeholder="卡号" name="Bank_card_number" value="{$Bank_card_number}">
			<input type="text" class="input-text" style="width:250px" autocomplete="off" placeholder="持卡人姓名" name="Cardholder" value="{$Cardholder}">
	        <input type="submit" class="btn btn-success" value="查 询">
			<!--<input type="button" value="导出本页" class="btn btn-success" onclick="excel('ne')">-->
			<input type="button" value="导出" class="btn btn-success" onclick="excel('all')">
		</form>
	</div>

    <div class="mt-20" style="background: #fff;">
        <table class="table table-border table-bordered table-bg table-hover">
            <thead>
                <tr class="text-c">
                	<th width="40">序</th>
		            <th width="150" aria-valuetext="name">用户ID</th>
					<th width="130" aria-valuetext="source">来源</th>
					<th width="130" aria-valuetext="add_date">提交时间</th>
		            <th width="150" aria-valuetext="money">提现金额</th>
		            <th width="150" aria-valuetext="s_charge">提现手续费</th>
		            <th width="150" aria-valuetext="Bank_name">银行名称</th>
		            <th width="150" aria-valuetext="Cardholder">持卡人姓名</th>
		            <th width="150" aria-valuetext="Bank_card_number">卡号</th>
		            <th width="150" aria-valuetext="mobile">联系电话</th>
		            <th width="100" aria-valuetext="status">状态</th>
		            <th >操作</th>
		        </tr>
            </thead>
            <tbody>
	            {foreach from=$list item=item name=f1}
	                <tr class="text-c">
	                    <td>{$smarty.foreach.f1.iteration}</td>
						<td>{$item->user_id}</td>
						<td>{if $item->source == 1}小程序{elseif $item->source == 2}app{/if}</td>
	                    <td>{$item->add_date}</td>
	                    <td>{$item->money}元</td>
	                    <td>{$item->s_charge}元</td>
	                    <td>{$item->Bank_name}</td>
	                    <td>{$item->Cardholder}</td>
	                    <td>{$item->Bank_card_number}</td>
	                    <td>{$item->mobile}</td>
	                    <td>{if $item->status == 0}<span style="color: #ff2a1f;">待审核</span>{elseif $item->status == 1}<span style="color: #30c02d;">审核通过</span>{else}<span style="color: #7A7A7A;">已拒绝</span>{/if}</td>
	                    <td style="min-width: 180px">
							
							{if $item->status == 0}
	                        <a style="text-decoration:none" class="ml-5" onclick="examine(this,1,'{$item->id}','{$item->user_id}','{$item->money}','{$item->s_charge}')" >
		                        <div style="align-items: center;font-size: 12px;display: flex;">
	                            	<div style="margin:0 auto;;display: flex;align-items: center;"> 
	                                <img src="images/icon1/sx.png"/>&nbsp;通过
	                            	</div>
	                        	</div>
	                        </a>
	                        <a style="text-decoration:none" class="ml-5" onclick="examine(this,2,'{$item->id}','{$item->user_id}','{$item->money}','{$item->s_charge}')" >
	                        	<div style="align-items: center;font-size: 12px;display: flex;">
	                            	<div style="margin:0 auto;;display: flex;align-items: center;"> 
	                                <img src="images/icon1/jy.png"/>&nbsp;拒绝
	                            	</div>
	                        	</div>
	                        </a>
	                        {/if}
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
function examine(obj,m,id,user_id,money,s_charge) {
	if(m == 1){
        confirm("确定要通过该用户的申请？",m,id,user_id,money,s_charge);
    }else{
        confirm("确定要拒绝该用户的申请？",m,id,user_id,money,s_charge);
    }
}
function confirm (content,m,id,user_id,money,s_charge){
    $("body").append(`
        <div class="maskNew">
            <div class="maskNewContent">
                <a href="javascript:void(0);" class="closeA" onclick=closeMask1() ><img src="images/icon1/gb.png"/></a>
                <div class="maskTitle">删除</div>
                <div style="text-align:center;margin-top:30px"><img src="images/icon1/ts.png"></div>
                <div style="height: 50px;position: relative;top:20px;font-size: 22px;text-align: center;">
                    ${content}
                </div>
                <div style="text-align:center;margin-top:30px">
                    <button class="closeMask" style="margin-right:20px" onclick=closeMask('${m}','${id}','${user_id}','${money}','${s_charge}') >确认</button>
                    <button class="closeMask" onclick=closeMask1() >取消</button>
                </div>
            </div>
        </div>
    `)
}
function closeMask1(){
    $(".maskNew").remove();
    location.replace(location.href);
}
function closeMask(m,id,user_id,money,s_charge){
    $.get("index.php?module=finance&action=del",{'m':m,'id':id,'user_id':user_id,'money':money,'s_charge':s_charge},function(res){
        if(res=="1"){
            appendMask("成功","cg");
        }else{
            appendMask("失败","ts");
        }
    },"json");
    $(".maskNew").remove();
}
function appendMask(content,src){
    $("body").append(`
        <div class="maskNew">
            <div class="maskNewContent">
                <a href="javascript:void(0);" class="closeA" onclick=closeMask1() ><img src="images/icon1/gb.png"/></a>
                <div class="maskTitle">删除</div>
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
</script>
{/literal}
</body>
</html>


