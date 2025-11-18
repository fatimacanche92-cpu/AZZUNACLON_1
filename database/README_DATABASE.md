# 🗄️ Base de Datos Azzuna - Guía de Configuración

## 📋 Instrucciones para Ejecutar el Script SQL

### Paso 1: Acceder al SQL Editor de Supabase

1. Ve a tu proyecto en [Supabase Dashboard](https://supabase.com/dashboard)
2. En el menú lateral, haz clic en **"SQL Editor"**
3. Haz clic en **"New query"**

### Paso 2: Ejecutar el Script

1. Abre el archivo `database/setup_azzuna_database.sql`
2. **Copia TODO el contenido** del archivo
3. Pégalo en el editor SQL de Supabase
4. Haz clic en **"Run"** o presiona `Ctrl+Enter` (Windows) / `Cmd+Enter` (Mac)

### Paso 3: Verificar la Creación

1. Ve a **"Table Editor"** en el menú lateral
2. Deberías ver las siguientes tablas:
   - ✅ `categories`
   - ✅ `products`
   - ✅ `user_profiles`
   - ✅ `addresses`
   - ✅ `orders`
   - ✅ `order_items`
   - ✅ `cart_items`

---

## 📊 Estructura de la Base de Datos

### Tablas Principales

#### 1. **categories** - Categorías de flores
- `id` (UUID)
- `name` (VARCHAR) - Nombre de la categoría
- `description` (TEXT)
- `image_url` (TEXT)
- `created_at`, `updated_at`

#### 2. **products** - Productos (flores)
- `id` (UUID)
- `name` (VARCHAR) - Nombre del producto
- `description` (TEXT)
- `price` (DECIMAL) - Precio
- `category_id` (UUID) - Referencia a categoría
- `image_url` (TEXT) - Imagen principal
- `images` (TEXT[]) - Array de imágenes adicionales
- `stock_quantity` (INTEGER) - Cantidad en stock
- `status` (ENUM) - active, inactive, out_of_stock
- `featured` (BOOLEAN) - Producto destacado
- `created_at`, `updated_at`

#### 3. **user_profiles** - Perfiles de usuario
- `id` (UUID) - Referencia a auth.users
- `full_name` (VARCHAR)
- `phone` (VARCHAR)
- `avatar_url` (TEXT)
- `created_at`, `updated_at`

#### 4. **addresses** - Direcciones de envío
- `id` (UUID)
- `user_id` (UUID) - Referencia a auth.users
- `label` (VARCHAR) - Casa, Trabajo, etc.
- `recipient_name` (VARCHAR)
- `phone` (VARCHAR)
- `street`, `city`, `state`, `postal_code`, `country`
- `is_default` (BOOLEAN)
- `created_at`, `updated_at`

#### 5. **orders** - Pedidos
- `id` (UUID)
- `user_id` (UUID) - Referencia a auth.users
- `address_id` (UUID) - Referencia a addresses
- `status` (ENUM) - pending, confirmed, preparing, shipped, delivered, cancelled
- `total_amount` (DECIMAL)
- `shipping_cost` (DECIMAL)
- `notes` (TEXT)
- `delivered_at` (TIMESTAMP)
- `created_at`, `updated_at`

#### 6. **order_items** - Items de pedido
- `id` (UUID)
- `order_id` (UUID) - Referencia a orders
- `product_id` (UUID) - Referencia a products
- `quantity` (INTEGER)
- `unit_price` (DECIMAL)
- `subtotal` (DECIMAL)
- `created_at`

#### 7. **cart_items** - Carrito de compras
- `id` (UUID)
- `user_id` (UUID) - Referencia a auth.users
- `product_id` (UUID) - Referencia a products
- `quantity` (INTEGER)
- `created_at`, `updated_at`

---

## 🔒 Seguridad (RLS)

Todas las tablas tienen **Row Level Security (RLS)** habilitado con las siguientes políticas:

- **Categorías y Productos**: Lectura pública (todos pueden ver)
- **Perfiles de Usuario**: Solo el usuario puede ver/editar su propio perfil
- **Direcciones**: Solo el usuario puede gestionar sus direcciones
- **Pedidos**: Solo el usuario puede ver/crear sus propios pedidos
- **Carrito**: Solo el usuario puede gestionar su propio carrito

---

## 🔄 Funciones Automáticas

### 1. **Actualización automática de `updated_at`**
Todas las tablas actualizan automáticamente el campo `updated_at` cuando se modifica un registro.

### 2. **Creación automática de perfil**
Cuando un usuario se registra en `auth.users`, se crea automáticamente un perfil en `user_profiles`.

---

## 📝 Datos Iniciales

El script inserta 6 categorías de ejemplo:
- Rosas
- Tulipanes
- Girasoles
- Orquídeas
- Arreglos
- Plantas

---

## ⚠️ Advertencias

1. **Este script ELIMINA todas las tablas existentes** en el esquema `public`
2. Si tienes datos importantes, haz un backup antes de ejecutar
3. El script NO afecta la tabla `auth.users` ni otras tablas del sistema

---

## 🧪 Pruebas

Después de ejecutar el script, puedes probar:

1. **Crear un usuario** desde la app Flutter
2. **Verificar que se creó el perfil** automáticamente
3. **Insertar productos de prueba** desde el Table Editor de Supabase
4. **Probar el carrito** desde la app

---

## 📚 Recursos Adicionales

- [Documentación de Supabase RLS](https://supabase.com/docs/guides/auth/row-level-security)
- [Guía de SQL de Supabase](https://supabase.com/docs/guides/database)

