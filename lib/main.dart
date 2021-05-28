import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medical_ecommerce/core/model/user.dart';
import 'package:medical_ecommerce/core/provider/cart.dart';
import 'package:medical_ecommerce/core/provider/shops.dart';
import 'package:medical_ecommerce/res/routes.dart';

import 'package:medical_ecommerce/ui/screens/add_product.dart';
import 'package:medical_ecommerce/ui/screens/adminWrapper.dart';
import 'package:medical_ecommerce/ui/screens/auth/login_page.dart';
import 'package:medical_ecommerce/ui/screens/auth/password_page.dart';
import 'package:medical_ecommerce/ui/screens/auth/register_page.dart';
import 'package:medical_ecommerce/ui/screens/auth/shop_register.dart';
import 'package:medical_ecommerce/ui/screens/cart_screen.dart';
import 'package:medical_ecommerce/ui/screens/product_details_page.dart';
import 'package:medical_ecommerce/ui/screens/productPage.dart';
import 'package:provider/provider.dart';

import 'core/provider/auth.dart';
import 'res/app_theme.dart';
import 'ui/screens/auth/authenticationWrapper.dart';
import 'ui/screens/home_page.dart';
import 'ui/screens/shopdashboard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: CartProvider()),
          Provider<AuthenticationService>(
              create: (_) => AuthenticationService()),
          StreamProvider(
            initialData: FirebaseAuth.instance.authStateChanges(),
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges,
            child: AuthenticationWrapper(),
          ),
          ChangeNotifierProvider.value(value: ShopsProvider()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.appTheme(),
          initialRoute: MyRoutes.authenticationWrapper,
          routes: {
            "/": (context) => AuthenticationWrapper(),
            MyRoutes.authenticationWrapper: (context) =>
                AuthenticationWrapper(),
            MyRoutes.loginRoute: (context) => LoginPage(),
            MyRoutes.emailRegister: (context) => RegisterPage(),
            MyRoutes.passwordRegister: (context) => PasswordPage(),
            MyRoutes.homePage: (context) => HomePage(),
            MyRoutes.productPage: (context) => ProductPage(),
            MyRoutes.productDetailsPage: (context) => ProductDetailsPage(),
            MyRoutes.cartScreen: (context) => CartScreen(),
            MyRoutes.addProduct: (context) => AddProduct(),
            MyRoutes.shopregister: (context) => ShopRegister(),
            MyRoutes.shopDashboard: (context) => ShopDashBoard(),
            MyRoutes.adminWrapper: (context) => AdminWrapper(),
          },
        ));
  }
}
