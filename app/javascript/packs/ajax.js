export function ajax(method, url, params = {}, functionSuccess, context = null) {
  $.ajax({
    type: method,
    contentType: "application/json; charset=utf-8",
    url: url,
    dataType: 'json',
    data: params,
    success: function (data) {
      context == null ? functionSuccess(data) : functionSuccess(data, context);
    },
    error: function (data) {
      error(data);
    }
  })
}
