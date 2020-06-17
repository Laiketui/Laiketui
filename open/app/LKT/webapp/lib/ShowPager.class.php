<?php
//分页类
class showPager {
    public $total_record; //记录总数
    public $pagesize; //每一页显示的记录数
    public $total_pages; //总页数
    public $cur_page; //当前页码
    public $offset; //记录偏移量
    public $_pernum = 10; //页码偏移量，这里可随意更改


    public function __construct($total, $pagesize, $cur_page) {
        $this->total_record = intval($total);
        $this->pagesize = intval($pagesize);
        $this->cur_page = intval($cur_page);
        $this->_count();
    }

    private function _count() //计算
    {
        if($this->total_record <= 0 || $this->pagesize <= 0){
            $this->total_record = 0;
            $this->pagesize = 0;
            $this->total_pages = 0;
            $this->cur_page = 0;
            $this->offset = 0;
            return;
        }
        $this->total_pages = ceil($this->total_record / $this->pagesize);
        if($this->cur_page < 1 || $this->cur_page > $this->total_pages ){
            $this->cur_page = 1;
        }
        $this->offset = ($this->cur_page - 1) * $this->pagesize;
    }

    //html数字连接的标签
    public function num_link($url) {
        if($this->total_pages == 0){
            return '';
        }
        if($this->total_pages == 1){
            return '';
        }
        $start = floor(($this->cur_page - 1) / $this->_pernum) * $this->_pernum + 1;
        $end = $start + $this->_pernum;
        $text[] = '共有 ' . $this->total_record . '条记录 | 当前' .$this->cur_page."/". $this->total_pages . '页';
        if($this->total_pages > $this->_pernum){
            if( $this->cur_page != 1){
                $text[] = "[<a class='page'  href='index.php?{$url}&page=1'>首页</a>]";
            } else {
                $text[] = '[<a>首页</a>]';
            }
            $up = $start - $this->_pernum;
            if( $up > 0 ){
                $text[] = "[<a class='page' href='index.php?{$url}&page=$up'>←</a>]";
            } else {
                $text[] = '[<a>←</a>]';
            }
        }
        for($i = $start;$i<$end&&$i<=$this->total_pages;$i++){
            if($i != $this->cur_page){
                $text[] = "<a class='page' href='index.php?{$url}&page=$i'>$i</a>";
            } else {
                $text[] = "<a><strong>$i</strong></a>";
            }

        }
        if($this->total_pages > $this->_pernum){
            $down = $this->total_pages - $end;
            if($down >= 0){
                $text[] = "[<a class='page' href='index.php?{$url}&page=$end'>→</a>]";
            } else {
                $text[] = '[<a>→</a>]';
            }
            if($this->cur_page != $this->total_pages){
                $text[] = "[<a class='page' href='index.php?{$url}&page=" .
                    $this->total_pages . "'>尾页</a>]";
            } else {
                $text[] = '[<a>尾页</a>]';
            }
        }
        return implode(' ',$text);
    }

    /**
     * @param $maxpage  总页数
     * @param $page    当前页
     * @param string $para  翻页参数(不需要写$page),如http://www.example.com/article.php?page=3&id=1，$para参数就应该设为'&id=1'
     * @return string  返回的输出分页html内容
     */
    function multipage($url,$total, $page,$pagesize,$start, $para = '') {
        $maxpage = ceil($total/$pagesize);
        $end = $start+$pagesize;
        $start = $start+1;

        if($end >= $total){
            $end = $total;
        }
        $multipage = '';  //输出的分页内容
        $listnum = 5;     //同时显示的最多可点击页面
        if ($maxpage < 2) {
            return '';
        }else{
            $offset = 2;
            if ($maxpage <= $listnum) {
                $from = 1;
                $to = $maxpage;
            } else {
                $from = $page - $offset; //起始页
                $to = $from + $listnum - 1;  //终止页
                if($from < 1) {
                    $to = $page + 1 - $from;
                    $from = 1;
                    if($to - $from < $listnum) {
                        $to = $listnum;
                    }
                } elseif($to > $maxpage) {
                    $from = $maxpage - $listnum + 1;
                    $to = $maxpage;
                }
            }

            $multipage .= ($page - $offset > 1 && $maxpage >= $page ? "<li><a href='$url&page=1".$para."' >首页</a></li>" : '').
                ($page > 1 ? "<li><a style='width:80px' href='$url&page=".($page - 1).$para.'\' >上一页</a></li>' : '');
            for($i = $from; $i <= $to; $i++) {
                $multipage .= ($i == $page|| ($i == 1 && !$page)) ? "<li class='active'><a href='$url&page=".$i.$para.'\' >'.$i.'</a></li>' : "<li ><a href='$url&page=".$i.$para.'\' >'.$i. '</a></li>';
            }
            $page = $page==0?1:$page;
            $multipage .= ($page < $maxpage ? "<li><a style='width:80px' href='$url&page=".($page + 1).$para.'\' >下一页</a></li>' : '').
                ($to < $maxpage ? "<li><a href='$url&page=".$maxpage.$para.'\' class="last" >尾页</a></li>' : '');
                $multipage = $multipage ? '<div class="paginationDiv"> <div class="showDataNum">显示'.$start.'到'.$end.'，共'.$total.'条</div><ul class="pagination"><li class=""></li>'.$multipage.'<li></li></ul><div class="clearfix"></div></div>' : '';
        }

        return $multipage;
    }
}
?>