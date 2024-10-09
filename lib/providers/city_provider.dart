import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import '../models/city.dart';

part 'city_provider.g.dart';

@riverpod
class CityProvider extends _$CityProvider {
  @override
  Future<List<City>> build() async {
    return fetchCities();
  }

  Future<List<City>> fetchCities([String searchQuery = '']) async {
    final Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();

    try {
      final response = await dio.get('https://odigital.pro/locations/cities/', queryParameters: {'search': searchQuery});
      List<dynamic> data = response.data;
      
   
      await prefs.setString('cities', jsonEncode(data));

      return data.map((city) => City.fromJson(city)).toList();
    } catch (e) {
      
      final cachedCities = prefs.getString('cities');
      if (cachedCities != null) {
        List<dynamic> data = jsonDecode(cachedCities);
        return data.map((city) => City.fromJson(city)).toList();
      } else {
        throw Exception('Error fetching cities and no cached data available');
      }
    }
  }
}
