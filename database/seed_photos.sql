-- =====================================================
-- SCRIPT DE FOTOS DE EJEMPLo PARA AZZUNA
-- =====================================================

-- Insertar fotos de ejemplo
-- Asegúrate de que los IDs de los álbumes y usuarios existan

-- Fotos para el álbum 'Ramos de Rosas'
INSERT INTO public.photos (title, path, album_id, user_id) VALUES
  ('Ramo de Rosas Rojas', 'https://i.pinimg.com/originals/39/ac/be/39acbe78e34605a74d63ed4c7b87395c.jpg', (SELECT id FROM public.albums WHERE title = 'Ramos de Rosas'), (SELECT id FROM auth.users LIMIT 1)),
  ('Ramo de Rosas Rosadas', 'https://i.pinimg.com/originals/55/10/fd/5510fdee20d61c3d2eff6a3c77a24738.jpg', (SELECT id FROM public.albums WHERE title = 'Ramos de Rosas'), (SELECT id FROM auth.users LIMIT 1)),
  ('Arreglo Floral con Rosas', 'https://floreriasharon.com/wp-content/uploads/2022/09/Arreglo-Floral-Rosas-y-Gerberas-Sophie-Pink-1200x1716.jpg', (SELECT id FROM public.albums WHERE title = 'Ramos de Rosas'), (SELECT id FROM auth.users LIMIT 1));

-- Fotos para el álbum 'Bodas 2024'
INSERT INTO public.photos (title, path, album_id, user_id) VALUES
  ('Decoración de Boda', 'https://i.pinimg.com/originals/ee/8f/5f/ee8f5f85596d7851ddc17b630f655781.jpg', (SELECT id FROM public.albums WHERE title = 'Bodas 2024'), (SELECT id FROM auth.users LIMIT 1)),
  ('Ramo de Novia', 'https://th.bing.com/th/id/R.32203bc7a8d188bde72359a9f6263cc1?rik=1FAvdQwH74PwUw&pid=ImgRaw&r=0', (SELECT id FROM public.albums WHERE title = 'Bodas 2024'), (SELECT id FROM auth.users LIMIT 1)),
  ('Centros de Mesa', 'https://i.pinimg.com/originals/a9/b6/89/a9b6893357eadb78fbbdf1571c2dcbf5.jpg', (SELECT id FROM public.albums WHERE title = 'Bodas 2024'), (SELECT id FROM auth.users LIMIT 1));

-- Fotos para el álbum 'Arreglos de Girasoles'
INSERT INTO public.photos (title, path, album_id, user_id) VALUES
  ('Girasoles en Jarrón', 'https://superadmin.com.co/darlingflowersimg/Arreglos.jpeg', (SELECT id FROM public.albums WHERE title = 'Arreglos de Girasoles'), (SELECT id FROM auth.users LIMIT 1)),
  ('Arreglo Puka', 'https://www.kukyflor.com/8477-large_default/arreglo-puka.jpg', (SELECT id FROM public.albums WHERE title = 'Arreglos de Girasoles'), (SELECT id FROM auth.users LIMIT 1));

-- Fotos para el álbum 'Nuevas Orquídeas'
INSERT INTO public.photos (title, path, album_id, user_id) VALUES
  ('Orquídea Blanca', 'https://i.pinimg.com/originals/d2/a7/65/d2a7652fca277770a4ef22a1d17acf50.jpg', (SELECT id FROM public.albums WHERE title = 'Nuevas Orquídeas'), (SELECT id FROM auth.users LIMIT 1));

-- Fotos sin álbum (pueden ser asignadas a borradores o un álbum general)
INSERT INTO public.photos (title, path, user_id) VALUES
  ('Arreglo Floral Femenino', 'https://editarfotosonline.net/wp-content/uploads/2024/06/nombres-femeninos-en-un-arreglo-floral-con-rosas-rojas-u-tulipanes-18.jpg', (SELECT id FROM auth.users LIMIT 1)),
  ('Foto de Blogger', 'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiL-DUZIZcAlb9yIwAc9OQL0N32N8LFRM3Rful1EYBZsoWjLLDRAdwnMw2U2DlSxE9xk96xE5rOydBS_QbLb7AMVLWjCEWSTnqwFub5n-Y7igR76Z8HHXSKzHOK6PlzvXHyY0vEfiyHU3IzBMlfhG8F-qaiKOd6BLK291YLQHz52bt4LVoadk6_vkEm4mU/s960/IMG_4909.jpeg', (SELECT id FROM auth.users LIMIT 1)),
  ('Regal Candelabra', 'https://th.bing.com/th/id/R.8d9006645107307064bfd612b4398f07?rik=IbmjqaSWCjuw9w&riu=http%3a%2f%2fwww.regalcandelabra.com%2fuploads%2ff4418f9b9bc74f594e8999374e406e1c.jpg&ehk=9TDdOyn%2fTu0o7NzvvIoV7sU6x9eKCRjJunGKgY24tqE%3d&risl=&pid=ImgRaw&r=0', (SELECT id FROM auth.users LIMIT 1)),
  ('Arreglo Floral 1', 'https://i.pinimg.com/1200x/df/49/0d/df490da497408305af50b63c4504a750.jpg', (SELECT id FROM auth.users LIMIT 1)),
  ('Arreglo Floral 2', 'https://i.pinimg.com/736x/93/de/cf/93decf847abb5c158476b7d2b5185308.jpg', (SELECT id FROM auth.users LIMIT 1)),
  ('Arreglo Floral 3', 'https://i.pinimg.com/1200x/c1/c3/5c/c1c35c492f08d0f735faa85ac1ac3cb2.jpg', (SELECT id FROM auth.users LIMIT 1)),
  ('Arreglo Floral 4', 'https://i.pinimg.com/1200x/55/ee/e8/55eee8bad7ae35a96906c575aaed1c71.jpg', (SELECT id FROM auth.users LIMIT 1)),
  ('Arreglo Floral 5', 'https://i.pinimg.com/1200x/0c/48/d0/0c48d07ccef33ae2a2bafecc8989f6f7.jpg', (SELECT id FROM auth.users LIMIT 1)),
  ('Arreglo Floral 6', 'https://i.pinimg.com/736x/83/4b/3c/834b3c3ec0121fec36d720ce0a8055db.jpg', (SELECT id FROM auth.users LIMIT 1)),
  ('Arreglo Floral 7', 'https://i.pinimg.com/736x/dd/22/57/dd225755fd3d11d4fad6591dc80a1cd2.jpg', (SELECT id FROM auth.users LIMIT 1)),
  ('Arreglo Floral 8', 'https://i.pinimg.com/736x/e1/2e/19/e12e194c865eb779b9b870e1332845cb.jpg', (SELECT id FROM auth.users LIMIT 1));
