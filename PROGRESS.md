# PROGRESS SO FAR

## Completed

- **Stage 1 — Brand system + homepage:** `index.html`, `css/style.css`, `js/main.js`
- **Stage 2 — About:** `about.html`, `css/about.css`, `js/about.js`
- **Stage 3 — Our Work + Impact:** `our-work.html`, `impact.html`, `story-template.html`, `css/our-work.css`, `css/impact.css`, `css/story.css`, `js/impact.js`
- **Stage 4 — Get Involved:** `get-involved.html`, `css/get-involved.css`, `js/get-involved.js`
- **Stage 5 — Stories/News/Events/Reports + Contact + SEO + accessibility + performance:**
  `stories.html`, `contact.html`, `css/stories.css`, `css/contact.css`,
  `js/contact.js`, `robots.txt`, `sitemap.xml`

All five stages of the master build protocol are now built.

## Still open before this can go live

- **Every placeholder is still open.** `[ADD PHOTO]`, `[ADD VERIFIED ...]`,
  and `[ADD PDF LINK]` blocks across all pages need real, verified content.
  Nothing has been invented to fill them.
- **No payment processor** is connected on Get Involved.
- **No form backend** is connected on the volunteer form, contact form, or
  newsletter sign-up — each needs a service like Formspree wired into its
  `action="#"` before it can accept real submissions.
- **`stories.html`** has one placeholder news card, one placeholder event,
  and three placeholder reports — add, remove, or duplicate these rows as
  real items are confirmed.
- **`contact.html`** has placeholder address, phone, email, office hours,
  and a placeholder map — add verified details before publishing, and add
  a real map embed once the address is confirmed.
- **`robots.txt` and `sitemap.xml`** reference a placeholder domain
  (`YOUR-USERNAME.github.io/YOUR-REPO-NAME/`) — replace with the real
  published URL once GitHub Pages is live.
- **Social links** ([Facebook], [Instagram], [LinkedIn], [X/Twitter]) in
  every footer are still placeholders.
- **Legal pages** (Privacy Policy, Terms, Safeguarding, Accessibility)
  linked in every footer don't exist yet as real pages — currently `#`.
- No real photography has been added anywhere; see `images/README.md`
  from Stage 1 for the running list of needed images.

## Accessibility & performance notes (Stage 5 audit)

- Every page has a skip link, a labelled primary nav, `aria-expanded` on
  the mobile toggle, and `:focus-visible` styling from the brand system —
  these patterns are consistent across all six pages plus the story
  template.
- Once real `<img>` tags replace the `.ph-photo` placeholders, add
  meaningful `alt` text to each and `loading="lazy"` to any image below
  the fold.
- Google Fonts are loaded with `preconnect` on every page already, which
  is the main font-loading performance lever available without a build step.
- `robots.txt` and `sitemap.xml` are in place; each page has a `<title>`
  and meta description — `contact.html` and `stories.html` now also have
  `og:title`/`og:type` and a `rel="canonical"` tag, matching the pattern
  worth back-filling onto the Stage 1–4 pages too.

## How to continue

This closes the five-stage protocol. Next real steps are content, not
code: verified copy, real photos, a form backend, a payment processor,
and the four legal pages, then a final read-through against
`master-build-prompt.md`'s "never invent facts" rule before publishing.
