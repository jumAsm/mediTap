import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/MedicineBloc.dart';
import '../Bloc/MedicineState.dart';

class MedicationHistoryScreen extends StatelessWidget {
  const MedicationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Medication History",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<MedicineBloc, MedicineState>(
        builder: (context, state) {
          if (state is MedicineLoaded && state.medicines.isNotEmpty) {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildCategoryHeader("Current Medications"),
                // عرض الأدوية المضافة ديناميكياً من الـ Bloc
                ...state.medicines.map((med) => _buildHistoryItem(
                  med.name,
                  med.instruction,
                  "Added Today", // يمكن تطويرها لاحقاً لإظهار التاريخ الحقيقي
                  Colors.blue.shade50,
                  true,
                )),

                const SizedBox(height: 30),
                _buildCategoryHeader("Past Medications"),
                _buildHistoryItem("Panadol", "2 tablets", "Finished: 05 Jan", Colors.grey.shade100, false),
              ],
            );
          }

          // حالة عدم وجود أدوية مضافة بعد
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildCategoryHeader("Past Medications"),
              _buildHistoryItem("Panadol", "2 tablets", "Finished: 05 Jan", Colors.grey.shade100, false),
              _buildHistoryItem("Vitamin C", "1 tablet", "Finished: 30 Dec", Colors.grey.shade100, false),
              const SizedBox(height: 20),
              const Center(child: Text("No new medications added via scanner yet.")),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCategoryHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 4),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A1C1E)),
      ),
    );
  }

  Widget _buildHistoryItem(String name, String dosage, String date, Color bgColor, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.medication,
              color: isActive ? const Color(0xFF4B84F4) : Colors.grey,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  dosage,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          Text(
            date,
            style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}