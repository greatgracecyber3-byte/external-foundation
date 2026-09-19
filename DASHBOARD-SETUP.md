# Photo dashboard — Supabase setup

The dashboard is `admin.html`. You sign in with an email and password, add
photos, and press **Publish**. Photos are stored in Supabase Storage and the
list of what goes where is stored in a Supabase table. The public pages read
from Supabase directly.

## One-time setup (about 5 minutes)

1. **Create a project** at [supabase.com](https://supabase.com) (free plan is fine).

2. **Run the SQL.** In Supabase open **SQL Editor → New query**, paste the whole
   of `supabase-setup.sql`, and click **Run**. Run it once only. It creates the
   `site_content` table, a public `gallery` storage bucket, and the rules that
   let everyone *see* photos but only a signed-in admin *change* them.

3. **Create your admin login.** **Authentication → Users → Add user → Create
   new user.** Enter your email and a strong password, and tick **Auto Confirm
   User**.

4. **Turn off public sign-ups** (important). **Authentication → Sign In /
   Providers** (or *Settings*) → switch off **Allow new users to sign up**.
   Without this, a stranger could register and edit your site.

5. **Paste your keys.** In Supabase go to **Project Settings → API**. Copy the
   **Project URL** and the **anon / publishable key**. Open
   `supabase-config.js` and replace `YOUR-PROJECT-REF.supabase.co` and
   `YOUR-ANON-PUBLIC-KEY`. Never use the `service_role` / secret key.

6. **Upload the site** to any static host, then open `yoursite.com/admin.html`
   and sign in.

To try it on your computer first, run `python3 -m http.server` in the site
folder and open `http://localhost:8000/admin.html`.

## Forms (contact, volunteer, newsletter)

Run `supabase-forms.sql` the same way as step 2 (SQL Editor → New query →
paste → Run, once). After that:

- The **Contact** form, the **Volunteer** form and the **footer newsletter**
  box on every page save straight into Supabase.
- Read them in **Table Editor**: `contact_messages`, `volunteer_signups`,
  `newsletter_subscribers`. Visitors can add entries but can never read them.
- Supabase does not email you when someone submits. Check the tables, or ask
  for email alerts to be added later.

## Using the dashboard

There are three tabs. Change anything, then press **Publish** at the bottom of
that tab.

- **Homepage slider** — the rotating photos at the top of the home page. Add,
  reorder with the arrows, remove.
- **Add your own photo frames** — extra photos on any page's gallery section.
- **Photos around the site** — the named photo spots (programme photos,
  founder portrait, story cards, etc.) and photos for each Our Impact project
  and the Accelerator 2026 gallery. Add a photo only where you have one; any
  spot left empty is removed from the live page and the layout closes up.
  The **Display settings** box has a switch to show labelled empty boxes while
  you are still collecting photos (off by default).

Choosing a file uploads it straight away; the change goes live when you press
**Publish**.

## Photo guidelines

- At least 1200px on the long edge; under ~500 KB per file for mobile data
  (squoosh.app shrinks photos free in the browser).
- Write a one-sentence description for each photo — it is what screen readers
  and Google use.
- For any recognisable person, especially a child, make sure you have
  permission to publish before uploading.

## If something doesn't work

- **"Not connected yet"** on the sign-in screen → the keys in
  `supabase-config.js` are still the placeholders.
- **"Could not load content"** after signing in → the SQL in step 2 hasn't been
  run.
- **Upload fails** → the `gallery` bucket or its rules are missing; re-check
  step 2.
- **Photos don't appear on the public site** → you uploaded but didn't press
  **Publish**, or `supabase-config.js` wasn't uploaded with the site.
