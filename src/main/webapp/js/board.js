/*
    board.js 글쓰기,글수정
    작성날짜 : 2022-09-05
    작성자 : 김하나
*/

$(document).ready(function(){
    $('#title_error').hide();
	$('#content_error').hide();

    $('.btn-register').click(function(){
        var title=$('.board-title').val();

        if(title.length < 1){
            $('#title_error').css('color','red').show();
            $('.board-title').css('border-color','red');
            return false;
        }else{
            $('#title_error').hide();
            $('.board-title').css('border-color','black');
        }

        var content=$('.board-content').val();

        if(content.length < 1){
        	$('#title_error').css('color','white').show();
            $('#content_error').show();
            $('.board-content').css('border-color','red');
            return false;
        }else{
            $('#content_error').hide();
            $('.board-content').css('border-color','black');
        }
    })


})