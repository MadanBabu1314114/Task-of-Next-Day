import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:ui';
import '../models/user.dart';
import '../providers/user_provider.dart';

class UserListItem extends StatelessWidget {
  final User user;
  final Animation<double> animation;

  const UserListItem({Key? key, required this.user, required this.animation})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    final isFav = provider.isFavorite(user);

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.25),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Hero(
                    tag: 'avatar_${user.id}',
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(user.avatar),
                      radius: 28,
                    ),
                  ),
                  title: Text(
                    '${user.firstName} ${user.lastName}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                      shadows: [
                        Shadow(
                          blurRadius: 8,
                          color: Colors.black26,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  subtitle: Text(
                    user.email,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.redAccent : Colors.white70,
                    ),
                    onPressed: () => provider.toggleFavorite(user),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
