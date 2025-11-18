# 🔐 Configuración de Supabase - Explicación Detallada

## 📋 Claves y su Uso

### ✅ Clave ANON (anon public) - **EN USO**
**Valor:** `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...` (la que me pasaste)

**Dónde se usa:**
- ✅ En `lib/core/config/app_config.dart` → `AppConfig.supabaseAnonKey`
- ✅ En `lib/shared/services/supabase_service.dart` → línea 19: `anonKey: AppConfig.supabaseAnonKey`
- ✅ Se inicializa Supabase con esta clave en `main.dart`

**Propósito:**
- Autenticación de usuarios (login, registro)
- Operaciones que respetan Row Level Security (RLS)
- **SEGURA** para usar en aplicaciones móviles

**Estado:** ✅ **CONFIGURADA Y EN USO**

---

### ⚠️ Clave SERVICE_ROLE (service_role secret) - **NO SE USA EN LA APP**
**Valor:** `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...` (la que me pasaste)

**Por qué NO la puse en el código:**
- ❌ **RIESGO DE SEGURIDAD**: Esta clave puede bypassear Row Level Security (RLS)
- ❌ **NUNCA** debe estar en código de aplicación móvil
- ❌ Si alguien la obtiene, puede acceder a TODOS los datos sin restricciones

**Cuándo usarla:**
- ✅ Solo en **backends seguros** (servidores, funciones serverless)
- ✅ Para operaciones administrativas
- ✅ Para migraciones de datos
- ✅ En Edge Functions de Supabase

**Estado:** ⚠️ **NO CONFIGURADA (por seguridad)**

---

## 🌐 URL de Supabase - **EXTRAÍDA Y CONFIGURADA**

**Cómo la obtuve:**
- Del JWT de tu clave anon, extraje el `ref` (proyecto ID): `vpkmovjyxwoiqrtknyvx`
- Construí la URL: `https://vpkmovjyxwoiqrtknyvx.supabase.co`

**Dónde se usa:**
- ✅ En `lib/core/config/app_config.dart` → `AppConfig.supabaseUrl`
- ✅ En `lib/shared/services/supabase_service.dart` → línea 18: `url: AppConfig.supabaseUrl`

**Estado:** ✅ **CONFIGURADA Y EN USO**

---

## 📝 Archivo .env Requerido

Crea el archivo `.env` en la raíz del proyecto con:

```env
# Supabase Configuration
SUPABASE_URL=https://vpkmovjyxwoiqrtknyvx.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZwa21vdmp5eHdvaXFydGtueXZ4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjIyNjkzMjYsImV4cCI6MjA3Nzg0NTMyNn0.vGwbuZBIFZ0PPLZ2ZKzpKp2m6D7YJwHl6AJm42ORngg

# App Configuration
APP_NAME=Azzuna
APP_ENV=development
```

---

## 🔍 Verificación del Flujo

1. **main.dart** carga el `.env`
2. **AppConfig** lee `SUPABASE_URL` y `SUPABASE_ANON_KEY`
3. **SupabaseService.initialize()** usa ambas para inicializar Supabase
4. **LoginProvider** usa `SupabaseService.client` para autenticación

---

## ✅ Resumen

| Recurso | Estado | Uso |
|---------|--------|-----|
| **URL de Supabase** | ✅ Configurada | Extraída del JWT, usada en inicialización |
| **Clave ANON** | ✅ Configurada | Usada para autenticación en la app |
| **Clave SERVICE_ROLE** | ⚠️ No configurada | **Correcto** - No debe ir en app móvil |

**Todo está correctamente configurado para la aplicación móvil.** 🎉

