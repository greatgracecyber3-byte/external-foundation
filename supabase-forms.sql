-- ============================================================
-- Forms setup — run ONCE in Supabase → SQL Editor → New query
-- Creates 3 tables. Visitors can only ADD rows; only you (signed in)
-- can read them, in Table Editor.
-- ============================================================

create table if not exists public.contact_messages (
  id bigint generated always as identity primary key,
  created_at timestamptz not null default now(),
  name text not null check (char_length(name) <= 200),
  email text not null check (char_length(email) <= 200),
  phone text check (char_length(phone) <= 50),
  reason text check (char_length(reason) <= 50),
  message text not null check (char_length(message) <= 5000)
);

create table if not exists public.volunteer_signups (
  id bigint generated always as identity primary key,
  created_at timestamptz not null default now(),
  name text not null check (char_length(name) <= 200),
  email text not null check (char_length(email) <= 200),
  phone text check (char_length(phone) <= 50),
  interests text[],
  message text check (char_length(message) <= 5000)
);

create table if not exists public.newsletter_subscribers (
  id bigint generated always as identity primary key,
  created_at timestamptz not null default now(),
  email text not null unique check (char_length(email) <= 200)
);

alter table public.contact_messages      enable row level security;
alter table public.volunteer_signups     enable row level security;
alter table public.newsletter_subscribers enable row level security;

create policy "Anyone can send a message"   on public.contact_messages
  for insert to anon, authenticated with check (true);
create policy "Anyone can volunteer"        on public.volunteer_signups
  for insert to anon, authenticated with check (true);
create policy "Anyone can subscribe"        on public.newsletter_subscribers
  for insert to anon, authenticated with check (true);

create policy "Admin can read messages"     on public.contact_messages
  for select to authenticated using (true);
create policy "Admin can read volunteers"   on public.volunteer_signups
  for select to authenticated using (true);
create policy "Admin can read subscribers"  on public.newsletter_subscribers
  for select to authenticated using (true);

-- Explicit access (harmless if already granted)
grant insert on public.contact_messages, public.volunteer_signups, public.newsletter_subscribers to anon, authenticated;
grant select on public.contact_messages, public.volunteer_signups, public.newsletter_subscribers to authenticated;
grant select on public.site_content to anon, authenticated;
grant insert, update, delete on public.site_content to authenticated;
