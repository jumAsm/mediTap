import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubits/MedicineBloc.dart';
import '../Cubits/MedicineState.dart';
import 'MedicationHistory.dart';
import 'ScannerScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildProgressCard(),
            const SizedBox(height: 24),
            _buildKidneyRiskBanner(),
            const SizedBox(height: 32),

            // --- الجزء الديناميكي المرتبط بـ Bloc ---
            const Text("Your Medications",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: Color(0xFF1A1C1E))),
            const SizedBox(height: 16),

            BlocBuilder<MedicineBloc, MedicineState>(
              builder: (context, state) {
                if (state is MedicineLoaded && state.medicines.isNotEmpty) {
                  return Column(
                    children: state.medicines.map((med) => _buildMedicationItem(
                      title: med.name,
                      sub: med.instruction,
                      days: "Daily Limit: ${med.dailyLimit}",
                      iconBg: Colors.blue.shade50,
                      iconColor: const Color(0xFF4B84F4),
                    )).toList(),
                  );
                }
                // يعرض هذا النص في حال لم يتم إضافة أي دواء بعد
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("No medications added yet.\nPress + to scan.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey.shade400)),
                  ),
                );
              },
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScannerScreen()),
          );
        },
        backgroundColor: const Color(0xFF4B84F4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
    );
  }

  // --- Widgets ---

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 90,
      title: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Hey, Rafi", style: TextStyle(color: Colors.grey, fontSize: 14)),
            Row(
              children: const [
                Text("Thursday", style: TextStyle(color: Color(0xFF1A1C1E), fontWeight: FontWeight.bold, fontSize: 26)),
                Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 28),
              ],
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 25, right: 8),
          child: IconButton(
            icon: const Icon(Icons.history, color: Colors.black, size: 28),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MedicationHistoryScreen()));
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 25, right: 16),
          child: Icon(Icons.more_vert, color: Colors.black, size: 28),
        )
      ],
    );
  }

  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 6))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Your plan\nis almost done!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, height: 1.1)),
              const SizedBox(height: 14),
              Row(
                children: const [
                  Icon(Icons.arrow_upward, color: Color(0xFF66BB6A), size: 18),
                  Text(" 13% than week ago", style: TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
            ],
          ),
          _buildCircularIndicator(),
        ],
      ),
    );
  }

  Widget _buildCircularIndicator() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 75, height: 75,
          child: CircularProgressIndicator(
            value: 0.78,
            strokeWidth: 10,
            color: const Color(0xFF81C784),
            backgroundColor: const Color(0xFFF1F1F1),
            strokeCap: StrokeCap.round,
          ),
        ),
        const Text("78%", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ],
    );
  }

  Widget _buildKidneyRiskBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFBDEADA), Color(0xFFC0D6F9)]),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Early Drug Risk Monitoring", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white)),
                Text("AI-powered kidney protection", style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          const Icon(Icons.shield_moon_outlined, color: Colors.white, size: 40),
        ],
      ),
    );
  }

  Widget _buildMedicationItem({required String title, required String sub, required String days, required Color iconBg, required Color iconColor}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28)),
      child: Row(
        children: [
          Container(
            width: 60, height: 60,
            decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.medication_liquid_sharp, color: iconColor, size: 30),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 14)),
              ],
            ),
          ),
          Text(days, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}