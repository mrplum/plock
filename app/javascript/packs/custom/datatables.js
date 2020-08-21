// Call the dataTables jQuery plugin
$(document).ready(function() {
  $('#dataTable').DataTable({
    dom: '<"row"<"col-sm-12"l><"col-md-12"f>>tp',
    "pageLength":   5,
    "lengthChange": false,
    "language": {
      search: '<i class="fa fa-filter text-primary" aria-hidden="true"></i>',
      searchPlaceholder: 'Buscar'
    }
  });
  $('#dataTableUserTeam').DataTable({
    dom: '<"row"<"col-sm-12"l><"col-md-12"f>>tp',
    "paging":   false,
    "ordering": false,
    "info":     false,
    "bSort":    false,
    "language": {
      search: '<i class="fa fa-filter text-primary" aria-hidden="true"></i>',
      searchPlaceholder: 'Buscar'
    }
  });
  $('#dataTableUserCompany').DataTable({
    dom: '<"row"<"col-sm-12"l><"col-md-12"f>>tp',
    "paging":   false,
    "ordering": false,
    "info":     false,
    "bSort":    false,
    "language": {
      search: '<i class="fa fa-filter text-primary" aria-hidden="true"></i>',
      searchPlaceholder: 'Buscar'
    }
  });
});
