// Get Involved page — donate frequency toggle + amount chip selection
document.addEventListener('DOMContentLoaded', function () {

  // One-time / Monthly toggle
  var donateOptions = document.querySelectorAll('.donate-option');
  donateOptions.forEach(function (btn) {
    btn.addEventListener('click', function () {
      donateOptions.forEach(function (b) { b.classList.remove('is-active'); });
      btn.classList.add('is-active');
    });
  });

  // Amount chip selection (clears custom input when a chip is chosen)
  var amountChips = document.querySelectorAll('.amount-chip');
  var customInput = document.getElementById('donate-custom');
  amountChips.forEach(function (chip) {
    chip.addEventListener('click', function () {
      amountChips.forEach(function (c) { c.classList.remove('is-selected'); });
      chip.classList.add('is-selected');
      if (customInput) customInput.value = '';
    });
  });
  if (customInput) {
    customInput.addEventListener('input', function () {
      amountChips.forEach(function (c) { c.classList.remove('is-selected'); });
    });
  }

  // Volunteer form — saves to Supabase
  var volunteerForm = document.querySelector('.volunteer-form');
  if (volunteerForm) {
    var vNote = volunteerForm.querySelector('.form-note');
    volunteerForm.addEventListener('submit', function (e) {
      e.preventDefault();
      var btn = volunteerForm.querySelector('button[type="submit"]');
      var d = new FormData(volunteerForm);
      btn.disabled = true;
      vNote.textContent = 'Sending…';
      submitToSupabase('volunteer_signups', {
        name: d.get('name'), email: d.get('email'), phone: d.get('phone') || null,
        interests: d.getAll('interest'), message: d.get('message') || null
      }).then(function () {
        volunteerForm.reset();
        vNote.textContent = 'Thank you — we have your details and will be in touch about opportunities.';
      }).catch(function () {
        vNote.textContent = 'Sorry, that could not be sent. Please try again in a moment.';
      }).then(function () { btn.disabled = false; });
    });
  }
});
