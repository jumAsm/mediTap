import 'package:flutter/material.dart';

import 'MedicineDetails.dart';


class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. خلفية الكاميرا (تمثيل مؤقت)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=2030&auto=format&fit=crop'), // صورة تجريبية لعلبة دواء
                fit: BoxFit.cover,
              ),
            ),
            child: Container(color: Colors.black.withOpacity(0.3)), // طبقة تعتيم خفيفة
          ),

          // 2. الطبقة العلوية (Header)
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const Expanded(
                  child: Text(
                    "Add Medicine",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 48), // لموازنة العنوان
              ],
            ),
          ),

          // 3. إطار المسح (Scanner Overlay)
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // الإطار الأبيض الرئيسي
                Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                // الزوايا السميكة (Corners)
                SizedBox(
                  width: 280,
                  height: 280,
                  child: CustomPaint(
                    painter: ScannerCornerPainter(),
                  ),
                ),
              ],
            ),
          ),

          // 4. الأزرار السفلية
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // زر الرفع من الاستوديو (نفس تصميم الصورة)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        "Upload From Gallery  ",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      Icon(Icons.upload_outlined, color: Colors.black, size: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // زر الالتقاط (Capture Button)
                GestureDetector(
                  onTap: () {
                    // الانتقال لصفحة التفاصيل عند "الالتقاط"
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MedicineDetailsScreen()),
                    );
                  },
                  child: Container(
                    width: 85,
                    height: 85,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 5),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
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

// رسام الزوايا الأربعة للإطار
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

    // زاوية أعلى يسار
    path.moveTo(0, cornerLength);
    path.lineTo(0, 0);
    path.lineTo(cornerLength, 0);

    // زاوية أعلى يمين
    path.moveTo(size.width - cornerLength, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, cornerLength);

    // زاوية أسفل يسار
    path.moveTo(0, size.height - cornerLength);
    path.lineTo(0, size.height);
    path.lineTo(cornerLength, size.height);

    // زاوية أسفل يمين
    path.moveTo(size.width - cornerLength, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height - cornerLength);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}