-- =====================================================
-- SCRIPT DE RECORDATORIOS DE EJEMPLO PARA AZZUNA
-- =====================================================

-- Insertar recordatorios de ejemplo
-- Asegúrate de que el ID del usuario exista en auth.users

INSERT INTO public.reminders (title, type, date, time, status, user_id) VALUES
  ('Reunión con cliente A', 'entrega', '2025-11-15', '10:00 AM', 'pending', (SELECT id FROM auth.users LIMIT 1)),
  ('Publicar campaña de Navidad', 'publicacion', '2025-12-01', '09:00 AM', 'pending', (SELECT id FROM auth.users LIMIT 1)),
  ('Arreglo floral para evento X', 'arreglo', '2025-11-20', '03:30 PM', 'pending', (SELECT id FROM auth.users LIMIT 1)),
  ('Recordatorio completado', 'entrega', '2025-10-25', '02:00 PM', 'completed', (SELECT id FROM auth.users LIMIT 1));
