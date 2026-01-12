import 'package:flutter/material.dart';
import 'package:cake_shop_ui/bottom_tab.dart';


class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  final List<Map<String, String>> genericOrders = const [
    {"orderNo": "Order No. 1", "date": "2025-07-01"},
    {"orderNo": "Order No. 2", "date": "2025-07-05"},
    {"orderNo": "Order No. 3", "date": "2025-07-10"},
  ];

  final List<Map<String, String>> customizedOrders = const [
    {"orderNo": "Order No. A", "date": "2025-06-21"},
    {"orderNo": "Order No. B", "date": "2025-06-25"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Order Details",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                "Generic Orders",
                style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              ...genericOrders.map((order) => _buildOrderCard(order, "generic")),
              const SizedBox(height: 30),
              const Text(
                "Customized Orders",
                style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              ...customizedOrders.map((order) => _buildOrderCard(order, "custom")),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomTabBar(),
    );
  }

  Widget _buildOrderCard(Map<String, String> order, String type) {
    return GestureDetector(
      onTap: () {
        print("Tapped ${order["orderNo"]} from $type orders");
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Text(
              order["orderNo"]!,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const Spacer(),
            Text(
              order["date"]!,
              style: const TextStyle(color: Colors.orangeAccent, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
