<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ajax</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	function getList() {
		var url = "${pageContext.request.contextPath}/rest/after.json";
		/*    $.ajax({
		url : '서비스 주소'
		, data : '서비스 처리에 필요한 인자값'
		, type : 'HTTP방식' (POST/GET 등)
		, dataType : 'return 받을 데이터 타입' (json, text 등)
		, success : function('결과값'){
		// 서비스 성공 시 처리 할 내용
		}, error : function('결과값'){
		// 서비스 실패 시 처리 할 내용
		}
		}); */

		$.ajax({
			type : "GET", // GET/POST무조건 대문자로 작성
			url : url,
			cache : false, // 이걸 안쓰거나 true로 하면 수정해도 값반영이 잘 안됨
			dataTyep : 'json', // 데이터타입은 제이슨으로 꼭 해야함.(url로 받아오는 파일이 json)
			success : function(result) {
				// 비동식의 대표적인 형태
				var htmls = "";
				$("#list_table").html("");
				$("<tr>",
								{
									html : "<td>" + "번호" + "</td>" + // 컬럼명들
									"<td>" + "이름" + "</td>" + "<td>" + "제목"
											+ "</td>" + "<td>" + "날짜" + "</td>"
											+ "<td>" + "히트" + "</td>" + "<td>"
											+ "삭제" + "</td>"
								}).appendTo("#list_table") // 이것을 테이블에붙임

						if (result.length < 1) {
							htmls.push("등록된 댓글이 없습니다.");
						} else {
							$(result).each(function() {
							htmls += '<tr>';
												htmls += '<td>' + this.bid
														+ '</td>';
												htmls += '<td>' + this.bname
														+ '</td>';
												htmls += '<td>'
												for (var i = 0; i < this.bindent; i++) { //for 문은 시작하는 숫자와 종료되는 숫자를 적고 증가되는 값을 적어요. i++ 은 1씩 증가 i+2 는 2씩 증가^^
													htmls += '-'
												}
												htmls += '<a href="${pageContext.request.contextPath}/content_view?bid='
														+ this.bid
														+ '">'
														+ this.btitle
														+ '</a></td>';
												htmls += '<td>' + this.bdate
														+ '</td>';
												htmls += '<td>' + this.bhit
														+ '</td>';
												htmls += '<td><a class="a-delete" href="${pageContext.request.contextPath}/ajax/delete?bid='
														+ this.bid
														+ '">삭제</a></td>';
												htmls += '</tr>';

											}); //each end

							htmls += '<tr>';
							htmls += '<td colspan="6"> <a href="${pageContext.request.contextPath}/write_view">글작성</a> </td>';
							htmls += '</tr>';

						}

						$("#list_table").append(htmls);
					}

				}); //Ajax end

	}//end getList
</script>

<!-- id는 단수: 유일무이한 선택자
class는 복수 일때 -->
<script>
	$(document).ready(function() {
		// 동적으로 추가되는 태그에는 클릭 이벤트가 적용되지 않는다. (ex> $(".a-delete").click(funtion()))
		$(document).on("click", ".a-delete", function(event) {
			//prevendDefault()는 href로 연결해 주지 않고 단순히 click에 대한 처리를 하도록 해준다.
			event.preventDefault();
			console.log("ajax 호출전");
			//해당 tr제거
			var trObj = $(this).parent().parent();

			//form 태그 대신 Ajax를 사용 : 비동기통신 = 부분갱신 = 화면깜빡임없음
			$.ajax({
				//method
				type : "GET",
				//action
				url : $(this).attr("href"),
				success : function(result) {
					console.log(result);
					if (result == "SUCCESS") {
						$(trObj).remove();

					}
				},
				error : function(e) {
					console.log(e);
				}
			})

		});

	});
</script>

<script>
	$(document).ready(function() {
		getList();
	});
</script>

<!-- <script>
$(document).ready(function (){
      
      $('.delete').click(function(event){
         //prevendDefault()는 href로 연결해 주지 않고 단순히 click에 대한 처리를 하도록 해준다.
         event.preventDefault();
         console.log("ajax 호출전"); 
         //해당 tr제거
         var trObj =  $(this).parent().parent();
         
         $.ajax({
             type : "GET",
             url : $(this).attr("href"),
/*              data:{"bId":"${content_view.bId}"}, */
             success: function (result) {       
                 console.log(result); 
               if(result == "SUCCESS"){
                    //getList();
                  $(trObj).delete();  
                            
               }                       
             },
             error: function (e) {
                 console.log(e);
             }
         })
          
      });
   });   
  </script>
 -->

</head>

<body>
	<table id="list_table" width="500" cellpadding="0" cellspacing="0"
		border="1">

	</table>
</body>
</html>