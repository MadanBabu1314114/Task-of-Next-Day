import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/animated_list_view.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    final provider = Provider.of<UserProvider>(context, listen: false);
    if (_controller.position.pixels >=
        _controller.position.maxScrollExtent - 200) {
      provider.fetchUsers(nextPage: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => FavoritesScreen()),
            ),
          ),
        ],
      ),
      body: provider.isLoading && provider.users.isEmpty
          ? Center(child: CircularProgressIndicator())
          : AnimatedListView(users: provider.users, controller: _controller),
    );
  }
}
