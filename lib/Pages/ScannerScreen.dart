import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/MedicineBloc.dart';
import '../Bloc/MedicineEvent.dart';
import '../constants/colors.dart';
import '../models/MedicineModel.dart';
import 'package:google_fonts/google_fonts.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=2030&auto=format&fit=crop'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),

          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.keyboard_arrow_left, color:white),
                  onPressed: () => Navigator.pop(context),
                ),
                 Expanded(
                  child: Text(
                    "Add Medicine",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.barlow(color: white, fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          Positioned(
            top: 100,
            bottom: 180,
            left: 0,
            right: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                SizedBox(
                  width: 280,
                  height: 280,
                  child: CustomPaint(painter: ScannerCornerPainter()),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
                  decoration: BoxDecoration(
                    color: white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Upload From Gallery  ", style: GoogleFonts.cabin(color: blk, fontWeight: FontWeight.w700)),
                      Icon(Icons.file_upload_outlined, color: blk, size: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 90),
                GestureDetector(
                  onTap: () {
                    final mockMedicine = MedicineModel(
                      name: "Paracetamol",
                      instruction: "1 tablet every 6 hours",
                      dailyLimit: 4,
                    );
                    context.read<MedicineBloc>().add(AddMedicineEvent(mockMedicine));
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Medicine added successfully!")),
                    );
                  },
                  child: Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: white, width: 4),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(color: white, shape: BoxShape.circle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScannerCornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const cornerLength = 40.0;
    final path = Path();
    path.moveTo(0, cornerLength);
    path.lineTo(0, 0);
    path.lineTo(cornerLength, 0);
    path.moveTo(size.width - cornerLength, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, cornerLength);
    path.moveTo(0, size.height - cornerLength);
    path.lineTo(0, size.height);
    path.lineTo(cornerLength, size.height);
    path.moveTo(size.width - cornerLength, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height - cornerLength);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}