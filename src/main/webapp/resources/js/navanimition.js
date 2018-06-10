// JavaScript Document
window.onload = function(){
var main = document.getElementById("main");
var list = document.getElementById("list");
var buttons = document.getElementById("buttons").getElementsByTagName('span');
var prev = document.getElementById('prev');
var next = document.getElementById('next');
var animated = false;
var index = 1;
var timer;
   function showButton(){
	   for(i=0;i<buttons.length;i++){
		   if(buttons[i].className == 'on'){
			  buttons[i].className = '' ;
			  			   break;
			   }
		   }
	    buttons[index-1].className = 'on';
	   
	   }
   
   function animite(offset){
	    animated = true;
	    var Newleft = parseInt(list.style.left) + offset ;
		var time = 400;
		var interval = 10;
		var speed = offset/(time/interval); 
	      function go(){
              if((speed < 0  && parseInt(list.style.left) > Newleft)||(speed > 0  && parseInt(list.style.left) < Newleft)){
				  list.style.left =  parseInt(list.style.left) + speed + 'px'; 
				  setTimeout(go,interval);
				  }
				  else{	
				  animated = false;				  		 
	       list.style.left = Newleft + 'px';
	   	   if (Newleft > -1180){
		   list.style.left = -7080 + 'px'
		   }
		   if (Newleft < -7080){
		   list.style.left = -1180 + 'px'
		   }
					  }
			  }
			  go();
	   }
     function play(){
		  timer = setInterval(function(){
			  
			  next.onclick();
			  },3000)
		 }
     function stop(){
		  clearInterval(timer);
		 }
next.onclick = function(){ 
   if(index == buttons.length){
	   index = 1;
	   }
	  else{
	 index += 1;
		  }
	showButton();
	if(!animated){   
	animite(-1180);
	}
}
prev.onclick = function(){  
	   if(index == 1){
	   index = buttons.length;
	   }
	   else{
		 index -= 1; 
		   }
	showButton();  
	if(!animated){   
	animite(+1180);
	}
}
     for (var i = 0; i < buttons.length; i++) {
		buttons[i].onclick = function (){
			if(this.className == 'on' ){
				return;
				}
	 var myIndex = parseInt(this.getAttribute('index'));
	 var offset = -1180 * (myIndex - index);
	 if(!animated){
	 animite(offset);};
	 index = myIndex;
	 showButton();		   
		}
}
   main.onmouseover = stop;
   main.onmouseout = play;
   play();
} 