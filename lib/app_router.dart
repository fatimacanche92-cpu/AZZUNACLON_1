import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// New Feature Screens
import 'features/home/presentation/pages/home_page.dart';
import 'features/orders/presentation/pages/shipping_orders_page.dart';
import 'features/orders/presentation/pages/pickup_orders_page.dart';
import 'features/orders/presentation/pages/order_details_page.dart';
import 'features/orders/domain/models/order_model.dart'; // Import OrderModel

// Missing Imports
import 'features/gallery/gallery_screen.dart';
import 'features/gallery/album_screen.dart';
import 'features/encargo/encargo_home.dart';
import 'features/encargo/arreglo/arreglo_screen.dart';
import 'features/encargo/entrega/entrega_screen.dart';
import 'features/encargo/destinatario/destinatario_screen.dart';
import 'features/encargo/pago/pago_screen.dart';

// Existing Screens (assuming paths)
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/register_page.dart';
import 'features/auth/presentation/pages/email_verification_page.dart';
import 'features/home/presentation/pages/welcome_page.dart';
import 'features/settings/presentation/pages/profile_page.dart';
import 'features/drafts/presentation/pages/drafts_page.dart';
import 'features/catalogs/presentation/pages/catalogs_page.dart';
// NOTE: Some old pages might be replaced by the new screens.

final appRouter = GoRouter(
  initialLocation: '/login', // Start of the app
  routes: [
    // Auth Flow (Kept as is)
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/email-verification',
      builder: (context, state) {
        // You might need to adjust how you pass arguments with go_router
        final email = state.extra as String? ?? 'no-email@example.com';
        return EmailVerificationPage(email: email);
      },
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomePage(),
    ),

    // New Internal App Structure
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(), // This is the new Home
    ),
    GoRoute(
      path: '/shipping-orders',
      builder: (context, state) => const ShippingOrdersPage(),
    ),
    GoRoute(
      path: '/pickup-orders',
      builder: (context, state) => const PickupOrdersPage(),
    ),
    GoRoute(
      path: '/order-details',
      builder: (context, state) {
        final order = state.extra as OrderModel;
        return OrderDetailsPage(order: order);
      },
    ),
    GoRoute(
      path: '/gallery',
      builder: (context, state) => const GalleryScreen(), // New Gallery
      routes: [
        GoRoute(
          path: 'album/:id',
          builder: (context, state) {
            final albumId = state.pathParameters['id']!;
            return AlbumScreen(albumId: albumId);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/encargo',
      builder: (context, state) => const EncargoHomeScreen(),
      routes: [
        GoRoute(
          path: 'arreglo',
          builder: (context, state) => const ArregloScreen(),
        ),
        GoRoute(
          path: 'entrega',
          builder: (context, state) => const EntregaScreen(),
        ),
        GoRoute(
          path: 'destinatario',
          builder: (context, state) => const DestinatarioScreen(),
        ),
        GoRoute(
          path: 'pago',
          builder: (context, state) => const PagoScreen(),
        ),
      ]
    ),
    
    // Other existing routes from side menu etc.
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: '/drafts',
      builder: (context, state) => const DraftsPage(),
    ),
    GoRoute(
      path: '/catalogs',
      builder: (context, state) => const CatalogsPage(),
    ),
    // TODO: Add other routes like /settings, /notifications etc. as needed
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Error: Ruta no encontrada ${state.error}'),
    ),
  ),
);