# 📧 Configuración de Verificación de Email en Supabase

## 🔧 Paso 1: Configurar Servicio de Email en Supabase

### Opción A: Usar el servicio de email de Supabase (Gratis, limitado)

1. Ve a tu proyecto en [Supabase Dashboard](https://supabase.com/dashboard)
2. Ve a **"Authentication"** → **"Settings"** → **"Emails"**
3. Verifica que **"Enable email confirmations"** esté **ACTIVADO** (ON)
4. El servicio gratuito de Supabase tiene límites:
   - **4 emails por hora** por usuario
   - **Solo para desarrollo/testing**

### Opción B: Configurar un servicio de email externo (Recomendado para producción)

#### Usando SendGrid (Recomendado):

1. Crea una cuenta en [SendGrid](https://sendgrid.com/)
2. Obtén tu **API Key** de SendGrid
3. En Supabase Dashboard:
   - Ve a **"Settings"** → **"Auth"** → **"SMTP Settings"**
   - Configura:
     - **Host**: `smtp.sendgrid.net`
     - **Port**: `587`
     - **Username**: `apikey`
     - **Password**: Tu API Key de SendGrid
     - **Sender email**: Tu email verificado en SendGrid
     - **Sender name**: `Azzuna`

#### Usando AWS SES:

1. Configura AWS SES y verifica tu dominio
2. Obtén tus credenciales SMTP
3. Configura en Supabase con las credenciales de AWS SES

#### Usando Resend (Alternativa moderna):

1. Crea cuenta en [Resend](https://resend.com/)
2. Obtén tu API Key
3. Configura SMTP en Supabase con las credenciales de Resend

---

## ✅ Paso 2: Habilitar Confirmación de Email

1. Ve a **"Authentication"** → **"Settings"** → **"Sign In / Providers"**
2. Busca **"Confirm email"** en la sección "User Signups"
3. **ACTÍVALO** (toggle ON)
4. Haz clic en **"Save changes"**

---

## 📝 Paso 3: Configurar Plantillas de Email (Opcional)

1. Ve a **"Authentication"** → **"Settings"** → **"Emails"**
2. Puedes personalizar:
   - **Confirm signup**: Email de confirmación
   - **Magic Link**: Si usas magic links
   - **Change Email Address**: Cambio de email
   - **Reset Password**: Recuperación de contraseña

### Plantilla de Confirmación Recomendada:

```
Bienvenido a Azzuna!

Por favor confirma tu correo electrónico haciendo clic en el siguiente enlace:

{{ .ConfirmationURL }}

Si no solicitaste esta cuenta, puedes ignorar este correo.

¡Gracias!
El equipo de Azzuna
```

---

## 🔍 Paso 4: Verificar Configuración

1. **Prueba el registro** desde tu app
2. **Revisa tu bandeja de entrada** (y spam)
3. **Haz clic en el enlace de confirmación**
4. **Intenta hacer login** - debería funcionar ahora

---

## ⚠️ Notas Importantes

### Límites del Plan Gratuito de Supabase:
- **4 emails por hora** por usuario
- Solo para desarrollo/testing
- Para producción, usa un servicio externo (SendGrid, AWS SES, Resend)

### Testing Local:
- Puedes usar servicios como [Mailtrap](https://mailtrap.io/) para desarrollo
- O usar el email de prueba de Supabase (limitado)

### Producción:
- **NUNCA** uses el servicio gratuito de Supabase en producción
- Configura siempre un servicio de email externo
- Verifica tu dominio para mejor deliverability

---

## 🐛 Troubleshooting

### El correo no llega:
1. Verifica que "Confirm email" esté activado
2. Revisa la carpeta de spam
3. Verifica los límites de email (4/hora en plan gratuito)
4. Revisa los logs en Supabase Dashboard → Logs

### El enlace de confirmación no funciona:
1. Verifica que la URL de redirección esté configurada en Supabase
2. Ve a **"Authentication"** → **"URL Configuration"**
3. Configura **"Site URL"** y **"Redirect URLs"**

---

## 📱 Configuración de URLs de Redirección

En **"Authentication"** → **"URL Configuration"**:

- **Site URL**: `https://tu-dominio.com` (o tu app URL)
- **Redirect URLs**: Agrega:
  - `https://tu-dominio.com/auth/callback`
  - `myapp://auth/callback` (para deep linking en móvil)

---

**Después de configurar esto, el código de Flutter manejará automáticamente la verificación de email.**

