create extension if not exists pgcrypto;

create table if not exists public.admins (
  user_id uuid primary key references auth.users(id) on delete cascade,
  email text,
  created_at timestamptz not null default now()
);

create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  category text not null,
  type text,
  bank text not null,
  name text not null,
  tin text,
  tae text,
  term text,
  amount_min numeric,
  amount_max numeric,
  fee text,
  highlight text,
  requirements text,
  url text,
  affiliate_url text,
  source text,
  verified_at date,
  active boolean not null default true,
  featured boolean not null default false,
  updated_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

create index if not exists products_category_idx on public.products(category);
create index if not exists products_active_idx on public.products(active);
create index if not exists products_featured_idx on public.products(featured);

alter table public.admins enable row level security;
alter table public.products enable row level security;

create or replace function public.is_admin()
returns boolean language sql security definer set search_path = public
as $$ select exists (select 1 from public.admins where user_id = auth.uid()); $$;

drop policy if exists "public read active products" on public.products;
create policy "public read active products" on public.products for select using (active = true or public.is_admin());

drop policy if exists "admins insert products" on public.products;
create policy "admins insert products" on public.products for insert with check (public.is_admin());
drop policy if exists "admins update products" on public.products;
create policy "admins update products" on public.products for update using (public.is_admin()) with check (public.is_admin());
drop policy if exists "admins delete products" on public.products;
create policy "admins delete products" on public.products for delete using (public.is_admin());

drop policy if exists "admins read own admin row" on public.admins;
create policy "admins read own admin row" on public.admins for select using (auth.uid() = user_id);

insert into public.products (slug,category,type,bank,name,tin,tae,term,fee,highlight,requirements,url,source,verified_at,active,featured)
values
('openbank-hipoteca-fija','Hipotecas','Fija','Openbank','Hipoteca Fija Openbank','2,80%','3,41%','5–30 años','Consultar','Desde 2,80% TIN con bonificación','El interés varía según importe y plazo; bonificación sujeta a condiciones.','https://www.openbank.es/hipoteca-open','Openbank','2026-09-07',true,true),
('ibercaja-hipoteca-vamos-fija','Hipotecas','Fija','Ibercaja','Hipoteca Fija Vamos','2,55%*','3,49%*','Hasta 25 años','Consultar','2,55% TIN con bonificación','Hasta el 80% para vivienda habitual; bonificaciones por nómina, tarjeta, recibos, seguros y fondos.','https://www.ibercaja.es/particulares/hipotecas-prestamos/hipotecas/hipoteca-vamos-fija/','Ibercaja','2026-09-07',true,true),
('bankinter-hipoteca-fija','Hipotecas','Fija','Bankinter','Hipoteca Fija Bankinter','Personalizado','Personalizada','Hasta 30 años','500 € apertura*','Simulación y oferta personalizada','El precio depende de importe, plazo y bonificaciones.','https://www.bankinter.com/banca/hipotecas-prestamos/hipotecas/hipoteca-fija','Bankinter','2026-09-07',true,false),
('ing-prestamo-naranja','Préstamos','Personal','ING','Préstamo NARANJA','5,49–12,49%','5,63–13,23%','12–96 meses','0 € apertura / amortización','Sin comisión de apertura ni amortización','Importe 3.000–60.000 €. Tipo sujeto al análisis de la solicitud.','https://www.ing.es/prestamos-personales','ING','2026-09-07',true,true),
('openbank-cuenta-remunerada','Cuentas','Remunerada','Openbank','Cuenta Remunerada Openbank','2,72%','2,75%','12 meses','0 €','2,75% TAE durante un año','Nuevos clientes; activar Bizum y traer ahorros. Promo 200 € con 2 recibos hasta 30/09/2026.','https://www.openbank.es/cuenta-remunerada','Openbank','2026-09-07',true,true),
('ing-cuenta-nomina','Cuentas','Nómina','ING','Cuenta NÓMINA + Cuenta NARANJA','0% / 1,00%','0% / 1,00%','Sin plazo','0 € con condiciones','Hasta 400 € de bienvenida','Nómina o ingresos recurrentes ≥700 €/mes y Bizum; promoción según condiciones.','https://www.ing.es/cuenta-nomina-ing','ING','2026-09-07',true,false),
('ing-deposito-bienvenida','Depósitos','3 meses','ING','Depósito Bienvenida','3%','3%','3 meses','0 €','3% TAE a 3 meses','Para nuevos clientes; promoción indicada por ING hasta 30/09/2026.','https://www.ing.es/ahorro-ing','ING','2026-09-07',true,true),
('openbank-deposito-6','Depósitos','6 meses','Openbank','Depósito Open 6 meses','2,48%','2,50%','6 meses','0 €','2,50% TAE con ingresos mensuales','Con ingresos mensuales ≥900 €; sin ello, 1,25% TAE.','https://www.openbank.es/deposito-a-plazo-fijo','Openbank','2026-09-07',true,false)
on conflict (slug) do nothing;
