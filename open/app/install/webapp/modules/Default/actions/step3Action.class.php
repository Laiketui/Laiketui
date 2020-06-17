<?php
/**
 * [Laike System] Copyright (c) 2017-2020 laiketui.com
 * Laike is not a free software, it under the license terms, visited http://www.laiketui.com/ for more details.
 */

define('WEB_PATH', str_replace('\\', "/", substr(dirname(__FILE__), 0, strrpos(dirname(__FILE__), 'install'))));

class step3Action extends Action
{

    public function execute()
    {

        $request = $this->getContext()->getRequest();
        $admin = $request->getParameter('admin');
        $db = $request->getParameter('db');
        $step = $this->getContext()->getStorage()->read('step');

        if ($step == 2) {
            header("Content-type: text/html;charset=utf-8");
            echo "<script language='javascript'>" . "alert('环境检测没有通过，请调整环境后重试！');" . "location.href='index.php?action=step2';</script>";
            return;

        } else {
            if (!is_array($admin) || empty($admin[0]) || empty($admin[1]) || empty($admin[3])) {
                header("Content-type: text/html;charset=utf-8");
                echo "<script language='javascript'>" . "alert('请填写完整管理员信息！');" . "location.href='index.php?action=step2';</script>";
                return;
            } else if ($admin[1] != $admin[2]) {
                header("Content-type: text/html;charset=utf-8");
                echo "<script language='javascript'>" . "alert('确认密码和密码不一致!');" . "location.href='index.php?action=step2';</script>";
                return;
            } else {
                $info = (array)$admin;
                list($info['username'], $info['password'], $info['repassword'], $info['email']) = $admin;
                $this->getContext()->getStorage()->write('admin_info', $info);
            }

            if (!is_array($db) || empty($db[0]) || empty($db[1]) || empty($db[2]) || empty($db[3])) {

                header("Content-type: text/html;charset=utf-8");
                echo "<script language='javascript'>" . "alert('请填写完整的数据库配置!');" . "location.href='index.php?action=step2';</script>";
                return;

            } else {

                $DB = (array)$db;
                list($DB['type'], $DB['hostname'], $DB['database'], $DB['username'], $DB['password'], $DB['hostport'], $DB['prefix']) = $db;
                $DB['params']["\PDO::ATTR_PERSISTENT "] = TRUE;
                $DB['params']["\PDO::ATTR_CASE "] = \PDO::CASE_LOWER;
                $this->getContext()->getStorage()->write('db_config', $DB);
                $dbname = $DB['database'];
                unset($db);

            }

        }

        $url = 'index.php';

        $request->setAttribute("url", $url);
        //第一步创建数据库配置文件
        $res_one = $this->create_database_tab();
        //连接数据库
        $db = $this->DB($DB['hostname'], $DB['username'], $DB['password'], $DB['hostport']);
        //检测mysql版本
        $mysql_server_info = $db->server_info;
        $mysql_version = substr($mysql_server_info, 0, strrpos($mysql_server_info, "."));

        if ($mysql_version < 5.5) {
            $_SESSION['install_error'] = true;
            header("Content-type: text/html;charset=utf-8");
            echo "<script language='javascript'>alert('您的mysql版本低于5.5，请调整环境后重试！');location.href='index.php?action=step2';</script>";
            return;
            exit;
        }

        //第二步创建数据库
        $this->create_database($DB['database'], $db);
        //第三步创建数据表
        $this->create_db_tables($DB['prefix'], $db, $DB['database']);
        //最后添加管理员
        $this->insert_member($db, $DB['prefix'], $info);
        $_SESSION['install_step'] = '3';

        return View::INPUT;

    }

    public function getDefaultView()
    {
        $request = $this->getContext()->getRequest();
        $admin = $request->getParameter('admin');
        if (!is_array($admin) || empty($admin[0]) || empty($admin[1]) || empty($admin[3])) {

            header("Content-type: text/html;charset=utf-8");
            echo "<script language='javascript'>" . "alert('请填写完整管理员信息！');" . "location.href='index.php?action=step2';</script>";
            return;

        }
        return View::INPUT;

    }

    public function getRequestMethods()
    {
        return Request::POST;

    }

    public function test()
    {

        $request = $this->getContext()->getRequest();
        // 获取输入的用户名
        $servername = trim(strtolower($request->getParameter("localhost")));
        $username = trim(strtolower($request->getParameter("user")));
        $password = trim(strtolower($request->getParameter("password")));
        $db = new mysqli($servername, $username, $password);
        if ($db->connect_error) {
            echo 0;
        } else {
            echo 1;
        }
        exit;
    }

    function show_log($msg, $class = '')
    {

        echo "<script type='text/javascript'>show_log('$msg', '$class')</script>";
        @flush();
        @ob_flush();
    }

    public function DB($servername, $username, $password, $hostport)
    {
        if ($hostport != '3306') {
            $servername = $servername . ":" . $hostport;
        }
        $db = new mysqli($servername, $username, $password);
        if ($db->connect_error) {
            header("Content-type: text/html;charset=utf-8");
            echo "<script language='javascript'>" . "alert('数据库连接失败，有可能密码错误或者数据库没有访问权限!');" . "location.href='index.php?action=step2';</script>";
            return;
            exit;
        } else {
            return $db;
        }

    }

    //第一步创建数据库配置文件

    function create_database_tab()
    {

        $db_config = $this->getContext()->getStorage()->read('db_config');

        if (is_array($db_config)) {
            //读取配置内容
            unset($db_config['params']);
            $conf = file_get_contents(WEB_PATH . 'data/database.tpl');
            //替换配置项
            foreach ($db_config as $name => $value) {
                $conf = str_replace("[{$name}]", $value, $conf);
            }

            //创建数据库连接文件
            if (file_put_contents(WEB_PATH . 'LKT/webapp/config/db_config.php', $conf)) {
                file_put_contents(WEB_PATH . 'install/webapp/config/db_config.php', $conf);
                return true;
            } else {
                $type = true;
                $_SESSION['install_error'] = $type;
            }

        } else {

            return false;

        }

    }

    //第二步创建数据库

    public function create_database($database, $db)
    {

        $conn = $db;
        // 检测连接
        if ($conn->connect_error) {
            die("连接失败: " . $conn->connect_error);
        }
        $sql = "CREATE DATABASE `$database` CHARACTER SET utf8 COLLATE utf8_general_ci ";
        $r = $conn->query($sql);
        $conn->query("set names utf8");
        if ($r) {
            return true;
        } else {
            $sqp_drop = "DROP database $database;";
            $_drop = $conn->query($sqp_drop);
            $rrr = $conn->query($sql);
            return $rrr;
        }

    }

    function create_db_tables($prefix = '', $db, $database)
    {

        //读取SQL文件
        $sql_use = "use $database";
        $db->query($sql_use);
        $this->show_log(WEB_PATH . 'data/install.sql');
        $sql = file_get_contents(WEB_PATH . 'data/install.sql');
        $sql = str_replace("\r", "\n", $sql);
        $sql = explode(";\n", $sql);
        $orginal = "lkt_";
        $sql = str_replace(" `{$orginal}", " `{$prefix}", $sql);
        $tables_num = 0;

        //开始安装
        $this->show_log('开始安装数据库...');
        foreach ($sql as $value) {
            $value = trim($value);
            if (empty($value))
                continue;
            if (substr($value, 0, 12) == 'CREATE TABLE') {
                $name = preg_replace("/^CREATE TABLE `(\w+)` .*/s", "\\1", $value);
                $tables_num++;
                $msg = "创建数据表{$name}";

                if (false !== $db->query($value)) {
                    $this->show_log($msg . '...成功');
                } else {
                    $this->show_log($value . '...失败！');
                }

            } else {
                $db->query($value);
            }

        }

        //查询表的数量
        $sql = "select count(*) as num from information_schema.tables where table_schema='$database'";
        $obj = mysqli_query($db, $sql);
        $database_tn = 0;
        while ($row = mysqli_fetch_assoc($obj)) {
            $database_tn = $row['num'];
        }

        if ($database_tn != $tables_num) {
            header("Content-type: text/html;charset=utf-8");
            echo "<script language='javascript'>" . "alert('创建数据失败!');" . "location.href='index.php?action=step2';</script>";
            return;
            exit;
        }

    }

    function insert_member($db, $prefix, $admin)
    {

        $password = md5($admin['password']);
        $sql = "INSERT INTO `lkt_admin` (`id`, `sid`, `name`, `password`, `admin_type`, `permission`, `role`, `status`, `add_date`, `recycle`, `nickname`, `birthday`, `sex`, `tel`, `token`, `ip`) VALUES ('1', '0', '{$admin['username']}', '{$password}', '1', NULL, '1', NULL, '2018-09-25 16:55:26', '0', 'lkt', '1936-2-1', '2', '86453408', '', '127.0.0.1')";
        //执行sql
        $db->query($sql);
        $request = $this->getContext()->getRequest();
        $url = $request->getParameter('url');
        $domain = $url . '/LKT/index.php?module=api';
        $uploadImg_domain = $url;
        $sql = "update `{$prefix}config` set domain = '$domain', uploadImg_domain = '$uploadImg_domain',modify_date = CURRENT_TIMESTAMP where id = '1'";
        $db->query($sql);

    }

}

?>