// JavaScript Document

document.addEventListener("turbo:load", function() {
	
	$(window).scroll(function() {
		if ($(document).scrollTop() > 150){					
			$(".top-bottom-bar").css({"height":"80px","background":"black","width":"1000px","left":"0","right":"0"});
			$(".standings-top-bottom-bar").css({"height":"80px","background":"black","width":"1000px","left":"0","right":"0"});			
			$(".button-list").css("margin-top","15px");
			$(".standings-button-list").css("margin-top","15px");			
			$(".main-logo").css({"top":"0px","height":"70px"});			
			$(".button-selection-holder").css({"height":"80px", "left":"0","right":"0"});
			}
		else {	
			$(".top-bottom-bar").css({"height":"150px","background":"black","width":"1000px","left":"0","right":"0"});
			$(".standings-top-bottom-bar").css({"height":"150px","background":"black","width":"1000px","left":"0","right":"0"});			
			$(".button-list").css("margin-top","30px");
			$(".standings-button-list").css("margin-top","30px");			
			$(".main-logo").css({"top":"5px","height":"125px"});		
			$(".button-selection-holder").css({"height":"150px", "left":"0","right":"0"});			
			}
	});						   

});


document.addEventListener("turbo:load", function() {
  // Array of week numbers to loop through
  const totalWeeks = 14;

  // Hide all week tables
  function hideAllWeeks() {
      for (let i = 1; i <= totalWeeks; i++) {
          $(`#week${i}`).css("display", "none");
      }
  }

  // Show the selected week table
  function showWeek(weekNumber) {
      hideAllWeeks(); // Hide all other weeks first
      $(`#week${weekNumber}`).css("display", "table"); // Show the selected week
  }

  // Attach click event to each week button
  for (let i = 1; i <= totalWeeks; i++) {
      $(`#${i}`).on("click", function() {
          showWeek(i);
      });
  }
});



/* MENU DROPDOWN SCRIPT */

document.addEventListener("turbo:load", function() {
	$(".box-shadow-sec").on("click",function(){
		$(".holder").toggleClass('show');
		$(".box-shadow-menu").toggleClass('changed');
		$(".box-shadow-menu-2").toggleClass('changing');     
	});
});

document.addEventListener("turbo:load", function() {

  if ($('#standings-tbl').length) {
    $('#standings-tbl').DataTable({
      "order": [[2, 'desc'], [5, 'desc']],
      "paging": false,
      "info": false,
      "searching": false
    });
  }

  if ($('#mobile-standings-tbl').length) {
    $('#mobile-standings-tbl').DataTable({
      "order": [[2, 'desc'], [5, 'desc']],
      "paging": false,
      "info": false,
      "searching": false
    });
  }
});





