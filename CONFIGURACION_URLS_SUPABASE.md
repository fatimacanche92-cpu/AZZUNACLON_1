# 🔗 Configuración de URLs en Supabase para Azzuna

## ❌ Problema Actual

Tienes configurado:
- **Site URL**: `io.supabase.flutterquickstart` (❌ Es de un ejemplo)
- **Redirect URL**: `io.supabase.flutterquickstart://login-callback` (❌ Es de un ejemplo)

Esto **NO funcionará** con tu app Azzuna.

---

## ✅ Configuración Correcta

### Paso 1: Site URL

En **Authentication** → **URL Configuration** → **Site URL**:

**Opción A (Recomendada para desarrollo):**
```
https://vpkmovjyxwoiqrtknyvx.supabase.co
```

**Opción B (Si tienes dominio propio):**
```
https://tu-dominio.com
```

---

### Paso 2: Redirect URLs

En **Authentication** → **URL Configuration** → **Redirect URLs**, agrega estas URLs:

#### Para Android:
```
com.example.flutter_app://login-callback
```

#### Para iOS (si usas el bundle ID por defecto):
```
com.example.flutterApp://login-callback
```

#### URL de callback de Supabase (importante):
```
https://vpkmovjyxwoiqrtknyvx.supabase.co/auth/v1/callback
```

#### Opción alternativa con esquema personalizado:
```
azzuna://auth/callback
```

---

## 📝 Pasos a Seguir

1. **Ve a Supabase Dashboard** → **Authentication** → **URL Configuration**

2. **Cambia el Site URL:**
   - Borra: `io.supabase.flutterquickstart`
   - Escribe: `https://vpkmovjyxwoiqrtknyvx.supabase.co`
   - Haz clic en **"Save changes"**

3. **Elimina la Redirect URL antigua:**
   - Haz clic en la "X" del tag `io.supabase.flutterquickstart://login-callback`

4. **Agrega las nuevas Redirect URLs:**
   - Haz clic en **"Add URL"**
   - Agrega: `com.example.flutter_app://login-callback`
   - Haz clic en **"Add URL"** de nuevo
   - Agrega: `https://vpkmovjyxwoiqrtknyvx.supabase.co/auth/v1/callback`
   - Haz clic en **"Save changes"**

---

## 🎯 Resultado Final

Deberías tener:

**Site URL:**
```
https://vpkmovjyxwoiqrtknyvx.supabase.co
```

**Redirect URLs (2 URLs):**
1. `com.example.flutter_app://login-callback`
2. `https://vpkmovjyxwoiqrtknyvx.supabase.co/auth/v1/callback`

---

## ⚠️ Nota Importante

Si cambias el **package name** de tu app Android o el **bundle identifier** de iOS, deberás actualizar las Redirect URLs en Supabase para que coincidan.

**Package name actual de tu app:** `com.example.flutter_app` (Android)

---

## 🧪 Cómo Probar

1. Registra un nuevo usuario desde tu app
2. Revisa tu correo electrónico
3. Haz clic en el enlace de verificación
4. Debería redirigir correctamente a tu app o a una página de confirmación

---

## 📱 Deep Linking (Opcional - Para Mejor Experiencia)

Si quieres que el enlace del email abra directamente tu app, necesitarás configurar deep linking en tu app Flutter. Esto es opcional pero mejora la experiencia del usuario.

**Esquema recomendado:** `azzuna://auth/callback`

