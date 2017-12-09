$(document).on("ready", function() {

  $("#import").on("click", function(e) {
    e.stopPropagation();
    e.preventDefault();
    console.log("processing");

    var month = $("#date_month").val()
    var year = $("#date_year").val()
    var selectPath

    $("#import").attr("disabled", "disabled");
    $("#import").val("Submitting");


    if ($("#category").val() === "expenses") {
      selectPath = "expenses"
    } else if ($("#category").val() === "sales") {
      selectPath = "sales"
    }
    console.log(month, year);
      $.ajax({
        url: "/" + selectPath + "/import",
        dataType: "JSONP",
        data: {
          month: month,
          year: year
        },
        method: "POST"
      }).done(function(e) {
        $("#import").removeAttr("disabled");
        $("#import").val("Submit");
        alert("Successfully imported file")
      })

  })
})
