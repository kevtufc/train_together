// document.querySelector("[data-complete-day]").addEventListener("click", function(){
//   document.getElementById("complete-dialog").modal("show")
// })
$("turbolinks:load", function(){
  $("[data-show-modal]").on("click", function(event) {
    $($(this).data("show-modal")).modal("show")
  })
})
