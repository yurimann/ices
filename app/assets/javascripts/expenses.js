$(document).on("ready", function(){
  $("#import").on("click", function(e){
    e.stopPropagation();
    e.preventDefault();

    var month = $("#month").val()
    var year = $("#year").val()

    $.ajax({
      url: "/expenses/import",
      dataType: "JSONP",
      data: {month: month, year: year},
      method: "POST"
    }).done(function(e){
      console.log(e);
    }).fail(function(){
      console.log("FAILED");
    })
  })
})
