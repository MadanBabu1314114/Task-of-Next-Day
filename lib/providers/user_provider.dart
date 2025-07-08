import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = [];
  List<User> get users => _users;

  List<User> _favorites = [];
  List<User> get favorites => _favorites;

  int _page = 1;
  int _totalPages = 1;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserProvider() {
    loadFavorites();
    fetchUsers();
  }

  Future<void> fetchUsers({bool nextPage = false}) async {
    if (_isLoading) return;
    if (nextPage && _page >= _totalPages) return;

    _isLoading = true;
    notifyListeners();

    int requestPage = _page;
    if (nextPage) {
      requestPage = _page + 1;
      if (requestPage > _totalPages) {
        _isLoading = false;
        notifyListeners();
        return;
      }
    }

    final response = await http.get(
      Uri.parse('https://reqres.in/api/users?page=$requestPage'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _totalPages = data['total_pages'];
      List<User> fetched = (data['data'] as List)
          .map((e) => User.fromJson(e))
          .toList();
      if (nextPage) {
        _page = requestPage;
        _users.addAll(fetched);
      } else {
        _page = 1;
        _users = fetched;
      }
      notifyListeners();
    } else {
      // Optionally handle errors here
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favs = prefs.getStringList('favorites') ?? [];
    _favorites = favs.map((e) => User.fromJson(json.decode(e))).toList();
    notifyListeners();
  }

  Future<void> toggleFavorite(User user) async {
    final prefs = await SharedPreferences.getInstance();
    if (isFavorite(user)) {
      _favorites.removeWhere((u) => u.id == user.id);
    } else {
      _favorites.add(user);
    }
    final favs = _favorites.map((u) => json.encode(u.toJson())).toList();
    await prefs.setStringList('favorites', favs);
    notifyListeners();
  }

  bool isFavorite(User user) => _favorites.any((u) => u.id == user.id);
}
