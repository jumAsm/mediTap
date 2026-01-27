import 'package:flutter/material.dart';

class MedicineDetailsScreen extends StatelessWidget {
  const MedicineDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Paracetamol",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1A1C1E)),
            ),
            const SizedBox(height: 24),

            // صف الجرعات (Next Dose & Daily Dose)
            Row(
              children: [
                Expanded(child: _buildInfoTile("Next Dose", "4 hrs", Icons.access_time, Colors.green)),
                const SizedBox(width: 16),
                Expanded(child: _buildInfoTile("Daily Dose", "2 / 4", Icons.error_outline, Colors.blue)),
              ],
            ),
            const SizedBox(height: 24),

            // قسم تعليمات الجرعة (Dosage Instruction)
            _buildDosageCard(),
            const SizedBox(height: 24),

            // قسم نبض القلب (Heart Rate)
            _buildHeartRateCard(),
            const SizedBox(height: 24),

            // زر المساعد الذكي (AI Analysis Assistant)
            _buildAIAnalysisBanner(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDosageCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F6FF),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                child: Icon(Icons.medication, color: Colors.blueAccent),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Dosage Instruction", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  Text("500mg Tablet", style: TextStyle(color: Colors.grey)),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          _buildInstructionLine("Take 1 tablet every 4-6 hours as needed"),
          const SizedBox(height: 10),
          _buildInstructionLine("Maximum 4 tablets in 24 hours"),
        ],
      ),
    );
  }

  Widget _buildInstructionLine(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 8, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13, color: Color(0xFF4A4A4A)))),
        ],
      ),
    );
  }

  Widget _buildHeartRateCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Heart rate", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text("72 BPM", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 10),
          // هنا يمكنك وضع الـ Chart لاحقاً، حالياً سنضع مساحة فارغة لتمثيله
          Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.red.withOpacity(0.2), Colors.transparent]),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(child: Icon(Icons.show_chart, color: Colors.redAccent, size: 40)),
          )
        ],
      ),
    );
  }

  Widget _buildAIAnalysisBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFCE93D8), Color(0xFF90CAF9)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("AI Analysis Assistant", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16)),
                Text("Get insights on your medicine", style: TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.auto_awesome, color: Colors.white, size: 30),
        ],
      ),
    );
  }
}