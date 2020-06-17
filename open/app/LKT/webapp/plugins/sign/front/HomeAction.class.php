<?php

/**
 * [Laike System] Copyright (c) 2017-2020 laiketui.com
 * Laike is not a free software, it under the license terms, visited http://www.laiketui.com/ for more details.
 */

require_once(MO_WEBAPP_DIR . "/plugins/PluginAction.class.php");

/**
 * 作者：Ketter
 * 插件签到类
 * 请求路径构造
 * http://localhost/open/app/LKT/index.php?module=api&action=pi&p=sign&c=Home&m=index
 */
class HomeAction extends PluginAction
{

    // 点击签到
    public function index()
    {
        $db = DBAction::getInstance();
        $request = $this->getContext()->getRequest();
        $openid = addslashes(trim($request->getParameter('openid'))); // 微信id
        $appConfig = $this->getAppInfo();
        $img = $appConfig['imageRootUrl'];

        $imgurl = ''; // 签到图片
        $min_score = ''; // 最少领取积分
        $max_score = ''; // 最大领取积分
        $continuity_three = ''; // 连续签到7天
        $continuity_twenty = ''; // 连续签到20天
        $activity_overdue = ''; // 连续签到30天

        // 查询签到参数
        $sql = "select * from lkt_sign_config where id = 1";
        $r = $db->select($sql);
        if ($r) {
            $imgurl = $img . $r[0]->imgurl; // 签到图片
            $min_score = $r[0]->min_score; // 最少领取积分
            $max_score = $r[0]->max_score; // 最大领取积分
            $continuity_three = $r[0]->continuity_three; // 连续签到7天
            $continuity_twenty = $r[0]->continuity_twenty; // 连续签到20天
            $activity_overdue = $r[0]->activity_overdue; // 连续签到30天
        }
        $num = 0;

        if (!$openid || $openid == 'undefined') {
            echo json_encode(array('status' => 2, 'err' => '请登录'));
            exit;
        }

        // 根据微信id,查询用户id,用户积分
        $sql = "select user_id from lkt_user where wx_id = '$openid'";
        $rr = $db->select($sql);
        if ($rr) {
            $user_id = $rr[0]->user_id;
            // 查询正在进行的签到活动
            $sql = "select * from lkt_sign_activity where status = 1";
            $rrr = $db->select($sql);
            if ($rrr) {
                $starttime = date("Ymd", strtotime($rrr[0]->starttime)); // 开始时间
                $endtime = date("Ymd", strtotime($rrr[0]->endtime)); // 结束时间
                $day = $endtime - $starttime; // 活动天数

                $start_1 = date("Y-m-d 00:00:00", strtotime("-1 day")); // 昨天开始时间
                $end_1 = date("Y-m-d 23:59:59", strtotime("-1 day")); // 昨天结束时间
                // 根据用户id, 查询昨天签到记录
                $sql = "select * from lkt_sign_record where user_id = '$user_id' and sign_time > '$start_1' and sign_time < '$end_1' and type = 0";
                $rrrr = $db->select($sql);
                if ($rrrr) { // 有数据,就循环查询连续签到几天
                    for ($i = 1; $i <= $day; $i++) {
                        $start = date("Y-m-d 00:00:00", strtotime("-$i day"));
                        $end = date("Y-m-d 23:59:59", strtotime("-$i day"));

                        $sql = "select * from lkt_sign_record where user_id = '$user_id' and sign_time > '$start' and sign_time < '$end' and type = 0";
                        $r_num = $db->select($sql);
                        if (empty($r_num)) {
                            $num = $i;
                            break;
                        }
                    }
                } else { // 没数据,连续签到就为1
                    $num = 1;
                }
            }
            if ($continuity_three != 0 && $num == 7) { // 当设置了连续7天奖励 并且 连续签到7天
                $sign_score = $continuity_three;
            } else if ($continuity_twenty != 0 && $num == 20) { // 当设置了连续20天奖励 并且 连续签到20天
                $sign_score = $continuity_twenty;
            } else if ($activity_overdue != 0 && $num == 30) { // 当设置了连续30天奖励 并且 连续签到30天
                $sign_score = $activity_overdue;
            } else {
                $sign_score = rand($min_score, $max_score);
            }

            $record = "会员" . $user_id . "签到领取" . $sign_score . "积分";
            $sql = "insert into lkt_sign_record (user_id,sign_score,record,sign_time,type) value ('$user_id','$sign_score','$record',CURRENT_TIMESTAMP,0)";
            $r_0 = $db->insert($sql);
            if ($r_0 > 0) {
                $sql = "select score from lkt_user where user_id = '$user_id'";
                $r_1 = $db->select($sql);
                $score = $r_1[0]->score + $sign_score;
                $sql = "update lkt_user set score = score + '$sign_score' where user_id = '$user_id'";
                $db->update($sql);

                $sign_time = [];
                $sql = "select sign_time from lkt_sign_record where user_id = '$user_id' and type = 0";
                $r_2 = $db->select($sql);
                if ($r_2) {
                    foreach ($r_2 as $k => $v) {
                        $y = date("Y", strtotime($v->sign_time));
                        $m = date("m", strtotime($v->sign_time));
                        $d = date("d", strtotime($v->sign_time));
                        if ($m < 10) {
                            $m = str_replace("0", "", $m);
                        }
                        if ($d < 10) {
                            $d = str_replace("0", "", $d);
                        }
                        $sign_time[$k] = $y . $m . $d;
                    }
                }
                echo json_encode(array('status' => 1, 'sign_score' => $sign_score, 'score' => $score, 'sign_time' => $sign_time, 'imgurl' => $imgurl, 'num' => $num));
                exit;
            } else {
                echo json_encode(array('status' => 0, 'err' => '系统繁忙！'));
                exit;
            }
        } else {
            echo json_encode(array('status' => 0, 'err' => '系统繁忙！'));
            exit;
        }
    }

    // 进入签到页面
    public function sign()
    {
        $db = DBAction::getInstance();
        $request = $this->getContext()->getRequest();
        $openid = addslashes(trim($request->getParameter('openid'))); // 微信id
        $year = addslashes(trim($request->getParameter('year'))); // 年
        $month = addslashes(trim($request->getParameter('month'))); // 月


        $appConfig = $this->getAppInfo();
        $img = $appConfig['imageRootUrl'];

        // 查询签到参数
        $sql = "select * from lkt_sign_config where id = 1";
        $r = $db->select($sql);
        if ($r) {
            $imgurl = $img . $r[0]->imgurl; // 签到图片
        } else {
            $imgurl = $img; // 签到图片
        }
        if (!$openid || $openid == 'undefined') {
            echo json_encode(array('status' => 2, 'err' => '请登录！'));
            exit;
        }

        // 根据微信id,查询用户id,用户积分
        $sql = "select user_id from lkt_user where wx_id = '$openid'";
        $rr = $db->select($sql);
        if ($rr) {
            $user_id = $rr[0]->user_id;


            $time_start = date("Y-m-d H:i:s", mktime(0, 0, 0, date('m'), date('d'), date('Y'))); // 当前时间
            // 根据用户id、签到时间大于当天开始时间,查询签到记录
            $sql = "select * from lkt_sign_record where user_id = '$user_id' and sign_time >= '$time_start' and type = 0";
            $r_sign = $db->select($sql);
            $sign_status = 1;
            if ($r_sign) {
                $sign_status = 0; // 有数据,代表当天签名了,不用弹出签名框
            }

            // 查询正在进行的签到活动
            $sql = "select * from lkt_sign_activity where status = 1";
            $rrr = $db->select($sql);

            if ($rrr) {
                $starttime = date("Ymd", strtotime($rrr[0]->starttime)); // 开始时间
                $endtime = date("Ymd", strtotime($rrr[0]->endtime)); // 结束时间
                $details = $rrr[0]->detail;

                $day = $endtime - $starttime; // 活动天数
                //------------------
                $start_1 = date("Y-m-d 00:00:00", strtotime("-1 day")); // 昨天开始时间
                $end_1 = date("Y-m-d 23:59:59", strtotime("-1 day")); // 昨天结束时间
                $num = 0;
                // 根据用户id, 查询昨天签到记录
                $sql = "select * from lkt_sign_record where user_id = '$user_id' and sign_time > '$start_1' and sign_time < '$end_1' and type = 0";
                $rrrr = $db->select($sql);
                if ($rrrr) { // 有数据,就循环查询连续签到几天
                    for ($i = 1; $i <= $day; $i++) {
                        $start = date("Y-m-d 00:00:00", strtotime("-$i day"));
                        $end = date("Y-m-d 23:59:59", strtotime("-$i day"));

                        $sql = "select * from lkt_sign_record where user_id = '$user_id' and sign_time > '$start' and sign_time < '$end' and type = 0";
                        $r_num = $db->select($sql);
                        if (empty($r_num)) {
                            $num = $i - 1;
                            break;
                        }
                    }
                }


                $y_time = date('Y', strtotime(date("Y-m-d"))); // 本年年份
                $m_time = date('m', strtotime(date("Y-m-d"))); // 本月月份
                if ($m_time < 10) {
                    $m_time = str_replace("0", "", $m_time);
                }
                if ($year > $y_time || $month > $m_time) {
                    echo json_encode(array('status' => 1, 'sign_time' => '', 'imgurl' => $imgurl, 'num' => $num, 'details' => $details));
                    exit;
                }
                $time1 = date('Y-m', time());

                $sign_time = [];
                $sql = "select sign_time from lkt_sign_record where user_id = '$user_id' and sign_time like '$time1%' and type = 0";
                $r_2 = $db->select($sql);
                if ($r_2) {
                    foreach ($r_2 as $k => $v) {
                        $y = date("Y", strtotime($v->sign_time));
                        $m = date("m", strtotime($v->sign_time));
                        $d = date("d", strtotime($v->sign_time));
                        if ($m < 10) {
                            $m = str_replace("0", "", $m);
                        }
                        if ($d < 10) {
                            $d = str_replace("0", "", $d);
                        }
                        $sign_time[$k] = $y . $m . $d;
                    }
                    echo json_encode(array('status' => 1, 'sign_status' => $sign_status, 'sign_time' => $sign_time, 'imgurl' => $imgurl, 'num' => $num, 'details' => $details));
                    exit;
                } else {
                    echo json_encode(array('status' => 0, 'sign_status' => $sign_status, 'sign_time' => $sign_time, 'err' => '暂无签到记录！', 'num' => 0, 'details' => $details));
                    exit;
                }
            } else {
                echo json_encode(array('status' => 2, 'err' => '活动已结束！'));
                exit;
            }
        } else {
            echo json_encode(array('status' => 0, 'err' => '系统繁忙！'));
            exit;
        }
    }

    // 进入积分页面
    public function integral()
    {
        $db = DBAction::getInstance();
        $request = $this->getContext()->getRequest();
        $openid = addslashes(trim($request->getParameter('openid'))); // 微信id


        $appConfig = $this->getAppInfo();
        $img = $appConfig['imageRootUrl'];
        $logo = $img . $appConfig['logo'];

        // 根据微信id,查询用户id、积分
        $sql = "select user_id,score from lkt_user where wx_id = '$openid'";
        $r_2 = $db->select($sql);
        if ($r_2) {
            $user_id = $r_2[0]->user_id; // 用户id
            $score = $r_2[0]->score; // 用户积分
            $sql01 = "select sign_score,sign_time,type from lkt_sign_record where user_id = '$user_id' order by sign_time desc";
            $list_1 = $db->select($sql01);
            $r_3 = [];
            if ($list_1) {
                foreach ($list_1 as $k => $v) {
                    if ($v->type == 0 || $v->type == 2 || $v->type == 4 || $v->type == 6 || $v->type == 7) {
                        $v->sign_time = date("Y-m-d", strtotime($v->sign_time));
                        $r_3[] = $v;
                    }
                }
            }
            $r_4 = [];
            if ($list_1) {
                foreach ($list_1 as $k => $v) {
                    if ($v->type == 1 || $v->type == 3 || $v->type == 5) {
                        $v->sign_time = date("Y-m-d", strtotime($v->sign_time));
                        $r_4[] = $v;
                    }
                }
            }
            $sql01 = "select switch from lkt_software_jifen where id = 1 ";
            $r01 = $db->select($sql01);
            $switch = $r01[0]->switch;

            $sql = "select * from lkt_software_jifen where id = 1";
            $rules = $db->select($sql);
            $rule = $rules[0]->rule;

            echo json_encode(array('status' => 1, 'logo' => $logo, 'rule' => $rule, 'score' => $score, 'sign' => $r_3, 'consumption' => $r_4, 'switch' => $switch));
            exit;
        } else {
            echo json_encode(array('status' => 0, 'err' => '系统繁忙！'));
            exit;
        }
    }

    public function transfer_jifen()
    {
        $db = DBAction::getInstance();
        $user_id = addslashes($_POST['user_id']);
        $openid = addslashes($_POST['openid']);
        $jifen = addslashes($_POST['jifen']);
        $date_time = date('Y-m-d H:i:s', time());
        if ($jifen <= 0 || $jifen == '') {
            echo json_encode(array('status' => 1, 'err' => '正确填写转账金额'));
            exit();
        } else {
            $sql001 = "select user_id,money from lkt_user where wx_id = '$openid'";
            $r001 = $db->select($sql001);//本人
            if ($r001) {
                $user_id001 = $r001[0]->user_id;
                $sql01 = "update lkt_user set score = score - '$jifen'  where wx_id = '$openid'";
                $r01 = $db->update($sql01);//本人
                $sql02 = "update lkt_user set score = score + '$jifen'  where user_id = '$user_id'";
                $r02 = $db->update($sql02);//好友
                $sql0001 = "insert into lkt_sign_record (user_id,sign_score,record,sign_time,type) values ('$user_id001','$jifen','转积分给好友','$date_time','3')"; //本人
                $db->insert($sql0001);
                $sql0002 = "insert into lkt_sign_record (user_id,sign_score,record,sign_time,type) values ('$user_id','$jifen','好友转积分','$date_time','4')";//好友
                $db->insert($sql0002);
                if ($r01 > 0 && $r02 > 0) {
                    echo json_encode(array('status' => 1, 'err' => '转账成功！'));
                    exit();
                } else {
                    echo json_encode(array('status' => 0, 'err' => '转账失败！'));
                    exit();
                }
            } else {
                echo json_encode(array('status' => 0, 'err' => '系统繁忙！'));
                exit;
            }
        }
    }
}

?>