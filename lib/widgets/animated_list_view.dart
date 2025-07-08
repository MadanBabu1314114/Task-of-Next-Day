import 'package:flutter/material.dart';
import '../models/user.dart';
import 'user_list_item.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class AnimatedListView extends StatefulWidget {
  final List<User> users;
  final ScrollController controller;

  const AnimatedListView({
    Key? key,
    required this.users,
    required this.controller,
  }) : super(key: key);

  @override
  State<AnimatedListView> createState() => _AnimatedListViewState();
}

class _AnimatedListViewState extends State<AnimatedListView> {
  late List<bool> _visible;

  @override
  void initState() {
    super.initState();
    _initVisibility();
  }

  @override
  void didUpdateWidget(covariant AnimatedListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.users.length != widget.users.length) {
      _initVisibility();
    }
  }

  void _initVisibility() {
    _visible = List.generate(widget.users.length, (_) => false);
    _runAnimations();
  }

  void _runAnimations() async {
    for (int i = 0; i < widget.users.length; i++) {
      await Future.delayed(const Duration(milliseconds: 80));
      if (mounted) {
        setState(() {
          _visible[i] = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Add a loading indicator at the end if the list is still loading more
    final provider = Provider.of<UserProvider>(context, listen: false);
    int itemCount = widget.users.length + (provider.isLoading ? 1 : 0);
    return ListView.builder(
      controller: widget.controller,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index == widget.users.length) {
          // Show loading indicator at the end
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return AnimatedOpacity(
          opacity: _visible[index] ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 400),
          child: AnimatedSlide(
            offset: _visible[index] ? Offset.zero : const Offset(1, 0),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
            child: UserListItem(
              user: widget.users[index],
              animation: const AlwaysStoppedAnimation(1.0),
            ),
          ),
        );
      },
    );
  }
}
