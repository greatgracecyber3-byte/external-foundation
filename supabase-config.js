/* ============================================================
   supabase-config.js — the ONE place you paste your Supabase keys.
   Find both under Supabase → Project Settings → API.
   (The anon / publishable key is safe to put here — it is meant to
   be public. NEVER paste the service_role / secret key.)
   ============================================================ */
window.SUPABASE_URL = 'https://kukxxfujvwinnykhvfzl.supabase.co';
window.SUPABASE_ANON_KEY = 'sb_publishable_Kc7CD388n5pciorUxbra3A_Ls_8W5d7';
window.SUPABASE_BUCKET = 'gallery';

// Reads one block of site content (photos, slider, etc.) from Supabase.
// Resolves to null if Supabase isn't connected yet, so pages still load.
window.loadSiteContent = function (key) {
  if (!window.SUPABASE_URL || window.SUPABASE_URL.indexOf('YOUR-') !== -1) {
    return Promise.resolve(null);
  }
  return fetch(window.SUPABASE_URL + '/rest/v1/site_content?key=eq.' +
      encodeURIComponent(key) + '&select=data', {
    headers: { apikey: window.SUPABASE_ANON_KEY },
    cache: 'no-cache'
  })
    .then(function (r) { return r.ok ? r.json() : []; })
    .then(function (rows) { return rows && rows[0] ? rows[0].data : null; })
    .catch(function () { return null; });
};

// Saves one form submission (contact, volunteer, newsletter) into a Supabase table.
// Visitors can only ADD rows — they can never read them. You read them in
// Supabase → Table Editor.
window.submitToSupabase = function (table, row) {
  if (!window.SUPABASE_URL || window.SUPABASE_URL.indexOf('YOUR-') !== -1) {
    return Promise.reject(new Error('Supabase is not connected'));
  }
  return fetch(window.SUPABASE_URL + '/rest/v1/' + table, {
    method: 'POST',
    headers: {
      apikey: window.SUPABASE_ANON_KEY,
      'Content-Type': 'application/json',
      Prefer: 'return=minimal'
    },
    body: JSON.stringify(row)
  }).then(function (r) {
    // 409 = this email is already subscribed; treat it as success
    if (!r.ok && r.status !== 409) throw new Error('Could not save (' + r.status + ')');
  });
};
