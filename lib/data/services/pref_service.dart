import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uidisign05/data/models/food.dart';

class PrefService {
  static const String keyFoods = "foods";

  /// 🔹 Get list makanan dari SharedPreferences
  static Future<List<Food>> getFoods() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(keyFoods);

    if (data == null) return [];

    List<dynamic> decoded = jsonDecode(data);
    return decoded.map((item) => Food.fromMap(item)).toList();
  }

  /// 🔹 Simpan list makanan ke SharedPreferences
  static Future<void> saveFoods(List<Food> foods) async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> encoded = foods.map((e) => e.toMap()).toList();
    await prefs.setString(keyFoods, jsonEncode(encoded));
  }

  /// 🔹 Tambah makanan ke list
  static Future<void> addFood(Food food) async {
    List<Food> foods = await getFoods();
    foods.add(food);
    await saveFoods(foods);
  }

  /// 🔹 Hapus makanan berdasarkan ID
  static Future<void> deleteFood(String id) async {
    List<Food> foods = await getFoods();
    foods.removeWhere((x) => x.id == id);
    await saveFoods(foods);
  }

  /// 🔹 Hapus semua data makanan
  static Future<void> clearFoods() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyFoods);
  }
}
