# Photo dashboard — setup and daily use

The site has a dashboard at **`/admin`**: a login screen, a file picker, an
upload button and a Publish button. You never need to touch code to change a
photo.

There are **17 photo spots** around the site, plus the homepage slider, plus one
photo group per project on Our Impact. Every one of them is optional.

---

## The idea in one paragraph

You add a photo only where you actually have one. Any spot you leave empty has
its frame **removed from the live site**, and the layout closes the gap — a
two-column band becomes one full-width column of text, a card loses its image
area and leads with its heading, a project with no pictures shows no photo area
at all. There are no empty grey boxes and no reserved space. Delete a photo
later and the same thing happens in reverse.

The homepage slider is the one exception: it always keeps its frames, because a
slider with no frames is not a slider.

---

## Part 1 — Connect it (once, about 20 minutes)

1. **Put the site in a GitHub repository.** Create a free account at github.com,
   make a new repository, upload this whole folder.

2. **Point the dashboard at it.** Open `admin/config.yml` and change:

   ```
   repo: YOUR-GITHUB-USERNAME/YOUR-REPO-NAME
   ```

   to your real one, e.g. `repo: janemakau/eegf-website`.

3. **Deploy on Netlify.** Sign in at netlify.com with GitHub → "Add new site" →
   "Import an existing project" → pick the repository.

4. **Turn on logins.** In that site's Netlify settings, go to
   **Site configuration → Identity** → Enable Identity. Then
   **Identity → Services → Git Gateway** → Enable.

5. **Invite yourself.** Under Identity click "Invite users", enter your email,
   accept the invitation, set a password.

6. Go to `yoursite.com/admin` and log in.

### Seeing it before you do any of that

In a terminal in this folder:

```
npx decap-server
```

Then uncomment `local_backend: true` in `admin/config.yml`, serve the folder
(`python3 -m http.server`), and open `/admin`. No login, changes save straight
to the files on your computer.

---

## Part 2 — The three things you can do

### Homepage slider

The rotating photos at the top of the home page.

**Add Slide** → upload → caption → drag to reorder → **Publish**.
Remove a slide by deleting its entry. Two slides is fine; so is eight.

### Photos around the site — 17 spots

**Add Photo** → pick the spot from the dropdown → upload → **Publish**.

Seven of the spots are the **programme photos** (Women's Empowerment, Youth,
Health, Education, Economic, Leadership, Community). Each of those appears in
**two places at once** — the Home page grid and the matching Our Work section —
so you upload once and it lands in both. The founder portrait and the three
story cards work the same way.

The full list:

| Spot | Appears on |
|---|---|
| Programme — Women's Empowerment | Home + Our Work |
| Programme — Youth Development | Home + Our Work |
| Programme — Health | Home |
| Programme — Education & Skills | Home + Our Work |
| Programme — Economic Empowerment | Home + Our Work |
| Programme — Leadership | Home + Our Work |
| Programme — Community Development | Home + Our Work |
| Feature — medical outreach band | Home + Our Work |
| Portrait — Rev. Dr. Jane Mwikali Makau | Home + About |
| Story cards 1, 2, 3 | Home + Stories |
| Latest news cards 1, 2, 3 | Home |
| Contact — map or office photo | Contact |
| Story template — main photo | Story template |

**To remove a photo**, delete its entry and Publish. The frame disappears and
the page closes up.

### Project photos (Our Impact)

**Add Project** → pick one of the 16 projects → add as many photos as you have.

- The **first** photo becomes the large one at the top of the project.
- The rest form a group underneath, sized to however many there are: one photo
  sits at 60% width, two sit side by side, four make a 2×2, five or six make a
  3-across grid. No holes.
- A project you never add shows **no photo area at all** — the text just runs.

### The one switch: Display settings

At the top of "Photos around the site" there is a single toggle:

> **Show labelled empty boxes while collecting photos**

It is currently **on**, so you still see the grey `[ADD PHOTO — …]` boxes, which
is useful while you are gathering pictures and want to know what to look for.

**Turn it off** and every unfilled frame is removed from the live site and the
layout closes up. Turn it off the moment you are happy the site can stand on the
photos you have.

---

## Photo guidelines

- **Size:** at least 1200px on the long edge. Straight from a phone is fine.
- **Shape:** slider frames are portrait; most others are landscape. The site
  crops to fit, so keep the subject near the middle.
- **Weight:** aim under ~500 KB per file so pages load on mobile data.
  squoosh.app shrinks photos free in the browser.
- **Alt text:** one sentence saying what is in the picture. This is what a blind
  visitor hears and what Google reads. Worth the ten seconds.
- **Consent:** for any recognisable person, especially a child, be sure you have
  permission to publish before uploading. This matters more than the photo does.

---

## How it works, briefly

Each photo frame carries a `data-slot` label (`data-slot="programme-women"`), and
each Impact project carries `data-project="p01"`. Publishing writes your choices
to `content/images.json` and saves the files into `images/gallery/`. On page
load, `site-images.js` fills the frames it has photos for, builds the project
groups, then deletes every remaining empty frame and tags the section around it
so the stylesheet can close the gap.

If you ever add a new photo frame to a page, give it a `data-slot` of its own and
add a matching line to the options list in `admin/config.yml`.
