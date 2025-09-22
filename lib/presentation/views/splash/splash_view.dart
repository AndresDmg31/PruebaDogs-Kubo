import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home/home_view.dart';
import '../../viewmodels/splash_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final _controller = SplashController();
  String _appName = "";
  String _version = "";

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final (name, version) = await _controller.loadInfo();
    if (!mounted) return;
    setState(() {
      _appName = name;
      _version = version;
    });

    await Future.delayed(const Duration(milliseconds: 2000));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) =>  HomeView()),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SafeArea(child: Column(
        children: [
          Expanded(child: Center(child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/logo.png", width: 150,height: 150 ),
              const SizedBox(height: 5),
              Text(_appName.isEmpty ? "" : _appName, style: GoogleFonts.changaOne(fontSize: 50)),
              const SizedBox(height: 6),
              Text("Explora razas y guarda tus favoritas", style: GoogleFonts.lobster(fontSize: 20 )
              )
            ],
          ),
          ),
          ),
          Padding(padding: const EdgeInsets.only(bottom: 200),child: Text("V " +_version, style: TextStyle(fontSize: 18)),)
        ],
      ),
      ),
    );
  }
}
