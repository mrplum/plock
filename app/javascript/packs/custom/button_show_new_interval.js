if (document.getElementById('date-view-interval') !== null) {

  
  document.querySelectorAll('.handleElement').forEach(item => {
    item.addEventListener('change', (e) => {
      var yearStartAt = e.target.form.interval_start_at_1i.value;
      var monthStartAt = e.target.form.interval_start_at_2i.value;
      var dayStartAt = e.target.form.interval_start_at_3i.value;
      var hoursStartAt = e.target.form.interval_start_at_4i.value;
      var minutesStartAt = e.target.form.interval_start_at_5i.value;
          
      var dateStartAt = new Date(yearStartAt, monthStartAt, dayStartAt, hoursStartAt, minutesStartAt);

      var yearEndAt = e.target.form.interval_end_at_1i.value;
      var monthEndAt = e.target.form.interval_end_at_2i.value;
      var dayEndAt = e.target.form.interval_end_at_3i.value;
      var hoursEndAt = e.target.form.interval_end_at_4i.value;
      var minutesEndAt = e.target.form.interval_end_at_5i.value;
      
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
  // function handler(e) {
    // var yearStartAt = e.target.form.interval_start_at_1i.value;
    // var monthStartAt = e.target.form.interval_start_at_2i.value;
    // var dayStartAt = e.target.form.interval_start_at_3i.value;
    // var hoursStartAt = e.target.form.interval_start_at_4i.value;
    // var minutesStartAt = e.target.form.interval_start_at_5i.value;
        // 
    // var dateStartAt = new Date(yearStartAt, monthStartAt, dayStartAt, hoursStartAt, minutesStartAt);
// 
    // var yearEndAt = e.target.form.interval_end_at_1i.value;
    // var monthEndAt = e.target.form.interval_end_at_2i.value;
    // var dayEndAt = e.target.form.interval_end_at_3i.value;
    // var hoursEndAt = e.target.form.interval_end_at_4i.value;
    // var minutesEndAt = e.target.form.interval_end_at_5i.value;
    // 
    // var dateEndAt = new Date(yearEndAt, monthEndAt, dayEndAt, hoursEndAt, minutesEndAt);
    // 
    // if (dateStartAt < dateEndAt){
      //  document.getElementById("invalid-form").classList.add("hidden");
      //  document.getElementById("create-button").classList.remove("hidden");
    // }
    // else{
      //  document.getElementById("create-button").classList.add("hidden");
      //  document.getElementById("invalid-form").classList.remove("hidden");
    // }
  // }
//}