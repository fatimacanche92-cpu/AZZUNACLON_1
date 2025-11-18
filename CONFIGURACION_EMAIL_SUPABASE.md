# 📧 Configuración de Email en Supabase

## ⚠️ Problema Actual

Si el registro dice "éxito" pero no aparece en Supabase y no se envía correo de verificación, probablemente:

1. **La confirmación de email está habilitada** pero **no hay servicio de email configurado**
2. **El usuario se crea en `auth.users`** pero **no se puede autenticar** hasta confirmar el email

## ✅ Solución: Deshabilitar Confirmación de Email (Recomendado para desarrollo)

### Paso 1: Ir a Authentication Settings

1. Ve a tu proyecto en [Supabase Dashboard](https://supabase.com/dashboard)
2. En el menú lateral, haz clic en **"Authentication"**
3. Haz clic en **"Settings"** (o "Configuración")

### Paso 2: Deshabilitar Email Confirmations

1. Busca la sección **"Email Auth"** o **"Email Authentication"**
2. Busca la opción **"Enable email confirmations"** o **"Confirm email"**
3. **DESACTÍVALA** (toggle OFF)
4. Guarda los cambios

### Paso 3: Verificar Configuración

También verifica:
- **"Enable sign ups"** debe estar **ACTIVADO** (ON)
- **"Secure email change"** puede estar desactivado para desarrollo

## 🔍 Verificar si el Usuario se Creó

### En Supabase Dashboard:

1. Ve a **"Authentication"** → **"Users"**
2. Busca el email que usaste para registrarte
3. Si aparece ahí, el usuario SÍ se creó
4. Si NO aparece, hay un problema con el registro

### Verificar en `user_profiles`:

1. Ve a **"Table Editor"** → **"user_profiles"**
2. Si el trigger funciona, deberías ver un registro con el `id` del usuario
3. Si está vacío, el trigger puede no estar funcionando

## 🐛 Debugging

### Si el usuario NO aparece en `auth.users`:

1. Revisa la consola de Flutter para ver errores
2. Verifica que las credenciales de Supabase sean correctas en `.env`
3. Verifica que la URL y la clave `anon` sean correctas

### Si el usuario SÍ aparece pero no puede hacer login:

1. Verifica que la confirmación de email esté deshabilitada
2. Intenta hacer login directamente sin confirmar email
3. Si sigue fallando, puede ser un problema de RLS (Row Level Security)

## 📝 Configuración Recomendada para Desarrollo

```
✅ Enable sign ups: ON
❌ Enable email confirmations: OFF
❌ Secure email change: OFF (para desarrollo)
✅ Enable phone signups: OFF (si no lo usas)
```

## 🚀 Después de Configurar

1. **Elimina el usuario de prueba** en Supabase (si existe)
2. **Vuelve a registrarte** desde la app
3. **Verifica** que aparezca en `auth.users`
4. **Intenta hacer login** inmediatamente después del registro

---

**Nota:** En producción, deberías tener confirmación de email habilitada y un servicio de email configurado (SendGrid, AWS SES, etc.).

