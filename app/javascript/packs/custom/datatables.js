// Call the dataTables jQuery plugin
$(document).ready(function() {
  $('#dataTable').DataTable({
    "pageLength": 5,
    "lengthChange": false
  });
  $('#dataTable2').DataTable({
    "pageLength": 5,
    "lengthChange": false
  });
  $('#dataTable3').DataTable({
    "pageLength": 5,
    "lengthChange": false
  });
});
