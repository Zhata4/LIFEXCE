import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> foodList = [];
  int totalCalories = 0;

  @override
  void initState() {
    super.initState();
    loadFood();
  }

  Future<void> loadFood() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString("foods");
    if (jsonString != null) {
      List<dynamic> decoded = json.decode(jsonString);
      foodList = decoded.map((e) => Map<String, dynamic>.from(e)).toList();
      countCalories();
    }
    setState(() {});
  }

  void countCalories() {
    int total = 0;
    for (var item in foodList) {
      total += (item['calories'] as int);
    }
    totalCalories = total;
  }

  Future<void> deleteFood(String id) async {
    foodList.removeWhere((item) => item['id'] == id);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("foods", json.encode(foodList));
    countCalories();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Nutrition Tracker",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/addFood');
          if (result == true) {
            loadFood();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Card Kalori total
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Total Calories Today",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "$totalCalories kcal",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Judul list makanan
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Food Consumption", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),

            // List makanan
            Expanded(
              child: foodList.isEmpty
                  ? const Center(child: Text("No food recorded"))
                  : ListView.builder(
                      itemCount: foodList.length,
                      itemBuilder: (context, index) {
                        final food = foodList[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(food['name'], style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 4),
                                    Text("${food['calories']} kcal", style: const TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => deleteFood(food['id']),
                              )
                            ],
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
