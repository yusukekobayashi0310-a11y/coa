-- Supabase SQL Editorで実行してください。
create table if not exists public.koa_archive (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.koa_archive enable row level security;
drop policy if exists "Users can read own koa archive" on public.koa_archive;
create policy "Users can read own koa archive" on public.koa_archive
  for select to authenticated using (auth.uid() = user_id);
drop policy if exists "Users can insert own koa archive" on public.koa_archive;
create policy "Users can insert own koa archive" on public.koa_archive
  for insert to authenticated with check (auth.uid() = user_id);
drop policy if exists "Users can update own koa archive" on public.koa_archive;
create policy "Users can update own koa archive" on public.koa_archive
  for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
