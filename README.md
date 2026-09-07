# ComparaPlus.net — V4 Fase 3 conectada a Supabase

Versión lista para Vercel con:
- ComparaPlus Score 0–100 y ranking por perfil.
- Comparación lado a lado de hasta 3 productos.
- Supabase como fuente de datos pública: carga automáticamente todos los productos con `active = true`.
- Panel privado `/admin/` para crear, editar, activar/desactivar, destacar y borrar productos.
- RLS: el público solo lee productos activos; los administradores gestionan el catálogo.
- Enlaces de afiliación por producto (`affiliate_url`) con fallback al enlace oficial (`url`).
- GA4, AdSense y Search Console conservados.
- Fallback local a los productos incluidos en la web si Supabase no responde.

## Supabase ya configurado
`supabase-config.js` contiene la URL y publishable key del proyecto configurado para ComparaPlus.

**Nunca sustituirla por una service_role/secret key.**

## Publicación en Vercel
1. Sustituye el contenido de tu repositorio por el contenido de esta carpeta.
2. Haz commit/push a GitHub.
3. Vercel desplegará automáticamente.
4. Comprueba `https://www.comparaplus.net/`.
5. Comprueba `https://www.comparaplus.net/admin/` e inicia sesión con tu usuario de Supabase.

## Comprobación del catálogo
La base de datos puede contener 50 productos, pero la web pública muestra únicamente los que tengan `active = true`.

Para comprobar el total en Supabase:
```sql
select category, count(*) as total
from public.products
group by category
order by category;
```

## Flujo de trabajo futuro
Para añadir o cambiar un producto no hace falta modificar el código: entra en `/admin/`, edita el producto y guarda. La web pública lo leerá desde Supabase automáticamente en la siguiente carga.


## Monetización / afiliación
- `products.affiliate_url`: enlace de tracking de afiliación.
- `affiliate_network`: red utilizada (Awin, TradeDoubler, etc.).
- `commission_model`: CPA, CPL, RevShare o CPC.
- `commission_value`: valor orientativo de la comisión.
- `commercial_priority`: prioridad comercial para ordenar ofertas; úsala con moderación y mantén la metodología editorial separada.
- `sponsored`: marca una oferta patrocinada para poder señalizarla.
- `product_clicks`: registra clics de afiliación/oficiales para analítica interna.
- El botón público usa `affiliate_url` cuando existe y `url` como fallback.
- No introduzcas nunca claves `service_role` en el frontend.
