import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/api_services.dart';

class UserProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  final List<UserModel> _users = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchUsers({bool loadMore = false}) async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final List<UserModel> newUsers =
          await _apiService.fetchUsers(page: _page);

      if (newUsers.isEmpty) {
        _hasMore = false;
      } else {
        _users.addAll(newUsers);
        _page++;
      }
    } catch (e) {
      print('Error fetching users: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
