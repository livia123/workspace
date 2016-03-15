<%@ page language="java" import="java.util.*,com.pm.pojo.*,com.commons.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="xuqing29@chinaunicom.cn">

    <title>任务管理和价值量考核系统</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="css/dashboard.css" rel="stylesheet">
    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://cdn.bootcss.com/html5shiv/3.7.0/html5shiv.min.js"></script>
    <![endif]-->
   </head>

<body>

<div class="modal fade bs-example-modal" id="exampleModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog " role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel2">分配成果</h4>
            </div>
            <div class="modal-body">

                <form  method="post" role="form" class="contactForm" action="addResultTeam" id="addResultTeam">
                    <h5>该成果可供分配的价值量为<span id="workAll"></span>人月，请全部分完</h5>
                    <ul class="unstyled" id="demo5"></ul>
                    <a href="#">+ 新增</a>
 
						<input type="hidden"  name="resultid"  />
						
						
				<div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="submit" class="btn btn-primary" data-dismiss="modal" onclick="addResultTeam.submit();">提交</button>

            </div>		
                </form>

            </div>

            
        </div>
    </div>
</div>

<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand whitefont" href="#"><img class="inlogo" src="images/logo3.png"/>&nbsp;任务管理和价值量考核系统</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <%@ include file ="adminheader.jsp" %> 
            </ul>


        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <ul class="nav nav-sidebar">
                <%@ include file ="alist.jsp" %> 
            </ul>


        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="whiteback">
                <div class="sub-header"><span class="sub-header-title teamachi">团队成果</span></div>
                <div class="table-responsive">
                    <table class="table" id="table1">
                        <thead>
                        <tr>
                            <th>成果名称</th>
                            <th>成果类型</th>
                            <th>等效价值量</th>
                            <th>作者</th>
                            <th>季度</th>
                        </tr>
                        </thead>
                        <tbody> 
                        <%
  	List<Result> results = (List<Result>)request.getAttribute("results");
  	List<Result> resultnots = (List<Result>)request.getAttribute("resultnots");
  	if(results!=null){
		for(Result t:results){
			%><tr>
			 <td><%=t.getName() %></td>
                  <td><%=t.getType() %></td> 
                  <td><%=t.getWork()%></td> 
                  <td><%=t.getAuthor() %></td>
                  <td><%=t.getQuarter() %></td> 
                 
                </tr> 
			<%
		}
		 
  	}   	
  	 %>
                        </tbody>
                    </table>
                </div>
            </div>
<% 
  	if(resultnots!=null){%>
            <div class="whiteback">
                <div class="sub-header"><span class="sub-header-title teamachi">待分配成果</span></div>
                <div class="table-responsive">
                    <table class="table" id="table2">
                        <thead>
                        <tr>
                            <th>成果名称</th>
                            <th>成果类型</th>
                            <th>等效价值量</th>
                            <th>作者</th>
                            <th>季度</th>
                            <th>操作</th>

                        </tr>
                        </thead>
                        <tbody>
              <%          
		for(Result t:resultnots){
			%><tr>
			 <td><%=t.getName() %></td>
                  <td><%=t.getType() %></td> 
                  <td><%=t.getWork()%></td> 
                  <td><%=t.getAuthor() %></td>
                  <td><%=t.getQuarter() %></td> 
                   <td style="display:none"><%=t.getId() %></td>
                  <td><a href="#" data-toggle="modal" data-target="#exampleModal2" data-whatever="1111" class="touser">分配成果</a></td>
                      
                </tr> 
			<%
		}
		 
  	%>

                        </tbody>
                    </table>
                </div>
            </div>
            <%
}
  	
  	   String tms = (String)request.getAttribute("tms");	
  	   
  	   
  	    
  	 %> 
        </div>
    </div>
</div>
<script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script> 
 
     <script src="js/bootstrap.min.js"></script>
<script>
 var jsonStr;
 var obj ;
 var obj2;
$(document).ready(function() {
  jsonStr = '<%=tms%>'; 
   obj = JSON.parse(jsonStr);
   obj2 = eval('(' + jsonStr + ')'); 
 })
    $('#exampleModal2').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // Button that triggered the modal
        var recipient = button.data('whatever') // Extract info from data-* attributes
        // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
        // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
        
         var resultid=button.parents("tr").children("td").eq(5).text();
         var work=button.parents("tr").children("td").eq(2).text();
        
            $("input[name=resultid]").val(resultid);
             $("#workAll").html(work);
          
        var modal = $(this)
        //modal.find('.modal-title').text(recipient)
        //modal.find('.modal-body input').val(recipient)
    });


    $(function(){
        $("#demo5").easyinsert({
            name: ["demo5", "work", "demo5", "teamid"],
            type: ["custom", "text", "custom", "select"],
            value: ["<strong style=\"color:#ff7b0e; margin-right:20px;\">价值量</strong>", "请填写数字", "<strong style=\"color:#ff7b0e; margin-left:20px;\">团队：</strong>", obj2],
            initValue: [
                ["<strong style=\"color:#ff7b0e;margin-right:20px;\">价值量</strong>", "请填写数字", "<strong style=\"color:#ff7b0e; margin-left:20px;\">团队：</strong>", obj2]
            ]
        });
    });
    /**
     * EasyInsert 4.0
     *
     **/
    ;(function($){
        $.fn.extend({
            "easyinsert": function(o){
                o = $.extend({
                    //触发器
                    clicker: null,//根据class（或id）选择，默认.next()获取
                    //父标签
                    wrap: "li",
                    name: "i-text",
                    type: "text",
                    value: "",
                    maxlength: 20,
                    className: "i-text",
                    //新增上限值
                    toplimit: 0,//0表示不限制
                    //初始化值，二维数组
                    initValue: null//用于修改某资料时显示已有的数据
                }, o || {});
                var oo = {
                    remove: "<a href=\"#nogo\" class=\"remove\">移除</a>",
                    error1: "参数配置错误，数组的长度不一致，请检查。",
                    error2: "参数配置错误，每组初始化值都必须是数组，请检查。"
                }
                //容器
                var $container = $(this);
                var allowed = true;
                //把属性拼成数组（这步不知道是否可以优化？）
                var arrCfg = new Array(o.name, o.type, o.value, o.maxlength, o.className);
                //arr ==> [name, type, value, maxlength, className]
                var arr = new Array();
                $.each(arrCfg, function(i, n){
                    if ( $.isArray(n) ) {
                        arr[i] = n;
                    } else {
                        arr[i] = new Array();
                        if ( i === 0 ) {
                            arr[0].push(n);
                        }else{
                            //补全各属性数组（根据name数组长度）
                            $.each(arr[0], function() {
                                arr[i].push(n);
                            });
                        }
                    }
                    //判断各属性数组的长度是否一致
                    if ( arr[i].length !== arr[0].length ) {
                        allowed = false;
                        $container.text(oo.error1);
                    }
                });
                if ( allowed ) {
                    //获取触发器
                    var $Clicker = !o.clicker ? $container.next() : $(o.clicker);
                    $Clicker.bind("click", function() {
                        //未添加前的组数
                        var len = $container.children(o.wrap).length;
                        //定义一个变量，判断是否已经达到上限
                        var isMax = o.toplimit === 0 ? false : (len < o.toplimit ? false : true);
                        if ( !isMax ) {//没有达到上限才允许添加
                            var $Item = $("<"+ o.wrap +">").appendTo( $container );
                            $.each(arr[0], function(i) {
                                switch ( arr[1][i] ) {
                                    case "select"://下拉框
                                        var option = "";
                                        $.each(arr[2][i], function(i, n) {
                                            option += "<option value='"+ n +"'>"+ i +"</option>";
                                        });
                                        $("<select>", {
                                            name: arr[0][i],
                                            className: arr[4][i]
                                        }).append( option ).appendTo( $Item );
                                        break;
                                    case "custom"://自定义内容，支持html
                                        $Item.append( arr[2][i] );
                                        break;
                                    default://默认是input
                                        $("<input>", {//jQuery1.4新增方法
                                            name: arr[0][i],
                                            type: arr[1][i],
                                            value: arr[2][i],
                                            maxlength: arr[3][i],
                                            className: arr[4][i]
                                        }).appendTo( $Item );
                                }
                            });
                            $Item = $container.children(o.wrap);
                            //新组数
                            len = $Item.length;
                            if ( len > 1 ) {
                                $Item.last().append(oo.remove);
                                if ( len === 2 ) {//超过一组时，为第一组添加“移除”按钮
                                    $Item.first().append(oo.remove);
                                }
                            }
                            $Item.find(".remove").click(function(){
                                //移除本组
                                $(this).parent().remove();
                                //统计剩下的组数
                                len = $container.children(o.wrap).length;
                                if ( len === 1 ) {//只剩一个的时候，把“移除”按钮干掉
                                    $container.find(".remove").remove();
                                }
                                //取消“移除”按钮的默认动作
                                return false;
                            });
                        }
                        //取消触发器的默认动作
                        return false;
                    });
                    //初始化
                    if ( $.isArray(o.initValue) ) {//判断初始值是否是数组（必需的）
                        $.each(o.initValue, function(i, n) {
                            if ( !$.isArray(n) ) {
                                $container.empty().text(oo.error2);
                                return false;
                            }else{
                                if ( n.length !== arr[0].length ) {
                                    $container.empty().text(oo.error1);
                                    return false;
                                }
                            }
                            var arrValue = new Array();
                            //初始值替换默认值
                            $.each(n, function(j, m) {
                                arrValue[j] = arr[2][j]
                                arr[2][j] = m;
                            });
                            $Clicker.click();
                            //默认值替换初始值
                            $.each(arrValue, function(j, m) {
                                arr[2][j] = m;
                            });
                            //上面这种[移形换位法]不知道效率怎么样，我想不出别的更好的方法
                        });
                    }else{
                        $Clicker.click();
                    }
                }
            }
        });
    })(jQuery);

</script>

</body>
</html>
