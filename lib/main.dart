import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:med_track_01/firebase_options.dart';
import 'package:med_track_01/providers/storeProvider/store_profile_provider.dart';
import 'package:med_track_01/providers/storeProvider/store_register_provider.dart';
import 'package:med_track_01/providers/userProviders/medication_provider.dart';
import 'package:med_track_01/providers/login_provider.dart';
import 'package:med_track_01/providers/userProviders/user_profile_provider.dart';
import 'package:med_track_01/providers/userProviders/user_register_provider.dart';
import 'package:med_track_01/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserRegisterProvider()),
        ChangeNotifierProvider(create: (_) => UserLoginProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
        ChangeNotifierProvider(create: (_) => UserCreateMedicineProvider()),
        ChangeNotifierProvider(create: (_) => StoreProfileProvider()),
        ChangeNotifierProvider(create: (_) => StoreRegisterProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
