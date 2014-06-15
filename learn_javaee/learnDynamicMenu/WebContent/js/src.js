//XMLHttpRequest组件
var xhs;

function cascade(id){
    //当id不大于0时，说明当前选择的是“请选择”这一项，则不做操作
    if(id>0){
        // Preparing request
    	//请求字符串,把区域的id作为页面参数传到后台
        var url="cascade?id="+id;
        xhs=new XMLHttpRequest();
        // http://www.w3schools.com/Ajax/ajax_xmlhttprequest_onreadystatechange.asp
        //   The onreadystatechange event is triggered every time the readyState changes.
        xhs.onreadystatechange=processReuqest;
        xhs.open("post", url, true);
        xhs.send(null);
    }
}

function processReuqest(){
	// The readyState property holds the status of the XMLHttpRequest.
	// 
	//	readyState Holds the status of the XMLHttpRequest. Changes from 0 to 4: 
	//	0: request not initialized 
	//	1: server connection established
	//	2: request received 
	//	3: processing request 
	//	4: request finished and response is ready
	//
	//  status
	//  200: "OK"
	//  404: Page not found
	//
    if(xhs.readyState==4){
        if(xhs.status==200){ 
        	// Create <select> 
            var newSelect=document.createElement("select");
            newSelect.id="street";
            //为新创建的select节点添加onchange事件，以便测试用
            newSelect.onchange=function test(){
                alert(this.value);
            };
            // Create <option>
            var op=document.createElement("option");
            op.value=-1;
            op.innerHTML="请选择";
            newSelect.appendChild(op);
            
            // Parsing response
            var str = xhs.responseText;
            var arr1=str.split(",");
            for(var i=0;i<arr1.length;i++){
                var arr2=arr1[i].split("=");
                var child=document.createElement("option");
                child.innerHTML=arr2[1];
                child.value=arr2[0];
                newSelect.appendChild(child);
            }
            
            // 用新select节点替换旧的select节点
            var select = document.getElementById("street");
            document.body.replaceChild(newSelect, select);
        }
    }
}
