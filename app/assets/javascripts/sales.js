$(document).on('ready', function(){
  $("button#export").on("click", function(){
    $.ajax({
      path: "/summary/write",
      method: "GET",
      data: {'from' : "2017-10-01", 'to' : "2017-10-11"},
      dataType: "CSV"
    }).done(function(e){
      console.log(e);
    }).fail(function(e){
      console.log(e);
    })
  })
})
