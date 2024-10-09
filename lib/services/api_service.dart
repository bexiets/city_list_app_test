import 'package:dio/dio.dart';
import '../models/city.dart'; 

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<List<City>> fetchCities(String? searchQuery) async {
    final url = searchQuery != null 
        ? 'https://odigital.pro/locations/cities/?search=$searchQuery' 
        : 'https://odigital.pro/locations/cities/';
    
    try {
      final response = await _dio.get(url);
     
      List<dynamic> data = response.data;
      return data.map((json) => City.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load cities: $e');
    }
  }
}
