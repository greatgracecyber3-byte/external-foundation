// Contact page — preselect reason from ?reason= query param, save messages to Supabase
document.addEventListener('DOMContentLoaded', function () {

  var params = new URLSearchParams(window.location.search);
  var reason = params.get('reason');
  var reasonSelect = document.getElementById('c-reason');
  if (reason && reasonSelect) {
    var match = Array.prototype.find.call(reasonSelect.options, function (opt) {
      return opt.value === reason;
    });
    if (match) reasonSelect.value = reason;
  }

  var form = document.getElementById('contact-form');
  if (form) {
    var note = form.querySelector('.form-note');
    form.addEventListener('submit', function (e) {
      e.preventDefault();
      var btn = form.querySelector('button[type="submit"]');
      var d = new FormData(form);
      btn.disabled = true;
      note.textContent = 'Sending…';
      submitToSupabase('contact_messages', {
        name: d.get('name'), email: d.get('email'), phone: d.get('phone') || null,
        reason: d.get('reason'), message: d.get('message')
      }).then(function () {
        form.reset();
        note.textContent = 'Thank you — your message has been sent. We will be in touch.';
      }).catch(function () {
        note.textContent = 'Sorry, your message could not be sent. Please try again in a moment.';
      }).then(function () { btn.disabled = false; });
    });
  }
});
