drop policy if exists "solicitudes_insert_publico" on public.solicitudes_ingreso;
drop policy if exists "solicitudes_select_admin" on public.solicitudes_ingreso;
drop policy if exists "solicitudes_update_admin" on public.solicitudes_ingreso;
drop policy if exists "solicitudes_delete_admin" on public.solicitudes_ingreso;

create policy "solicitudes_insert_publico"
  on public.solicitudes_ingreso
  for insert
  to anon
  with check (true);

create policy "solicitudes_select_admin"
  on public.solicitudes_ingreso
  for select
  to authenticated
  using ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin');

create policy "solicitudes_update_admin"
  on public.solicitudes_ingreso
  for update
  to authenticated
  using ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin')
  with check ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin');

create policy "solicitudes_delete_admin"
  on public.solicitudes_ingreso
  for delete
  to authenticated
  using ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin');
