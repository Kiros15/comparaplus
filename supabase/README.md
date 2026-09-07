# ComparaPlus V4 — Supabase

1. Crea un proyecto en Supabase.
2. En SQL Editor pega `schema.sql` y ejecuta todo.
3. En Authentication > Users crea tu usuario administrador con email/password.
4. Copia el UUID de ese usuario y ejecuta:

```sql
insert into public.admins (user_id, email) values ('UUID_DEL_USUARIO', 'TU_EMAIL');
```

5. En `supabase-config.js` coloca la URL del proyecto y la publishable/anon key. Nunca pongas una `service_role`/secret key en el frontend.
6. Sube el proyecto a GitHub/Vercel.
7. Accede a `/admin/` para gestionar productos.
