<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../includes/header.jsp" %>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board Read</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
           <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">Board Read Page</div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">    
                        	<div class="form-group">
                        	<label>Bno</label> 
                        	<input class="form-control" name='bno' value='<c:out value="${board.bno }"/>' readonly="readonly"> 
                        	</div>
                        
                          	<div class="form-group">
                        	<label>Title</label> 
                        	<input class="form-control" name='title' value='<c:out value="${board.title }"/>' readonly="readonly"> 
                        	</div>
                        	
                         	<div class="form-group">
                        	<label>Text area</label> 
                        	<textarea class="form-control" rows="3" name='content' readonly="readonly">
                        	<c:out value="${board.content }"/>
                        	</textarea>
                        	</div>  
                        	
                        	<div class="form-group">
                        	<label>Writer</label>
                        	<input class="form-control" name='writer' value='<c:out value="${board.writer }"/>' readonly="readonly">
                        	</div> 
                        	
                        	<sec:authentication property="principal" var="pinfo"/>
                        		<sec:authorize access="isAuthenticated()">
                        			<c:if test="${pinfo.username eq board.writer }">
                        			<button data-oper='modify' class="btn btn-default">Modify</button>
                        			</c:if>
                        		</sec:authorize>
                        	<button data-oper='list' class="btn btn-info">List</button>
	                        	
	            			<form id='operForm' action="/board/modify" method="get">
	            				<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno }"/>'>
	            				<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
	            				<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
	            				<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
	            				<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>	            					            				
                        	</form>
                        </div>
                        <!-- end panel-body -->
                     </div>  
                     <!-- end panel-body -->
                  </div>
                  <!-- end panel -->
                  </div>
<!-- file list start -->
	<div class="bigPictureWrapper">
		<div class="bigPicture"></div>
	</div>

	<style>
	.uploadResult{
		width: 100%;
		background-color: gray;
	}
	
	.uploadResult ul{
		display: flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	
	.uploadResult ul li{
		list-style: none;
		padding: 10px;
	}
	
	.uploadResult ul li img{
		width: 20px;
	}
	
	.bigPictureWrapper{
		position: absolute;
		display: none;
		justify-content: center;
		align-items: center;
		top:0%;
		width:100%;
		height:100%;
		background-color: gray;
		z-index: 100;
	}
	
	.bigPicture{
		position: relative;
		display:flex;
		justify-content: center;
		align-items: center;
	}
	
	.bigPicture img{
		width: 600px;
	}
	</style>
	

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			
			<div class="panel-heading">Files</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<div class='uploadResult'>
					<ul>
					
					</ul>
				</div>
				
			</div>
			<!-- end panel body -->
			
		</div>
		<!-- end panel-body -->
	</div>
	<!-- end panel -->
</div>   
<!-- /.row -->  
<!-- file list end -->

<div class='row'>
	<div class="col-lg-12">
	
		<!-- /.panel -->
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i>Reply
				<sec:authorize access="isAuthenticated()">
					<button id = 'addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
				</sec:authorize>				
			</div>
			
			<!-- /.panel-heading -->
			<div class="panel-body">
			
				<ul class="chat">
				</ul>
			</div>
			<div class="panel-footer"></div>
		</div>
	</div>
</div>

<!-- Reply modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="Modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>Reply</label>
					<input class="form-control" name='reply' value='New Reply!!!'>
				</div>
				<div class="form-group">
					<label>Replyer</label>
					<input class="form-control" name='replyer' value='replyer'>
				</div>
				<div class="form-group">
					<label>Reply Date</label>
					<input class="form-control" name='replyDate' value=''>
				</div>
				<div class="modal-footer">
					<button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
					<button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
					<button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
					<button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
				</div>
			</div>
		</div>
	</div>
</div>
    
<script type="text/javascript" src="/resources/js/reply.js"></script> 
<!-- 댓글 처리 자바스크립트 -->
<script type="text/javascript">
$(document).ready(function(){
	var bnoValue = '<c:out value="${board.bno}"/>';
	var replyUL = $(".chat");
	
	showList(1);
	
	function showList(page){
		console.log("show list" + page);
		
		replyService.getList({bno:bnoValue, page: page|| 1 }, function(replyCnt, list){
			console.log("replyCnt: "+replyCnt);
			console.log("list:"+list);		
			
			if(page == -1){
				pageNum = Math.ceil(replyCnt/10.0);
				showList(pageNum);
				return;
			}
			
			var str = "";
		
			if(list == null || list.length ==0){		
			return;
		}
		for (var i = 0, len = list.length || 0; i < len; i++) {
			str += "<li class='left clearfix' data-rno='"+list[i].rno+"'>";
			str += "	<div><div class='header'><strong class='primary-font'>["+list[i].rno+"] "+ list[i].replyer +"</strong>";
			str += "		<small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
			str += "		<p>"+list[i].reply+"</p></div></li>";
		}
		replyUL.html(str);
		
		showReplyPage(replyCnt);
		});
	}//end showList function
	
	var pageNum = 1;
	var replyPageFooter = $(".panel-footer");
	
	function showReplyPage(replyCnt){
		var endNum = Math.ceil(pageNum / 10.0) * 10;
		var startNum = endNum -9;
		
		var prev = startNum != 1;
		var next = false;
		
		if(endNum * 10 >= replyCnt){
			endNum = Math.ceil(replyCnt/10.0);
		}
		
		if(endNum * 10 < replyCnt){
			next = true;
		}
		
		var str = "<ul class='pagination pull-right'>";
		
		if(prev){
			str += "<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>Previous</a></li>";
		}
		
		for(var i = startNum ; i <= endNum; i++){
			var active = pageNum == i? "active":"";
			str += "<li class='page-item "+active+"'><a class='page-link' href='"+i+"'>"+i+"</a></li>";
		}
		
		if(next){
			str += "<li class='page-item'><a class='page-link' href='"+(endNum +1)+"'>Next</a></li>";
		}
		str += "</ul>";
		
		console.log(str);
		replyPageFooter.html(str);
	
	}
	
	//댓글 페이지 번호에 이벤트부여(클릭하면 화면 넘어가게)
	replyPageFooter.on("click","li a", function(e){
		e.preventDefault();
		
		var targetPageNum = $(this).attr("href");
		
		pageNum = targetPageNum;
		
		showList(pageNum);
	});
	
	var modal = $(".modal");
	var modalInputReply = modal.find("input[name='reply']");
	var modalInputReplyer = modal.find("input[name='replyer']");
	var modalInputReplyDate = modal.find("input[name='replyDate']");
	
	var modalModBtn = $("#modalModBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalRegisterBtn = $("#modalRegisterBtn");
	
	var replyer = null;
	
	<sec:authorize access="isAuthenticated()">
	replyer = '<sec:authentication property="principal.username"/>';
	</sec:authorize>
	
	var csrfHeaderName ="${_csrf.headerName}";
	var csrfTokenValue ="${_csrf.token}";
	
	//"close" 버튼 이벤트 처리 하기
	$("#modalCloseBtn").on("click", function(e){
		modal.modal('hide');
	});
	
	$("#addReplyBtn").on("click", function(e){
		modal.find("input").val("");
		modal.find("input[name='replyer']").val(replyer);
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id !='modalCloseBtn']").hide();
		
		modalRegisterBtn.show();
		$(".modal").modal("show");
	});//$("#addReplyBtn").on끝
	
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});

	modalRegisterBtn.on("click",function(e){
		var reply={
				reply : modalInputReply.val(),
				replyer : modalInputReplyer.val(),
				bno : bnoValue
		};
		replyService.add(reply, function(result){
			alert(result);
			
			modal.find("input").val("");
			modal.find("hide");
			
			showList(-1);
		});
	});//modalRegisterBtn.on끝
	
	$(".chat").on("click","li",function(e){
		var rno = $(this).data("rno");
		
		replyService.get(rno, function(reply){
			modalInputReply.val(reply.reply);
			modalInputReplyer.val(reply.replyer);
			modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly","readonly");
			modal.data("rno", reply.rno);
			
			modal.find("button[id != 'modalCloseBtn']").hide();
			modalModBtn.show();
			modalRemoveBtn.show();
			
			$(".modal").modal("show");
		});
	});//$(".chat").on 끝
	
	modalModBtn.on("click", function(e){
		var originalReplyer = modalInputReplyer.val();
		var reply = {rno:modal.data("rno"), 
					reply: modalInputReply.val(), 
					replyer: originalReplyer};
		
		if(!replyer){
			alert("로그인한 후 수정이 가능합니다.");
			modal.modal("hide");
			return;
		}
		
		console.log("Original Replyer: " + originalReplyer);
		
		if(replyer != originalReplyer){
			alert("자신이 작성한 댓글만 수정이 가능합니다.");
			modal.modal("hide");
			return;
		}
		
		replyService.update(reply, function(result){
			
			alert(result);
			modal.modal("hide");
			showList(pageNum);
		});
	});//modalModBtn.on 끝
	
	modalRemoveBtn.on("click", function(e){
		var rno = modal.data("rno");
		
		if(!replyer){
			alert("로그인한 후 삭제가 가능합니다.");
			modal.modal("hide");
			return;
		}
		var originalReplyer = modalInputReplyer.val();
		
		if(replyer != originalReplyer){
			alert("자신이 작성한 댓글만 삭제가 가능합니다.");
			modal.modal("hide");
			return;
		}
		
		replyService.remove(rno, originalReplyer, function(result){
			
			alert(result);
			modal.modal("hide");
			showList(pageNum);
		});
	});//modalRemoveBtn.on 끝
	
});//$(document).ready 전체의 끝

	/*<<<이 주석들은 실습기록 지우지 않음>>>
	console.log("============");
	console.log("JS TESt");
	
	 var bnoValue = '<c:out value="${board.bno}"/>';
	
	 replyService.add(
			{reply:"JS Test", replyer:"tester", bno:bnoValue}
			,
			function(result){
				alert("Result:" + result);
			}); 
	
	 replyService.getList({bno:bnoValue, page:1}, function(list){
		for(var i = 0, len = list.length||0; i < len; i++){
			console.log(list[i]);
		}
	}); 
	
	replyService.remove(12, function(count){
		console.log(count);
		
		if(count === "success"){
			alert("Removed");
		}
	}, function(err){
		alert('ERROR...');
	}); 
	
	replyService.update({
		rno : 5,
		bno : bnoValue,
		reply : "Modified Reply..."
	}, function(result){
		alert("수정 완료...");
	});
	
	replyService.get(10, function(data){
		console.log(data);
	}); <<<이 주석들은 실습을 위해 지우지 않음>>>*/ 

</script>
<!-- 댓글 처리 자바스크립트 끝 -->
             
<script type="text/javascript">
	$(document).ready(function() {
		var operForm = $("#operForm");
		$("button[data-oper='modify']").on("click", function(e){
			operForm.attr("action","/board/modify").submit();
		});
		
		$("button[data-oper='list']").on("click", function(e){
			operForm.find("#bno").remove();
			operForm.attr("action","/board/list")
			operForm.submit();
		});
	});
</script>

<script type="text/javascript">
$(document).ready(function(){
	(function(){
		var bno = '<c:out value="${board.bno}"/>';
		$.getJSON("/board/getAttachList", {bno: bno}, function(arr){
			console.log(arr);
			
			var str="";
			
			$(arr).each(function(i, attach){
				if(attach.fileType){
					var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
					
		               str += "<li data-path='"+attach.uploadPath+"'";
		               str +=" data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
		               str += "<img src='/display?fileName="+fileCallPath+"'>";
		               str += "</div>";
		               str +"</li>";
				}else{
		               str += "<li data-path='"+attach.uploadPath+"'";
		               str +=" data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
		               str +=" <span>"+attach.fileName+"</span><br/>";
		               str += "<img src='/resources/img/attach.png'>";
		               str += "</div>";
		               str +"</li>";
				}
			});
			$(".uploadResult ul").html(str);
		});//end getjson
	})();//end function
	
	//이미지 클릭시 이벤트부여하는 코드1
	function showImage(fileCallPath){
		alert(fileCallPath);
		
		$(".bigPictureWrapper").css("display","flex").show();
		
		$(".bigPicture").html("<img src='/display?fileName="+fileCallPath+"'>")
						.animate({width:'100%', height:'100%'},1000);
	}
	
	//이미지 클릭시 이벤트부여하는 코드2
	$(".uploadResult").on("click","li",function(e){		
		
		var liObj = $(this);
		var path = encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));
		
		if(liObj.data("type")){
			showImage(path.replace(new RegExp(/\\/g),"/"));
		}else{
			self.location = "/download?fileName="+path;
		}
	});
	
	//원본이미지 창 닫는 코드
	$(".bigPictureWrapper").on("click", function(e){
		$(".bigPicture").animate({width:'0%', height:'0%'},1000);
		setTimeout(function(){
			$('.bigPictureWrapper').hide();
		},1000);
	});
});
</script>
                  
<%@include file="../includes/footer.jsp" %>























