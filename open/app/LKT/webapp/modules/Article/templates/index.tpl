
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
{php}include BASE_PATH."/modules/assets/templates/top.tpl";{/php}

<title>文章管理</title>
{literal}
<style>
   	td a{
        min-width: 44%;
        margin: 2%!important;
        float: left;
    }
</style>
{/literal}
</head>
<body>


<nav class="breadcrumb">
    系统管理 <span class="c-gray en">&gt;</span> 
    <a href="index.php?module=Article">文章列表</a>
    
</nav>


<div class="pd-20">
    <div style="clear:both;">
        <input type="button" class="btn btn-primary radius" value="发表文章" onclick="location.href='index.php?module=Article&action=add';" />
    </div>
    <div class="mt-20">
        <table class="table table-border table-bordered table-bg table-hover table-sort">
            <thead>
                <tr class="text-c">
                    <th>序</th>
                    <th>标题</th>
                    <th>图片</th>
                    <th>排序号</th>
                    <th>发布时间</th>
                    <th>分享次数</th>
                    <th >操作</th>
                </tr>
            </thead>
            <tbody>
            {foreach from=$list item=item name=f1}
                <tr class="text-c">
                    <td>{$smarty.foreach.f1.iteration}</td>
                    <td>{$item->Article_title}</td>
                    {if $item->Article_imgurl != ''}
                    <td><image class="pimg" src="{$uploadImg}{$item->Article_imgurl}" style="width: 120px;height:80px;"/></td>
                    {else}
                    <td><image class="pimg" src="{$uploadImg}nopic.jpg" style="width: 120px;height:80px;"/></td>
                    {/if}
                    <td>{$item->sort}</td>
                    <td>{$item->add_date}</td>
                    <td>{$item->share_num}</td>
                    <td style="width: 180px;">
                        <a style="text-decoration:none" class="ml-5" href="index.php?module=Article&action=view&id={$item->Article_id}" title="查看分享列表" >
                        	<div style="align-items: center;font-size: 12px;display: flex;">
                            	<div style="margin:0 auto;;display: flex;align-items: center;"> 
                                <img src="images/icon1/ck.png"/>&nbsp;查看分享
                            	</div>
            				</div>
                        </a>
                        <a style="text-decoration:none" class="ml-5" href="index.php?module=Article&action=amount&id={$item->Article_id}" title="分享红包设置" >
                        	<div style="align-items: center;font-size: 12px;display: flex;">
                            	<div style="margin:0 auto;;display: flex;align-items: center;"> 
                                <img src="images/icon1/sx.png"/>&nbsp;分享设置
                            	</div>
            				</div>
                        </a>
                        <a style="text-decoration:none" class="ml-5" href="index.php?module=Article&action=modify&id={$item->Article_id}&uploadImg={$uploadImg}" title="修改" >
                        	<div style="align-items: center;font-size: 12px;display: flex;">
                            	<div style="margin:0 auto;;display: flex;align-items: center;"> 
                                <img src="images/icon1/xg.png"/>&nbsp;修改
                            	</div>
            				</div>
                        </a>
                        <a style="text-decoration:none" class="ml-5" href="index.php?module=Article&action=del&id={$item->Article_id}&uploadImg={$uploadImg}" onclick="return confirm('确定要删除此文章吗?')">
                        	<div style="align-items: center;font-size: 12px;display: flex;">
                            	<div style="margin:0 auto;;display: flex;align-items: center;"> 
                                <img src="images/icon1/del.png"/>&nbsp;删除
                            	</div>
            				</div>
                        </a>
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
</div>
<div id="outerdiv" style="position:fixed;top:0;left:0;background:rgba(0,0,0,0.7);z-index:2;width:100%;height:100%;display:none;"><div id="innerdiv" style="position:absolute;"><img id="bigimg" src="" /></div></div> 

{php}include BASE_PATH."/modules/assets/templates/footer.tpl";{/php}


{literal}
<script type="text/javascript">
$('.table-sort').dataTable({
    "aaSorting": [[ 1, "desc" ]],//默认第几个排序
    "bStateSave": true,//状态保存
    "aoColumnDefs": [
      //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
      {"orderable":false,"aTargets":[0,5]}// 制定列不参与排序
    ]
});
$(function(){  
        $(".pimg").click(function(){  
            var _this = $(this);//将当前的pimg元素作为_this传入函数  
            imgShow("#outerdiv", "#innerdiv", "#bigimg", _this);  
        });  
    });
function imgShow(outerdiv, innerdiv, bigimg, _this){  
    var src = _this.attr("src");//获取当前点击的pimg元素中的src属性  
    $(bigimg).attr("src", src);//设置#bigimg元素的src属性  
  
        /*获取当前点击图片的真实大小，并显示弹出层及大图*/  
    $("<img/>").attr("src", src).load(function(){  
        var windowW = $(window).width();//获取当前窗口宽度  
        var windowH = $(window).height();//获取当前窗口高度  
        var realWidth = this.width;//获取图片真实宽度  
        var realHeight = this.height;//获取图片真实高度  
        var imgWidth, imgHeight;  
        var scale = 0.8;//缩放尺寸，当图片真实宽度和高度大于窗口宽度和高度时进行缩放  
          
        if(realHeight>windowH*scale) {//判断图片高度  
            imgHeight = windowH*scale;//如大于窗口高度，图片高度进行缩放  
            imgWidth = imgHeight/realHeight*realWidth;//等比例缩放宽度  
            if(imgWidth>windowW*scale) {//如宽度扔大于窗口宽度  
                imgWidth = windowW*scale;//再对宽度进行缩放  
            }  
        } else if(realWidth>windowW*scale) {//如图片高度合适，判断图片宽度  
            imgWidth = windowW*scale;//如大于窗口宽度，图片宽度进行缩放  
                        imgHeight = imgWidth/realWidth*realHeight;//等比例缩放高度  
        } else {//如果图片真实高度和宽度都符合要求，高宽不变  
            imgWidth = realWidth;  
            imgHeight = realHeight;  
        }  
                $(bigimg).css("width",imgWidth);//以最终的宽度对图片缩放  
          
        var w = (windowW-imgWidth)/2;//计算图片与窗口左边距  
        var h = (windowH-imgHeight)/2;//计算图片与窗口上边距  
        $(innerdiv).css({"top":h, "left":w});//设置#innerdiv的top和left属性  
        $(outerdiv).fadeIn("fast");//淡入显示#outerdiv及.pimg  
    });  
      
    $(outerdiv).click(function(){//再次点击淡出消失弹出层  
        $(this).fadeOut("fast");  
    });  
} 
</script>
{/literal}
</body>
</html>