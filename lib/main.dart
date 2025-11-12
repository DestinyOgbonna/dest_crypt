import 'package:dest_crypt/src/features/bottom_navigation.dart';
import 'package:dest_crypt/src/features/coin_details/data/coin_details_provider.dart';
import 'package:dest_crypt/src/features/dashboard/data/dashboard_provider.dart';

import 'package:dest_crypt/src/utils/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DashboardProvider>(
          create: (context) => DashboardProvider(),
        ),
        ChangeNotifierProvider<CoinDetailsProvider>(
          create: (context) => CoinDetailsProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.darkerOrangeColor,
          ),
          scaffoldBackgroundColor: AppColors.blackColor,
        ),
        home: const BottomNavigationWidget(),
      ),
    );
  }
}
