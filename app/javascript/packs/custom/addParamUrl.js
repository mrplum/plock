window.addParamUrlForm = function(button) {
  var url = document.getElementById('urlSendEmail')
  if (url != null) {
    url.action = url.action + `?type_report=${button.id}`
  }
}