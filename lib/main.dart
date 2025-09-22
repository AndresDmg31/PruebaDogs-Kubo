import 'package:dogs/core/app_config.dart';
import 'package:dogs/data/local/secure_storage_service.dart';
import 'package:dogs/presentation/viewmodels/breeds_view_model.dart';
import 'package:dogs/presentation/viewmodels/favorites_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogs/presentation/views/splash/splash_view.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final current = await SecureStorageService.getApiKey();
  if (current == null){
    await SecureStorageService.setApiKey(
        "live_T360G12hGTOxTj6pcZdl3JCS4qhKVZl8WKxm1Fdl1fTDCxWbnGX1jeEsuZZLdGHv"
    );
  }
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     return MultiProvider(providers: [
       ChangeNotifierProvider(create: (_) => BreedsProvider()),
       ChangeNotifierProvider(create: (_) => FavoritesProvider())
     ],
    child:  MaterialApp(
      title: "Dog Breeds",
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),

      initialRoute: "/",
      routes: {
        "/": (_) => const SplashView()
      },
     ),
    );
  }
}