import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/animated_list_view.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Color> backgroundColors = const [
    Color(0xFF0f2027),
    Color(0xFF2c5364),
    Color(0xFF1c92d2),
    Color(0xFFf2fcfe),
    Color(0xFFa1c4fd),
    Color(0xFFc2e9fb),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    return _AnimatedBackgroundFavorites(
      backgroundColors: backgroundColors,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: const Text('Favorites')),
        body: provider.favorites.isEmpty
            ? const Center(child: Text('No favorites yet!'))
            : AnimatedListView(
                users: provider.favorites,
                controller: ScrollController(),
              ),
      ),
    );
  }
}

class _AnimatedBackgroundFavorites extends StatefulWidget {
  final List<Color> backgroundColors;
  final Widget child;
  const _AnimatedBackgroundFavorites({
    Key? key,
    required this.backgroundColors,
    required this.child,
  }) : super(key: key);

  @override
  State<_AnimatedBackgroundFavorites> createState() =>
      _AnimatedBackgroundFavoritesState();
}

class _AnimatedBackgroundFavoritesState
    extends State<_AnimatedBackgroundFavorites> {
  int _colorIndex = 0;

  @override
  void initState() {
    super.initState();
    _cycleColors();
  }

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  void _cycleColors() async {
    while (mounted && !_disposed) {
      await Future.delayed(const Duration(seconds: 4));
      if (!mounted || _disposed) return;
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
            widget.backgroundColors[(_colorIndex + 1) %
                widget.backgroundColors.length],
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: widget.child,
    );
  }
}
