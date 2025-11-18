# Flutter App

Aplicación Flutter profesional desarrollada con arquitectura limpia, Supabase como backend y mejores prácticas de desarrollo móvil.

## 🚀 Características

- ✅ Arquitectura limpia y escalable
- ✅ Integración con Supabase
- ✅ State Management con Riverpod
- ✅ Routing con GoRouter
- ✅ Manejo de variables de entorno
- ✅ Almacenamiento seguro
- ✅ Logging profesional
- ✅ Código generado con Freezed y JSON Serializable

## 📋 Requisitos Previos

- Flutter SDK (versión 3.9.2 o superior)
- Dart SDK
- Cuenta de Supabase (para backend)

## 🛠️ Configuración

1. **Clonar el repositorio**
   ```bash
   git clone <repository-url>
   cd flutter_app
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Configurar variables de entorno**
   - Copia el archivo `.env.example` a `.env`
   - Completa las variables con tus credenciales de Supabase:
     ```env
     SUPABASE_URL=tu_url_de_supabase
     SUPABASE_ANON_KEY=tu_clave_anonima_de_supabase
     ```

4. **Generar código (si es necesario)**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

## 🏗️ Estructura del Proyecto

```
lib/
├── core/                 # Código core de la aplicación
│   ├── constants/        # Constantes de la app
│   ├── config/           # Configuración
│   ├── utils/            # Utilidades
│   ├── theme/            # Tema de la aplicación
│   ├── errors/           # Manejo de errores
│   └── widgets/          # Widgets reutilizables
├── features/             # Módulos de funcionalidades
│   └── [feature_name]/
│       ├── data/
│       ├── domain/
│       └── presentation/
├── shared/               # Código compartido
│   ├── providers/        # Providers globales
│   ├── models/           # Modelos compartidos
│   ├── services/         # Servicios compartidos
│   └── widgets/          # Widgets compartidos
└── main.dart            # Punto de entrada
```

## 🚦 Ejecutar la Aplicación

```bash
# Desarrollo
flutter run

# Build para Android
flutter build apk

# Build para iOS
flutter build ios

# Build para Web
flutter build web
```

## 📦 Dependencias Principales

- **flutter_riverpod**: State management
- **supabase_flutter**: Backend y autenticación
- **go_router**: Navegación
- **flutter_dotenv**: Variables de entorno
- **dio**: Cliente HTTP
- **freezed**: Inmutabilidad y código generado
- **logger**: Sistema de logging

## 🧪 Testing

```bash
# Ejecutar todos los tests
flutter test

# Ejecutar tests con cobertura
flutter test --coverage
```

## 📝 Convenciones de Código

- Seguir las guías de estilo de Flutter
- Usar `flutter analyze` para verificar el código
- Escribir tests para funcionalidades críticas
- Documentar funciones públicas

## 🤝 Contribuir

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT.

## 👨‍💻 Autor

Desarrollado con ❤️ usando Flutter
