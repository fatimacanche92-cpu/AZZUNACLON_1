# ✅ Guía de Verificación de Base de Datos Azzuna

## 🎯 Verificaciones Post-Ejecución del Script SQL

### 1. ✅ Verificación Inmediata en SQL Editor

**Después de ejecutar el script, deberías ver:**
- ✅ Mensaje: **"Success. No rows returned"** (o similar)
- ✅ **NO** debe aparecer ningún mensaje de error en rojo
- ✅ El script debe ejecutarse completamente sin interrupciones

---

### 2. 📊 Verificar Tablas Creadas

**Ve a: Table Editor → Verifica que existan estas 7 tablas:**

#### Tablas que DEBEN existir:
1. ✅ `categories` - Categorías de flores
2. ✅ `products` - Productos (flores)
3. ✅ `user_profiles` - Perfiles de usuario
4. ✅ `addresses` - Direcciones de envío
5. ✅ `orders` - Pedidos
6. ✅ `order_items` - Items de pedido
7. ✅ `cart_items` - Carrito de compras

**Cómo verificar:**
- Ve a **Table Editor** en el menú lateral
- Deberías ver las 7 tablas listadas
- Haz clic en cada una para ver su estructura

---

### 3. 🔍 Verificar Estructura de Cada Tabla

**Haz clic en cada tabla y verifica las columnas:**

#### `categories`
- ✅ `id` (uuid, primary key)
- ✅ `name` (varchar)
- ✅ `description` (text)
- ✅ `image_url` (text)
- ✅ `created_at` (timestamp)
- ✅ `updated_at` (timestamp)

#### `products`
- ✅ `id` (uuid, primary key)
- ✅ `name` (varchar)
- ✅ `description` (text)
- ✅ `price` (numeric)
- ✅ `category_id` (uuid, foreign key)
- ✅ `image_url` (text)
- ✅ `images` (text array)
- ✅ `stock_quantity` (integer)
- ✅ `status` (enum: active, inactive, out_of_stock)
- ✅ `featured` (boolean)
- ✅ `created_at`, `updated_at`

#### `user_profiles`
- ✅ `id` (uuid, primary key, foreign key a auth.users)
- ✅ `full_name` (varchar)
- ✅ `phone` (varchar)
- ✅ `avatar_url` (text)
- ✅ `created_at`, `updated_at`

#### `addresses`
- ✅ `id` (uuid, primary key)
- ✅ `user_id` (uuid, foreign key)
- ✅ `label`, `recipient_name`, `phone`
- ✅ `street`, `city`, `state`, `postal_code`, `country`
- ✅ `is_default` (boolean)
- ✅ `created_at`, `updated_at`

#### `orders`
- ✅ `id` (uuid, primary key)
- ✅ `user_id` (uuid, foreign key)
- ✅ `address_id` (uuid, foreign key)
- ✅ `status` (enum: pending, confirmed, preparing, shipped, delivered, cancelled)
- ✅ `total_amount`, `shipping_cost` (numeric)
- ✅ `notes` (text)
- ✅ `delivered_at` (timestamp)
- ✅ `created_at`, `updated_at`

#### `order_items`
- ✅ `id` (uuid, primary key)
- ✅ `order_id` (uuid, foreign key)
- ✅ `product_id` (uuid, foreign key)
- ✅ `quantity` (integer)
- ✅ `unit_price`, `subtotal` (numeric)
- ✅ `created_at`

#### `cart_items`
- ✅ `id` (uuid, primary key)
- ✅ `user_id` (uuid, foreign key)
- ✅ `product_id` (uuid, foreign key)
- ✅ `quantity` (integer)
- ✅ `created_at`, `updated_at`
- ✅ **Constraint UNIQUE** en (user_id, product_id)

---

### 4. 🔒 Verificar Row Level Security (RLS)

**Ve a: Authentication → Policies**

**O ejecuta este query en SQL Editor:**
```sql
SELECT 
  schemaname,
  tablename,
  rowsecurity
FROM pg_tables
WHERE schemaname = 'public'
  AND tablename IN ('categories', 'products', 'user_profiles', 
                    'addresses', 'orders', 'order_items', 'cart_items');
```

**Resultado esperado:**
- ✅ Todas las tablas deben tener `rowsecurity = true`

---

### 5. 🛡️ Verificar Políticas de Seguridad

**Ejecuta este query para ver todas las políticas:**
```sql
SELECT 
  schemaname,
  tablename,
  policyname,
  permissive,
  roles,
  cmd
FROM pg_policies
WHERE schemaname = 'public'
ORDER BY tablename, policyname;
```

**Políticas esperadas (mínimo):**

**categories:**
- ✅ "Categories are viewable by everyone" (SELECT)

**products:**
- ✅ "Active products are viewable by everyone" (SELECT)

**user_profiles:**
- ✅ "Users can view own profile" (SELECT)
- ✅ "Users can update own profile" (UPDATE)
- ✅ "Users can insert own profile" (INSERT)

**addresses:**
- ✅ "Users can view own addresses" (SELECT)
- ✅ "Users can insert own addresses" (INSERT)
- ✅ "Users can update own addresses" (UPDATE)
- ✅ "Users can delete own addresses" (DELETE)

**orders:**
- ✅ "Users can view own orders" (SELECT)
- ✅ "Users can create own orders" (INSERT)

**order_items:**
- ✅ "Users can view own order items" (SELECT)

**cart_items:**
- ✅ "Users can view own cart" (SELECT)
- ✅ "Users can insert own cart items" (INSERT)
- ✅ "Users can update own cart items" (UPDATE)
- ✅ "Users can delete own cart items" (DELETE)

---

### 6. ⚙️ Verificar Funciones y Triggers

**Ejecuta este query:**
```sql
-- Verificar funciones
SELECT 
  routine_name,
  routine_type
FROM information_schema.routines
WHERE routine_schema = 'public'
  AND routine_name IN ('handle_updated_at', 'handle_new_user');
```

**Resultado esperado:**
- ✅ `handle_updated_at` (FUNCTION)
- ✅ `handle_new_user` (FUNCTION)

**Verificar triggers:**
```sql
SELECT 
  trigger_name,
  event_object_table,
  action_timing,
  event_manipulation
FROM information_schema.triggers
WHERE trigger_schema = 'public' 
   OR (trigger_schema = 'auth' AND trigger_name = 'on_auth_user_created')
ORDER BY event_object_table, trigger_name;
```

**Triggers esperados:**
- ✅ `set_updated_at_categories` (categories, BEFORE UPDATE)
- ✅ `set_updated_at_products` (products, BEFORE UPDATE)
- ✅ `set_updated_at_user_profiles` (user_profiles, BEFORE UPDATE)
- ✅ `set_updated_at_addresses` (addresses, BEFORE UPDATE)
- ✅ `set_updated_at_orders` (orders, BEFORE UPDATE)
- ✅ `set_updated_at_cart_items` (cart_items, BEFORE UPDATE)
- ✅ `on_auth_user_created` (auth.users, AFTER INSERT)

---

### 7. 📦 Verificar Datos Iniciales

**Ejecuta este query:**
```sql
SELECT * FROM public.categories ORDER BY name;
```

**Resultado esperado:**
- ✅ Debe haber **6 categorías**:
  1. Arreglos
  2. Girasoles
  3. Orquídeas
  4. Plantas
  5. Rosas
  6. Tulipanes

---

### 8. 🔗 Verificar Foreign Keys

**Ejecuta este query:**
```sql
SELECT
  tc.table_name,
  kcu.column_name,
  ccu.table_name AS foreign_table_name,
  ccu.column_name AS foreign_column_name
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
  ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage AS ccu
  ON ccu.constraint_name = tc.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY'
  AND tc.table_schema = 'public'
ORDER BY tc.table_name;
```

**Foreign Keys esperados:**
- ✅ `products.category_id` → `categories.id`
- ✅ `user_profiles.id` → `auth.users.id`
- ✅ `addresses.user_id` → `auth.users.id`
- ✅ `orders.user_id` → `auth.users.id`
- ✅ `orders.address_id` → `addresses.id`
- ✅ `order_items.order_id` → `orders.id`
- ✅ `order_items.product_id` → `products.id`
- ✅ `cart_items.user_id` → `auth.users.id`
- ✅ `cart_items.product_id` → `products.id`

---

### 9. 📈 Verificar Índices

**Ejecuta este query:**
```sql
SELECT
  tablename,
  indexname,
  indexdef
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;
```

**Índices esperados (mínimo):**
- ✅ `idx_products_category` (products)
- ✅ `idx_products_status` (products)
- ✅ `idx_products_featured` (products)
- ✅ `idx_orders_user` (orders)
- ✅ `idx_orders_status` (orders)
- ✅ `idx_order_items_order` (order_items)
- ✅ `idx_cart_items_user` (cart_items)
- ✅ `idx_addresses_user` (addresses)

---

### 10. 🧪 Prueba Rápida de Funcionalidad

**Ejecuta estos queries de prueba:**

#### Prueba 1: Insertar una categoría de prueba
```sql
INSERT INTO public.categories (name, description)
VALUES ('Prueba', 'Categoría de prueba')
RETURNING *;
```
**Resultado esperado:** ✅ Debe insertar sin errores

#### Prueba 2: Verificar trigger de updated_at
```sql
UPDATE public.categories 
SET description = 'Descripción actualizada'
WHERE name = 'Prueba'
RETURNING updated_at;
```
**Resultado esperado:** ✅ `updated_at` debe actualizarse automáticamente

#### Prueba 3: Limpiar datos de prueba
```sql
DELETE FROM public.categories WHERE name = 'Prueba';
```
**Resultado esperado:** ✅ Debe eliminar sin errores

---

## 🚨 Señales de ERROR (Lo que NO deberías ver)

### ❌ Errores Comunes:

1. **Error de permisos:**
   - `permission denied for schema public`
   - **Solución:** Verifica que estás usando el rol correcto

2. **Error de foreign key:**
   - `foreign key constraint fails`
   - **Solución:** Verifica que las tablas referenciadas existen

3. **Error de trigger:**
   - `trigger already exists`
   - **Solución:** El script ya maneja esto, pero si persiste, elimina manualmente

4. **Error de RLS:**
   - `new row violates row-level security policy`
   - **Solución:** Verifica que las políticas están correctamente configuradas

5. **Tablas faltantes:**
   - Si alguna tabla no aparece en Table Editor
   - **Solución:** Revisa los logs del SQL Editor para ver qué falló

---

## ✅ Checklist Final

Marca cada item cuando lo verifiques:

- [ ] Script ejecutado sin errores en SQL Editor
- [ ] Las 7 tablas aparecen en Table Editor
- [ ] Todas las tablas tienen RLS habilitado
- [ ] Las políticas de seguridad están creadas
- [ ] Las funciones `handle_updated_at` y `handle_new_user` existen
- [ ] Los triggers están creados correctamente
- [ ] Las 6 categorías iniciales están insertadas
- [ ] Los foreign keys están configurados
- [ ] Los índices están creados
- [ ] Las pruebas de inserción/actualización funcionan

---

## 🎉 Si Todo Está Correcto

Si todas las verificaciones pasan, tu base de datos está lista para:
- ✅ Autenticación de usuarios
- ✅ Gestión de productos y categorías
- ✅ Carrito de compras
- ✅ Sistema de pedidos
- ✅ Direcciones de envío

**¡Puedes empezar a desarrollar la app Flutter!** 🚀

