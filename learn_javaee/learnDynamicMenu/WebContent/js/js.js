//XMLHttpRequest组件
var xhs;
//区域菜单的值发生改变时调用该方法,并把区域菜单当前的value传递进来
function cascade(id){
    //当id不大于0时，说明当前选择的是“请选择”这一项，则不做操作
    if(id>0){
        //请求字符串,把区域的id作为页面参数传到后台
        var url="cascade?id="+id;
        //创建XMLHttpRequest组件
        xhs=new XMLHttpRequest();
        //设置回调函数,processReuqest方法的定义在下面
        xhs.onreadystatechange=processReuqest;
        //打开与服务器的地址连接
        xhs.open("post", url, true);
        //发送请求
        xhs.send(null);
    }
}

//processReuqest方法作为回调方法
function processReuqest(){
    if(xhs.readyState==4){
        if(xhs.status==200){
            //创建新的select节点
            var newSelect=document.createElement("select");
            newSelect.id="street";
            //为新创建的select节点添加onchange事件，以便测试用
            newSelect.onchange=function test(){
                alert(this.value);
            };
            //为新创建的select节点添加option节点
            var op=document.createElement("option");
            op.value=-1;
            op.innerHTML="请选择";
            newSelect.appendChild(op);
            //得到完成请求后返回的字串符
            var str = xhs.responseText;
            //根据返回的字符串为新创建的select节点添加option节点
            var arr1=str.split(",");
            for(var i=0;i<arr1.length;i++){
                var arr2=arr1[i].split("=");
                var child=document.createElement("option");
                child.innerHTML=arr2[1];
                child.value=arr2[0];
                newSelect.appendChild(child);
            }
            //用新select节点替换旧的select节点
            var select = document.getElementById("street");
            document.body.replaceChild(newSelect, select);
        }
    }
}
