-- ============================================================
-- Supabase setup — run this ONCE in Supabase → SQL Editor → New query
-- ============================================================

-- 1. Table that holds the slider, custom photos and site photo settings
create table if not exists public.site_content (
  key text primary key,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.site_content enable row level security;

-- Anyone can READ (that's how the public website loads its photos)
create policy "Public can read site content"
  on public.site_content for select using (true);

-- Only a signed-in admin can CHANGE it
create policy "Admin can insert site content"
  on public.site_content for insert to authenticated with check (true);
create policy "Admin can update site content"
  on public.site_content for update to authenticated using (true) with check (true);
create policy "Admin can delete site content"
  on public.site_content for delete to authenticated using (true);

-- 2. Public storage bucket for uploaded photos
insert into storage.buckets (id, name, public)
values ('gallery', 'gallery', true)
on conflict (id) do nothing;

create policy "Public can view gallery photos"
  on storage.objects for select using (bucket_id = 'gallery');
create policy "Admin can upload gallery photos"
  on storage.objects for insert to authenticated with check (bucket_id = 'gallery');
create policy "Admin can replace gallery photos"
  on storage.objects for update to authenticated using (bucket_id = 'gallery');
create policy "Admin can delete gallery photos"
  on storage.objects for delete to authenticated using (bucket_id = 'gallery');

-- 3. Starter content
--    "images" already contains the photo assignments from your old images.json
--    (founder, slider, programme and project photos). Those image files sit
--    next to your pages, so keep them uploaded with the site.
insert into public.site_content (key, data) values
  ('gallery',       '{"slides": []}'),
  ('custom-photos', '{"photos": []}'),
  ('images',        $json${
  "settings": {
    "showPlaceholders": false
  },
  "photos": [
    {
      "slot": "founder",
      "image": "founder-dr-jane-mwikali.jpg",
      "alt": "Dr. Jane Mwikali, Founder"
    },
    {
      "slot": "slider-1",
      "image": "south-c-screening-activity.jpg",
      "alt": "Health workers at the South C cancer awareness and screening event"
    },
    {
      "slot": "slider-2",
      "image": "south-c-screening-partners.jpg",
      "alt": "Foundation staff and partner organizations at a community health outreach"
    },
    {
      "slot": "slider-3",
      "image": "graduation-ceremony.jpg",
      "alt": "Graduates on stage at a foundation-supported graduation ceremony"
    },
    {
      "slot": "feature-health",
      "image": "south-c-screening-beneficiaries.jpg",
      "alt": "A health worker conducting a screening test on a community member"
    },
    {
      "slot": "programme-health",
      "image": "south-c-screening-partners.jpg",
      "alt": "Health workers and partner organizations at a medical outreach event"
    },
    {
      "slot": "programme-community",
      "image": "food-donations.jpg",
      "alt": "Food supplies being distributed to community members"
    },
    {
      "slot": "programme-education",
      "image": "graduation-ceremony.jpg",
      "alt": "Graduates celebrating at a graduation ceremony"
    },
    {
      "slot": "programme-youth",
      "image": "youth-engagement.jpg",
      "alt": "Young people participating in a foundation event"
    }
  ],
  "projects": [
    {
      "project": "p10",
      "photos": [
        {
          "image": "food-donations.jpg",
          "alt": "Food supplies being distributed during a Thanksgiving Service",
          "caption": "Food package distribution during a Thanksgiving Service."
        }
      ]
    },
    {
      "project": "p11",
      "photos": [
        {
          "image": "south-b-medical-camp.jpg",
          "alt": "A health worker conducting a finger-prick test on a participant at the South B Community Medical Camp",
          "caption": "South B Community Medical Camp, 31 May 2025."
        }
      ]
    },
    {
      "project": "p12",
      "photos": [
        {
          "image": "south-c-screening-beneficiaries.jpg",
          "alt": "A health worker conducting a screening test on a community member at Kongoni Primary School",
          "caption": "Cancer awareness and screening, Kongoni Primary School, South C, 27 July 2025."
        },
        {
          "image": "south-c-screening-activity.jpg",
          "alt": "Foundation and partner staff at the South C cancer screening event"
        },
        {
          "image": "south-c-screening-partners.jpg",
          "alt": "KEMRI, MobiLab Africa and National Cancer Institute staff at the South C screening event"
        }
      ]
    }
  ]
}$json$)
on conflict (key) do nothing;
