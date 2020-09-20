import { ajax } from "../ajax";

var calendarEl = document.getElementById('calendar');
if (calendarEl !== null) {
  ajax("GET", "me/dataUser/events", { }, functionCalendar);
}

function functionCalendar(data) {
  var calendar = new FullCalendar.Calendar(calendarEl, {
    locale: 'esLocale',
    headerToolbar: {
      left: 'prev,next today',
      center: 'title',
      right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
    },
    weekNumbers: true,
    navLinks: true,
    editable: false,
    selectable: true,
    nowIndicator: true,
    dayMaxEvents: true,
    showNonCurrentDates: false,
    eventClick: function(info) {
      var e = info.event.extendedProps;
      $('#modalTitle').html(info.event.title);
      $('#modalBodyStart').html(e.start_at_time);
      $('#modalBodyEnd').html(e.end_at_time);
      $('#modalBodyDesc').html(e.description);
      $('#modalBodyProj').html(e.project);
      $('#eventsModal').modal();
    },
    events: data
  });
  calendar.render();
}


