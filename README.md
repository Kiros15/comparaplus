# ComparaPlus V4 — Panel privado + Fase 3

Esta versión parte de V3 y añade la base de la fase 3:

- Supabase/PostgreSQL como fuente de productos.
- Panel privado en `/admin/` con login de Supabase Auth.
- CRUD de productos: crear, editar, borrar, activar/desactivar y destacar.
- Campos preparados para enlaces de afiliación, importes y fecha de verificación.
- RLS: productos activos son públicos; escritura y gestión solo para usuarios incluidos en `admins`.
- La web pública intenta cargar productos desde Supabase y mantiene los 8 productos de V3 como fallback si Supabase no está configurado.
- GA4, AdSense y Search Console se mantienen.

## Configuración rápida

1. Crea un proyecto en Supabase.
2. Ejecuta `supabase/schema.sql` completo en SQL Editor.
3. Crea tu usuario en Authentication > Users.
4. Añade ese usuario a `public.admins` con el SQL indicado en `supabase/README.md`.
5. Edita `supabase-config.js` con la URL y la publishable/anon key. **Nunca pongas service_role/secret key en el frontend.**
6. Sube todo a GitHub y deja que Vercel despliegue.
7. Entra en `https://www.comparaplus.net/admin/`.

## Siguiente bloque de Fase 3

- Cargar 50–100 productos reales.
- Crear páginas SEO dinámicas por categoría, entidad y producto.
- Motor de ranking por perfil y condiciones.
- Sistema de enlaces de afiliación por producto.
- Histórico de cambios y fecha de última verificación.
- Preparación para leads de hipotecas/préstamos/seguros.
