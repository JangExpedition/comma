<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div id="anonymousChat" class="fontStyle"><h1> 익명 채팅방</h1></div>


<script>
var test_type = 0;

/*
 * type
 *      0 : mytalk
 *      1 : othertalk
 */
 
function jstalktheme_addmsg(type, name, time, msg)
{
	var ocontainer = document.getElementById("jstalktheme_test");
	var ocontainer_msg = ocontainer.getElementsByClassName("msg")[0];
	
	var onewmsg = document.createElement("div");
	var onewblank = document.createElement("div");
	
	if(type)
	{
		onewmsg.className="othertalk";
		onewmsg.innerHTML = 
		"<div class=\"profile_image\" style=\"background: url(./profile_image.png) no-repeat;\">\n"+
		"</div>\n"+
		"<div class=\"box\">\n"+
		"<div class=\"profile_name\">\n"+
		name+"\n"+
		"</div>\n"+
		"<div class=\"a\">\n"+
		"</div>\n"+
		"<div class=\"b\">\n"+
		msg+"\n"+
		"</div>\n" +
		"<div class=\"time\">\n"+
		time+"\n"+
		"</div>\n"+
		"</div>\n";
	}else{
		onewmsg.className="mytalk";
		onewmsg.innerHTML = 
		"<div class=\"b\">\n"+
		"</div>\n"+
		"<div class=\"a\">\n"+
		msg+"\n"+
		"</div>\n"+
		"<div class=\"time\">\n"+
		time+"\n"+
		"</div>\n" +
		"";
	}
	
	onewmsg.innerHTML +=
    "<div class=\"clear\">\n"+
    "</div>";
	
	onewblank.className="blank";
	
	ocontainer_msg.appendChild(onewmsg);
	ocontainer_msg.appendChild(onewblank);
	
	ocontainer_msg.scrollTop = ocontainer_msg.scrollHeight;
}


function jstalktheme_testfunc()
{
	var otxtmsg = document.getElementById("jstalktheme_testmsg");
	
	var d = new Date();
	var ampm = (d.getHours()>12 ?  "PM" : "AM");
	var h = (d.getHours()>12 ? d.getHours()-12 : d.getHours());
	var m = d.getMinutes();

	test_type ^= 0x01;
	jstalktheme_addmsg(test_type, "익명", ampm+" "+h+":"+m, otxtmsg.value.replace("\n","<br />\n"));
}

</script>
</head>

<body>
<div class="jstalktheme" id="jstalktheme_test" style="width: 320px; height: 480px;">

<div class="msg">
</div>

<div class="sendmsg">
    <textarea class="textarea" id="jstalktheme_testmsg" onkeypress="if(event.keyCode==13){ jstalktheme_testfunc(); this.value=''; return false; }else if(event.keyCode==10){ this.value+='\n'; }"></textarea>
    <div class="button" onclick="jstalktheme_testfunc()">
 	   <p>전송</p>
    </div>
    <div class="clear">
    </div>
</div>
</div>

</body>
</html>

