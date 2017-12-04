$(document).on("ready", function(){
  $("#import").on("click", function(e){
    e.stopPropagation();
    e.preventDefault();

    var month = $("#date_month").val()
    var year = $("#date_year").val()

    $("#import").attr("disabled", "disabled");
    $("#import").val("Submitted");

    $.ajax({
      url: "/expenses/import",
      dataType: "JSONP",
      data: {month: month, year: year},
      method: "POST"
    }).done(function(e){
      console.log(e);
    })
  })
})
