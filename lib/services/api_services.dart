import 'package:dio/dio.dart';
import '../models/user_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<UserModel>> fetchUsers(
      {required int page, int results = 10}) async {
    try {
      final response = await _dio.get(
        'https://randomuser.me/api/',
        queryParameters: {'page': page, 'results': results},
      );

      final List data = response.data['results'];
      return data.map((e) => UserModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }
}
