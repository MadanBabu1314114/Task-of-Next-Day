import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Color> backgroundColors = [
    Color(0xFF0f2027),
    Color(0xFF2c5364),
    Color(0xFF1c92d2),
    Color(0xFFf2fcfe),
    Color(0xFFa1c4fd),
    Color(0xFFc2e9fb),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'User List',
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          cardTheme: const CardThemeData(
            color: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
          ),
        ),
        home: AnimatedBackgroundHome(
          backgroundColors: backgroundColors,
        ),
      ),
    );
  }
}

class AnimatedBackgroundHome extends StatefulWidget {
  final List<Color> backgroundColors;
  const AnimatedBackgroundHome({Key? key, required this.backgroundColors}) : super(key: key);

  @override
  State<AnimatedBackgroundHome> createState() => _AnimatedBackgroundHomeState();
}

class _AnimatedBackgroundHomeState extends State<AnimatedBackgroundHome> {
  int _colorIndex = 0;

  @override
  void initState() {
    super.initState();
    _cycleColors();
  }

  void _cycleColors() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 4));
      setState(() {
        _colorIndex = (_colorIndex + 1) % widget.backgroundColors.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            widget.backgroundColors[_colorIndex],
            widget.backgroundColors[(_colorIndex + 1) % widget.backgroundColors.length],
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: HomeScreen(),
    );
  }
  }


