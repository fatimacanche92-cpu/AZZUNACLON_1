-- ===========================================
-- PARCHE AZZUNA: PERFIL + CALENDARIO + ÁLBUMES
-- NO TOCA products / categories / orders ya existentes
-- ===========================================

-- 1. DESACTIVAR RLS Y ELIMINAR TABLAS VIEJAS (si existen)
ALTER TABLE IF EXISTS public.reminders DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS public.albums DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS public.photos DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS public.notifications DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS public.profiles DISABLE ROW LEVEL SECURITY;

DROP TABLE IF EXISTS public.reminders CASCADE;
DROP TABLE IF EXISTS public.albums CASCADE;
DROP TABLE IF EXISTS public.photos CASCADE;
DROP TABLE IF EXISTS public.notifications CASCADE;
DROP TABLE IF EXISTS public.profiles CASCADE;

-- Eliminar funciones viejas de perfil/updated_at para recrearlas limpias
DROP FUNCTION IF EXISTS public.handle_new_user() CASCADE;
DROP FUNCTION IF EXISTS public.handle_updated_at() CASCADE;

-- Eliminar tipos ENUM viejos relacionados con recordatorios/álbumes
DROP TYPE IF EXISTS public.reminder_type CASCADE;
DROP TYPE IF EXISTS public.reminder_status CASCADE;
DROP TYPE IF EXISTS public.album_type CASCADE;

-- Asegurar extensión para UUID
CREATE EXTENSION IF NOT EXISTS "pgcrypto";


-- ===========================================
-- 2. TIPOS ENUM NUEVOS
-- ===========================================

-- Tipo para tipo de recordatorio (calendario)
CREATE TYPE public.reminder_type AS ENUM (
  'pedido',
  'entrega',
  'publicacion'
);

-- Estado del recordatorio (pendiente / completado)
CREATE TYPE public.reminder_status AS ENUM (
  'pending',
  'completed'
);

-- Tipo de álbum (borrador vs catálogo)
CREATE TYPE public.album_type AS ENUM (
  'borrador',
  'catalogo'
);


-- ===========================================
-- 3. TABLA DE PERFIL (PERFIL DE USUARIO / FLORERÍA)
-- ===========================================

CREATE TABLE public.profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  full_name TEXT,                    -- nombre del usuario
  shop_name TEXT,                    -- nombre de la florería
  email TEXT,                        -- email (solo lectura, viene de auth)
  phone TEXT,                        -- teléfono
  address TEXT,                      -- ubicación
  schedule TEXT,                     -- horario de atención
  shop_description TEXT,             -- descripción del negocio
  social_links JSONB,                -- redes sociales (facebook, insta, etc.)
  avatar_url TEXT,                   -- foto de perfil
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);


-- ===========================================
-- 4. TABLA DE RECORDATORIOS (CALENDARIO DE PEDIDOS)
-- ===========================================

CREATE TABLE public.reminders (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,

  -- Datos del cliente
  client_name TEXT NOT NULL,
  client_phone TEXT,
  client_address TEXT,

  -- Pagos
  has_paid BOOLEAN DEFAULT FALSE,          -- ya pagó todo
  advance_amount NUMERIC(10,2) DEFAULT 0,  -- anticipo
  remaining_amount NUMERIC(10,2) DEFAULT 0,-- lo que falta

  -- Nota / anonimato
  is_anonymous BOOLEAN DEFAULT FALSE,      -- si es anónimo
  note TEXT,                               -- mensaje / nota del arreglo

  -- Datos del producto (arreglo de flores)
  product_size TEXT,                       -- tamaño
  product_price NUMERIC(10,2),             -- precio
  product_color TEXT,                      -- color principal
  product_flowers TEXT,                    -- tipo(s) de flores (texto libre)
  product_customization TEXT,              -- especificaciones especiales

  -- Clasificación del recordatorio
  reminder_type public.reminder_type NOT NULL, -- pedido / entrega / publicacion

  -- Fecha/hora de entrega o publicación
  reminder_datetime TIMESTAMPTZ NOT NULL,

  status public.reminder_status DEFAULT 'pending',

  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);


-- ===========================================
-- 5. TABLA DE ÁLBUMES (BORRADORES / CATÁLOGOS)
-- ===========================================

CREATE TABLE public.albums (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  title TEXT NOT NULL,               -- título del álbum
  description TEXT,                  -- descripción
  album_type public.album_type NOT NULL DEFAULT 'borrador', -- borrador/catalogo
  status TEXT DEFAULT 'incompleto',  -- incompleto / en_revision / completo / pendiente_subir
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);


-- ===========================================
-- 6. TABLA DE FOTOS (CONTENIDO DE LOS ÁLBUMES)
-- ===========================================

CREATE TABLE public.photos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  album_id UUID REFERENCES public.albums(id) ON DELETE CASCADE,
  title TEXT,
  image_url TEXT NOT NULL,           -- URL pública de la foto
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);


-- ===========================================
-- 7. TABLA DE NOTIFICACIONES (PEDIDOS PENDIENTES, ALERTAS)
-- ===========================================

CREATE TABLE public.notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  title TEXT NOT NULL,
  message TEXT NOT NULL,
  is_read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT now()
);


-- ===========================================
-- 8. FUNCIONES Y TRIGGERS
-- ===========================================

-- Función updated_at genérica
CREATE OR REPLACE FUNCTION public.handle_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para updated_at
CREATE TRIGGER trg_profiles_updated_at
BEFORE UPDATE ON public.profiles
FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER trg_reminders_updated_at
BEFORE UPDATE ON public.reminders
FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER trg_albums_updated_at
BEFORE UPDATE ON public.albums
FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER trg_photos_updated_at
BEFORE UPDATE ON public.photos
FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

-- Crear perfil automáticamente cuando se registra un usuario
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name, email)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.email),
    NEW.email
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
AFTER INSERT ON auth.users
FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


-- ===========================================
-- 9. RLS Y POLÍTICAS
-- ===========================================

-- Habilitar RLS
ALTER TABLE public.profiles      ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.reminders     ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.albums        ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.photos        ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

-- PROFILES: ver / editar solo su propio perfil
CREATE POLICY "profiles_select_own"
ON public.profiles FOR SELECT
USING (auth.uid() = id);

CREATE POLICY "profiles_update_own"
ON public.profiles FOR UPDATE
USING (auth.uid() = id)
WITH CHECK (auth.uid() = id);

CREATE POLICY "profiles_insert_own"
ON public.profiles FOR INSERT
WITH CHECK (auth.uid() = id);


-- REMINDERS: cada usuario ve y gestiona sus recordatorios
CREATE POLICY "reminders_select_own"
ON public.reminders FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "reminders_insert_own"
ON public.reminders FOR INSERT
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "reminders_update_own"
ON public.reminders FOR UPDATE
USING (auth.uid() = user_id)
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "reminders_delete_own"
ON public.reminders FOR DELETE
USING (auth.uid() = user_id);


-- ALBUMS: solo el dueño
CREATE POLICY "albums_select_own"
ON public.albums FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "albums_insert_own"
ON public.albums FOR INSERT
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "albums_update_own"
ON public.albums FOR UPDATE
USING (auth.uid() = user_id)
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "albums_delete_own"
ON public.albums FOR DELETE
USING (auth.uid() = user_id);


-- PHOTOS: solo el dueño
CREATE POLICY "photos_select_own"
ON public.photos FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "photos_insert_own"
ON public.photos FOR INSERT
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "photos_update_own"
ON public.photos FOR UPDATE
USING (auth.uid() = user_id)
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "photos_delete_own"
ON public.photos FOR DELETE
USING (auth.uid() = user_id);


-- NOTIFICATIONS: por usuario
CREATE POLICY "notifications_select_own"
ON public.notifications FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "notifications_insert_own"
ON public.notifications FOR INSERT
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "notifications_update_own"
ON public.notifications FOR UPDATE
USING (auth.uid() = user_id)
WITH CHECK (auth.uid() = user_id);


-- ===========================================
-- 10. STORAGE: AVATARES Y FOTOS DE ÁLBUM
-- ===========================================

-- Buckets (si no existen)
INSERT INTO storage.buckets (id, name, public)
VALUES ('avatars', 'avatars', TRUE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO storage.buckets (id, name, public)
VALUES ('gallery_photos', 'gallery_photos', TRUE)
ON CONFLICT (id) DO NOTHING;

-- Limpiar políticas previas del storage
DROP POLICY IF EXISTS "Avatar images are publicly accessible." ON storage.objects;
DROP POLICY IF EXISTS "Authenticated users can upload an avatar." ON storage.objects;
DROP POLICY IF EXISTS "Authenticated users can delete their own avatar." ON storage.objects;
DROP POLICY IF EXISTS "Authenticated users can update their own avatar." ON storage.objects;

DROP POLICY IF EXISTS "Gallery photos are publicly accessible." ON storage.objects;
DROP POLICY IF EXISTS "Authenticated users can upload gallery photos." ON storage.objects;
DROP POLICY IF EXISTS "Authenticated users can delete their own gallery photos." ON storage.objects;
DROP POLICY IF EXISTS "Authenticated users can update their own gallery photos." ON storage.objects;

-- Políticas AVATARS
CREATE POLICY "Avatar images are publicly accessible."
ON storage.objects FOR SELECT
USING (bucket_id = 'avatars');

CREATE POLICY "Authenticated users can upload an avatar."
ON storage.objects FOR INSERT TO authenticated
WITH CHECK (bucket_id = 'avatars');

CREATE POLICY "Authenticated users can delete their own avatar."
ON storage.objects FOR DELETE TO authenticated
USING (bucket_id = 'avatars' AND auth.uid() = owner);

CREATE POLICY "Authenticated users can update their own avatar."
ON storage.objects FOR UPDATE TO authenticated
USING (bucket_id = 'avatars' AND auth.uid() = owner)
WITH CHECK (bucket_id = 'avatars');

-- Políticas GALLERY_PHOTOS
CREATE POLICY "Gallery photos are publicly accessible."
ON storage.objects FOR SELECT
USING (bucket_id = 'gallery_photos');

CREATE POLICY "Authenticated users can upload gallery photos."
ON storage.objects FOR INSERT TO authenticated
WITH CHECK (bucket_id = 'gallery_photos');

CREATE POLICY "Authenticated users can delete their own gallery photos."
ON storage.objects FOR DELETE TO authenticated
USING (bucket_id = 'gallery_photos' AND auth.uid() = owner);

CREATE POLICY "Authenticated users can update their own gallery photos."
ON storage.objects FOR UPDATE TO authenticated
USING (bucket_id = 'gallery_photos' AND auth.uid() = owner)
WITH CHECK (bucket_id = 'gallery_photos');
