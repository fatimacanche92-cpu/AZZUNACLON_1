-- =====================================================
-- SCRIPT DE DATOS DE EJEMPLO PARA AZZUNA
-- =====================================================

-- Insertar álbumes de ejemplo
INSERT INTO public.albums (title, type, status, user_id) VALUES
  ('Ramos de Rosas', 'catalogo', 'completo', (SELECT id FROM auth.users LIMIT 1)),
  ('Bodas 2024', 'catalogo', 'completo', (SELECT id FROM auth.users LIMIT 1)),
  ('Arreglos de Girasoles', 'borrador', 'incompleto', (SELECT id FROM auth.users LIMIT 1)),
  ('Nuevas Orquídeas', 'borrador', 'faltan_imagenes', (SELECT id FROM auth.users LIMIT 1));
