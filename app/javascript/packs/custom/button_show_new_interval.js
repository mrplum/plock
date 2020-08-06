if (document.getElementById('date-view-interval') !== null) {

  document.querySelectorAll('.handleElement').forEach(item => {
    item.addEventListener('change', (e) => {

      var form = e.target.form;

      var yearStartAt = form.interval_start_at_1i.value;
      var monthStartAt = form.interval_start_at_2i.value;
      var dayStartAt = form.interval_start_at_3i.value;
      var hoursStartAt = form.interval_start_at_4i.value;
      var minutesStartAt = form.interval_start_at_5i.value;

      var dateStartAt = new Date(yearStartAt, monthStartAt, dayStartAt, hoursStartAt, minutesStartAt);

      var yearEndAt = form.interval_end_at_1i.value;
      var monthEndAt = form.interval_end_at_2i.value;
      var dayEndAt = form.interval_end_at_3i.value;
      var hoursEndAt = form.interval_end_at_4i.value;
      var minutesEndAt = form.interval_end_at_5i.value;

      var dateEndAt = new Date(yearEndAt, monthEndAt, dayEndAt, hoursEndAt, minutesEndAt);

      if (dateStartAt < dateEndAt){
        document.getElementById("invalid-form").classList.add("hidden");
        document.getElementById("create-button").classList.remove("hidden");
      }
      else{
        document.getElementById("create-button").classList.add("hidden");
        document.getElementById("invalid-form").classList.remove("hidden");
      }
    });
  });
}