if (document.getElementById('index_id') !== null) {
  document.getElementById("id_container_fluid").className="";
}
var element = document.getElementById('id_progress_color');
if (element !== null) {
  var value = element.getAttribute("aria-valuenow");
  if (value <= 20)
    element.classList.add("bg-danger");
  else if (value > 20 && value <= 40)
    element.classList.add("bg-warning");
  else if (value > 40 && value <= 60)
    element.classList.add("bg-primary");
  else if (value > 60 && value <= 80)
    element.classList.add("bg-info");
  else
    element.classList.add("bg-success");
}
