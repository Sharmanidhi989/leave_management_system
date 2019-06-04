$(document).on('change','#searchleave', (event) => {
  let selectVal = event.target.value;
  $.ajax({
    type: "GET", 
    url: "/leaves",
    data: {type: selectVal}
  });
});
