import 'package:flutter/material.dart';

class OrderFormPage extends StatefulWidget {
  const OrderFormPage({super.key});

  @override
  State<OrderFormPage> createState() => _OrderFormPageState();
}

class _OrderFormPageState extends State<OrderFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController orderNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController themeController = TextEditingController();
  final TextEditingController addonController = TextEditingController();

  String? selectedOrderType;
  int selectedPounds = 1;
  int numberOfCakes = 1;

  final List<String> orderTypes = ["Birthday Cake", "Wedding Cake"];
  DateTime? selectedDeliveryDate;
  final TextEditingController deliveryDateController = TextEditingController();

  void _cancel() {
    print("Cancelled");
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      print("Order Name: ${orderNameController.text}");
      print("Address: ${addressController.text}");
      print("Order Type: $selectedOrderType");
      print("Pounds: $selectedPounds");
      print("No of Cakes: $numberOfCakes");
      print("Add-ons: ${addonController.text}");
    }
  }

Future<void> _selectDeliveryDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
    builder: (context, child) {
      return Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: Colors.black,
            onPrimary: Colors.black,
            surface: Colors.grey,
            onSurface: Colors.black,
          ),
          dialogBackgroundColor: Colors.black,
        ),
        child: child!,
      );
    },
  );
  if (picked != null) {
    setState(() {
      selectedDeliveryDate = picked;
      deliveryDateController.text =
      "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Customer Details",
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: orderNameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Order Name",
                    labelStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.grey[900],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15), // Rounded border
                      borderSide: BorderSide.none, // No visible border line
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? "Order name is required" : null,
                ),

                const SizedBox(height: 10),
                TextFormField(
                  controller: addressController,
                  style: const TextStyle(color: Colors.black),
                  decoration: _inputDecoration("House Address"),
                  validator: (value) =>
                  value!.isEmpty ? "Address is required" : null,
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => _selectDeliveryDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: deliveryDateController,
                      style: const TextStyle(color: Colors.black),
                      decoration: _inputDecoration("Delivery Date"),
                      validator: (value) =>
                      value!.isEmpty ? "Delivery date is required" : null,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Order Details",
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  dropdownColor: Colors.grey[900],
                  decoration: _inputDecoration("Select Order Type"),
                  items: orderTypes
                      .map((type) => DropdownMenuItem(
                    value: type,
                    child: Text(type,
                        style: const TextStyle(color: Colors.black)),
                  ))
                      .toList(),
                  value: selectedOrderType,
                  onChanged: (val) => setState(() => selectedOrderType = val),
                  validator: (value) =>
                  value == null ? "Order type is required" : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: themeController,
                  style: const TextStyle(color: Colors.black),
                  decoration: _inputDecoration("Theme (Optional)"),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black),
                  onPressed: () {
                    print("Theme image picker pressed");
                    // Add image picker logic here
                  },
                  icon: const Icon(Icons.image),
                  label: const Text("Add Theme Image"),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<int>(
                  dropdownColor: Colors.grey[900],
                  decoration: _inputDecoration("Select Pounds"),
                  items: [1, 2, 3, 4]
                      .map((val) => DropdownMenuItem(
                    value: val,
                    child: Text("$val",
                        style: const TextStyle(color: Colors.white)),
                  ))
                      .toList(),
                  value: selectedPounds,
                  onChanged: (val) =>
                      setState(() => selectedPounds = val ?? 1),
                  validator: (value) =>
                  value == null ? "Please select pounds" : null,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text("No. of Cakes:",
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        if (numberOfCakes > 1) {
                          setState(() => numberOfCakes--);
                        }
                      },
                      icon: const Icon(Icons.remove, color: Colors.purpleAccent),
                    ),
                    Text('$numberOfCakes',
                        style: const TextStyle(
                            color: Colors.black, fontSize: 16)),
                    IconButton(
                      onPressed: () => setState(() => numberOfCakes++),
                      icon: const Icon(Icons.add, color: Colors.purpleAccent),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: addonController,
                  style: const TextStyle(color: Colors.black),
                  decoration: _inputDecoration("Add-ons"),
                  validator: (value) =>
                  value!.isEmpty ? "Add-ons are required" : null,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.black)),
                      onPressed: _cancel,
                      child: const Text("Cancel",
                          style: TextStyle(color: Colors.black)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: _save,
                      child: const Text("Save"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 2),
      ),
    );
  }
}
