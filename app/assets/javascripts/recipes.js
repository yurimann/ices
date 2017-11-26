$(document).on("ready", function(){

  $('#ten-display').on("click", function(){
    $('#ten').toggle();
    $('#ten-display').toggle();
  });

  $(".close").on("click", function(){
    $("#ten").toggle();
    $('#ten-display').toggle();
  });
})
