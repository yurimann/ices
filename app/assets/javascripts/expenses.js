$(document).on("ready", function(){

  $("#import").on("click", function(e){
    e.stopPropagation();
    e.preventDefault();
    console.log("processing");

    var month = $("#date_month").val()
    var year = $("#date_year").val()

    $("#import").attr("disabled", "disabled");
    $("#import").val("Submitting");

    $.ajax({
      url: "/expenses/import",
      dataType: "JSONP",
      data: {month: month, year: year},
      method: "POST"
    }).done(function(e){
      $("#import").removeAttr("disabled");
      $("#import").val("Submit");
      alert("Successfully imported file")
    })
  })
})
