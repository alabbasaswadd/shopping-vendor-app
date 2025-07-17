import 'package:app/authentication/application/auth_state.dart';
import 'package:app/authentication/application/providers/auth_notifier_provider.dart';
import 'package:app/authentication/presentation/screens/login_screen.dart';
import 'package:app/authentication/presentation/screens/singup_screen/signup_screen.dart';
import 'package:app/core/presentation/screens/home_screen.dart';
//import 'package:app/category/presentation/screens/categories_screen.dart';
import 'package:app/core/presentation/screens/main_screen.dart';
import 'package:app/mangment_products/domain/entities/product_entity.dart';
import 'package:app/mangment_products/presentation/screens/add_product_screen.dart';
import 'package:app/mangment_products/presentation/screens/edit_product_screen.dart';
import 'package:app/mangment_products/presentation/screens/product_details_screen.dart';
import 'package:app/mangment_products/presentation/screens/product_screen.dart';
import 'package:app/orders/presentation/screens/order_details_screen.dart';
import 'package:app/orders/presentation/screens/orders_screen.dart';
import 'package:app/settings/presentation/screens/settings_screen.dart';
//import 'package:app/core/presentation/screens/welcome_screen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final router = Provider<GoRouter>((ref) {
  final authState =
      ref.watch(authNotifierProvider); //المراقبة المباشرة لحالة المصادقة

  return GoRouter(
    initialLocation: "/login",
    observers: [BotToastNavigatorObserver()],
    redirect: (context, state) {
      //print('🔄 Redirect: ${state.matchedLocation}, Auth: ${authState.status}');
      //تحديد المسارات المحمية والعامة
      final isAuthenticated = authState.status == AuthStatus.authenticated;
      final isLoading = authState.status == AuthStatus.loading;
      final isLoggingIn = state.matchedLocation == '/login' ||
          state.matchedLocation == '/signUp';

      if (isLoading) {
        // ممكن ما تعيد توجيه، تعرض شاشة تحميل مكان الروتر (شاهد لاحقًا)
        return null;
      }
      // إذا المستخدم غير مسجل دخول وحاول يروح لشاشة رئيسية
      if (!isAuthenticated && !isLoggingIn) {
        return '/login'; // نعيده لشاشة الدخول
      }

      // إذا المستخدم مسجل دخول ويحاول يروح لشاشات تسجيل الدخول أو التسجيل
      if (isAuthenticated && isLoggingIn) {
        //return '/mainScreen'; // نعيده للشاشة الرئيسية
        return '/homeScreen';
      }

      // تابع بدون إعادة توجيه
      return null;
    },
    routes: [
      // GoRoute(
      //   path: "/",
      //   name: "welcomeScreen",
      //   builder: (context, state) => WelcomeScreen(),
      // ),

      // =================================
      // ======== account ================
      // =================================
      GoRoute(
        path: "/signUp",
        name: "signUpScreen",
        builder: (context, state) => SignupScreen(),
      ),
      GoRoute(
        path: "/login",
        name: "loginScreen",
        builder: (context, state) => LoginScreen(),
      ),
      //-----------------------------------------

      GoRoute(
        path: "/mainScreen",
        name: "mainScreen",
        builder: (context, state) => MainScreen(),
      ),

      GoRoute(
        path: "/homeScreen",
        name: "homeScreen",
        builder: (context, state) => HomeScreen(),
      ),
      // =================================
      // ======== product ================
      // =================================
      GoRoute(
        path: "/productScreen",
        name: "productScreen",
        builder: (context, state) => ProductScreen(),
      ),
      GoRoute(
        path: "/addProductScreen",
        name: "addProductScreen",
        builder: (context, state) => AddProductScreen(),
      ),

      GoRoute(
        path: '/productDetailsScreen/:id',
        name: "productDetailsScreen",
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ProductDetailsScreen(id: id);
        },
      ),
      GoRoute(
        path: '/editProduct',
        name: 'editProductScreen',
        builder: (context, state) {
          final product = state.extra as ProductEntity;
          return EditProductScreen(product: product);
        },
      ),
      // ------------------------------------

      // =================================
      // ======== order ==================
      // =================================
      GoRoute(
        path: "/ordersScreen",
        name: "ordersScreen",
        builder: (context, state) => OrdersScreen(),
      ),
      GoRoute(
        path: '/order/:id',
        name: 'orderDetailsScreen',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return OrderDetailsScreen(id: id);
        },
      ),
      //-----------------------------------
      GoRoute(
        path: '/settingsScreen',
        name: 'settingsScreen',
        builder: (context, state) {
          return SettingsScreen();
        },
      )

      // =================================
      // ======== category================
      // =================================
      // GoRoute(
      //   path: "/categoryScreen",
      //   name: "categoryScreen",
      //   builder: (context, state) => CategoriesScreen(),
      // ),
      //-----------------------------------
    ],
  );
});
