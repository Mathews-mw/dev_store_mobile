import 'package:dev_store/models/product_list.dart';
import 'package:dev_store/screens/product_details_screen.dart';
import 'package:dev_store/screens/products_overview_screen.dart';
import 'package:dev_store/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductList(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'Lato',
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
            ),
            appBarTheme: theme.appBarTheme.copyWith(
              backgroundColor: Colors.purple,
              centerTitle: true,
              titleTextStyle: const TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )),
        home: ProductsOverviewScreen(),
        routes: {
          AppRoutes.PRODUCT_DETAILS: (ctx) => const ProductDetailsScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
