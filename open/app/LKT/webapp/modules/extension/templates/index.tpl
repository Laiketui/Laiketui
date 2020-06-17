<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>

    {php}include BASE_PATH."/modules/assets/templates/top.tpl";{/php}

    {literal}
        <style type="text/css">
            td {
                text-align: center;
                width: 200px;
                height: 50px;
            }

            td a {
                width: 44%;
                margin: 2% !important;
                float: left;
            }
        </style>
    {/literal}
    <title>推广图管理</title>
</head>
<body>

<nav class="breadcrumb">
    系统管理 <span class="c-gray en">&gt;</span>
    推广图
</nav>


<div class="pd-20">
    <div style="clear:both;">
        <input type="button" class="btn btn-primary radius" value="添加推广图"
               onclick="location.href='index.php?module=extension&action=add';"/>

        <input type="button" class="btn btn-primary radius" value="清理缓存推广图" onclick="del_simg()"/>
    </div>

    <div class="mt-20">
        <table class="table table-border table-bordered table-bg table-hover">
            <thead>
            <tr class="text-c">
                {*<th>序</th>*}
                <th>图片</th>
                <th>名称</th>
                <th>类型</th>
                <th>是否默认</th>
                <th>发布时间</th>
                <th width="200px">操作</th>
            </tr>
            </thead>
            <tbody>
            {foreach from=$list item=item name=f1}
                <tr class="text-c">
                    {*<td>{$smarty.foreach.f1.iteration}</td>*}
                    <td>
                        {if $item->image != ''}
                            <image class='pimg' src="{$uploadImg}{$item->image}" style="width: 15%;"/>
                        {else}
                            <span>暂无图片</span>
                        {/if}
                    </td>
                    <td>{$item->name}</td>
                    <td>
                        {if $item->type == '1'}
                            <span style="border-radius: 10px;background: #FFA500;padding:0 10px;color:#fff;">商城海报</span>
                        {elseif $item->type == '2'}
                            <span style="border-radius: 10px;background: #EE2C2C;padding:0 10px;color:#fff;">红包海报</span>
                        {elseif $item->type == '3'}
                            <span style="border-radius: 10px;background: #8DB6CD;padding:0 10px;color:#fff;">商品海报</span>
                        {elseif $item->type == '4'}

                        {else}
                            <span style="border-radius: 10px;background: #EEEE00;padding:0 10px;color:#fff;">商城海报</span>
                        {/if}
                    </td>
                    <td>{if $item->isdefault == '1'}是 {else}否{/if}</td>
                    <td>{$item->add_date}</td>
                    <td>
                        <a style="text-decoration:none" class="ml-5"
                           href="index.php?module=extension&action=modify&id={$item->id}" title="修改">
                            <div style="align-items: center;font-size: 12px;display: flex;">
                                <div style="margin:0 auto;;display: flex;align-items: center;">
                                    <img src="images/icon1/xg.png"/>&nbsp;修改
                                </div>
                            </div>
                        </a>
                        <a style="text-decoration:none" class="ml-5" onclick="del(this,{$item->id})">
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
    <div style="text-align: center;display: flex;justify-content: center;">{$pages_show}</div>
</div>
<div id="outerdiv"
     style="position:fixed;top:0;left:0;background:rgba(0,0,0,0.7);z-index:2;width:100%;height:100%;display:none;">
    <div id="innerdiv" style="position:absolute;"><img id="bigimg" src=""/></div>
</div>

{php}include BASE_PATH."/modules/assets/templates/footer.tpl";{/php}


{literal}
    <script type="text/javascript">
        $(function () {
            $(".pimg").click(function () {
                var _this = $(this);//将当前的pimg元素作为_this传入函数
                imgShow("#outerdiv", "#innerdiv", "#bigimg", _this);
            });
        });

        function imgShow(outerdiv, innerdiv, bigimg, _this) {
            var src = _this.attr("src");//获取当前点击的pimg元素中的src属性
            $(bigimg).attr("src", src);//设置#bigimg元素的src属性

            /*获取当前点击图片的真实大小，并显示弹出层及大图*/
            $("<img/>").attr("src", src).load(function () {
                var windowW = $(window).width();//获取当前窗口宽度
                var windowH = $(window).height();//获取当前窗口高度
                var realWidth = this.width;//获取图片真实宽度
                var realHeight = this.height;//获取图片真实高度
                var imgWidth, imgHeight;
                var scale = 0.8;//缩放尺寸，当图片真实宽度和高度大于窗口宽度和高度时进行缩放

                if (realHeight > windowH * scale) {//判断图片高度
                    imgHeight = windowH * scale;//如大于窗口高度，图片高度进行缩放
                    imgWidth = imgHeight / realHeight * realWidth;//等比例缩放宽度
                    if (imgWidth > windowW * scale) {//如宽度扔大于窗口宽度
                        imgWidth = windowW * scale;//再对宽度进行缩放
                    }
                } else if (realWidth > windowW * scale) {//如图片高度合适，判断图片宽度
                    imgWidth = windowW * scale;//如大于窗口宽度，图片宽度进行缩放
                    imgHeight = imgWidth / realWidth * realHeight;//等比例缩放高度
                } else {//如果图片真实高度和宽度都符合要求，高宽不变
                    imgWidth = realWidth;
                    imgHeight = realHeight;
                }
                $(bigimg).css("width", imgWidth);//以最终的宽度对图片缩放

                var w = (windowW - imgWidth) / 2;//计算图片与窗口左边距
                var h = (windowH - imgHeight) / 2;//计算图片与窗口上边距
                $(innerdiv).css({"top": h, "left": w});//设置#innerdiv的top和left属性
                $(outerdiv).fadeIn("fast");//淡入显示#outerdiv及.pimg
            });

            $(outerdiv).click(function () {//再次点击淡出消失弹出层
                $(this).fadeOut("fast");
            });
        }


        function del_simg() {
            $.ajax({
                type: "POST",
                url: location.href,
                data: "m=del_simg",
                success: function (msg) {
                    if (msg == 1) {
                        appendMask("清理成功", "cg");
                        // location.replace(location.href);
                    } else {
                        appendMask("清理失败", "ts");
                        // location.replace(location.href);
                    }
                }
            });
        }

        /*删除*/
        function del(obj, id) {
            confirm("确认删除此商品吗？", id);
        }

        function confirm(content, id) {
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
                    <button class="closeMask" style="margin-right:20px" onclick=closeMask('${id}') >确认</button>
                    <button class="closeMask" onclick=closeMask1() >取消</button>
                </div>
            </div>
        </div>
    `)
        }

        function closeMask1() {
            $(".maskNew").remove();
            location.replace(location.href);
        }

        function closeMask(id) {
            $.get("index.php?module=extension&action=del", {'id': id}, function (res) {
                if (res == "1") {
                    appendMask("删除成功", "cg");
                    // location.replace(location.href);
                } else {
                    appendMask("删除失败", "ts");
                    // location.replace(location.href);
                }
            }, "json");
            $(".maskNew").remove();
        }

        function appendMask(content, src) {
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