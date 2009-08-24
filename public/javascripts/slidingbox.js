$(document).ready(function(){  
    //Full Caption Sliding (Hidden to Visible)  
    $('.project.captionfull').hover(function(){  
        $(".cover", this).stop().animate({top:'0px'},{queue:false,duration:160});  
    }, function() {  
        $(".cover", this).stop().animate({top:'158px'},{queue:false,duration:160});  
    });  
});