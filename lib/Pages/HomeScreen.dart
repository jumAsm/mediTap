import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditap/constants/colors.dart';
import '../Bloc/MedicineBloc.dart';
import '../Bloc/MedicineState.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ScannerScreen.dart';
import 'MedicineDetails.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F7),
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyInfiniteDateTimeLine(
                  showTimelineHeader: false,
                  firstDate: _getStartOfCurrentWeek(),
                  lastDate: _getEndOfCurrentWeek(),
                  focusDate: _selectedDate,
                  onDateChange: (selectedDate) {
                    setState(() {
                      _selectedDate = selectedDate;
                    });
                  },
                  activeColor: Color(0xFF1E48A3),
                  dayProps: EasyDayProps(
                    dayStructure: DayStructure.dayStrDayNum,
                    width: 48.0,
                    height: 68.0,

                    activeDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: Color(0xFF1E48A3),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      dayNumStyle: GoogleFonts.barlow(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      dayStrStyle: GoogleFonts.barlow(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    todayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xFF1E48A3),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      dayNumStyle: GoogleFonts.barlow(
                        color: blk,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      dayStrStyle: GoogleFonts.barlow(
                        color: offwhite,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),

                    inactiveDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: offwhite),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      dayNumStyle: GoogleFonts.barlow(
                        color: blk,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      dayStrStyle: GoogleFonts.barlow(
                        color: offwhite,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),

                    todayHighlightStyle: TodayHighlightStyle.none,
                  ),
                  timeLineProps: const EasyTimeLineProps(
                    hPadding: 0.0,
                    separatorPadding: 4.0,
                  ),
                ),
              ],
            ),
            // const SizedBox(height: 10),
            // _buildProgressCard(),
            const SizedBox(height: 18),
            _buildKidneyRiskBanner(),
            const SizedBox(height: 22),
            Text(
              "Your Medications",
              style: GoogleFonts.cabin(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: blk,
              ),
            ),
            const SizedBox(height: 18),
            BlocBuilder<MedicineBloc, MedicineState>(
              builder: (context, state) {
                if (state is MedicineLoaded && state.medicines.isNotEmpty) {
                  return Column(
                    children: state.medicines
                        .map(
                          (med) =>
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MedicineDetailsScreen(medicine: med),
                                ),
                              );
                            },
                            child: _buildMedicationItem(
                              title: med.name,
                              sub: med.instruction,
                              days: "Daily Limit: ${med.dailyLimit}",
                              iconBg: Colors.blue.shade50,
                              iconColor: const Color(0xFF4B84F4),
                            ),
                          ),

                    )
                        .toList(),
                  );
                }
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "No medications added yet.\nPress + to scan.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
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
        backgroundColor: blues,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 90,
      title: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.fromBorderSide(
              BorderSide(color: offwhite, width: 2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('lib/assets/avi.jpg'),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 5, right: 4),
          child: Text(
            "Thursday",
            style: GoogleFonts.barlow(
              color: blk,
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 14, right: 16),
          child: Icon(Icons.keyboard_arrow_down, color: blk, size: 28),
        ),
      ],
    );
  }

  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your plan\nis almost done!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: const [
                  Icon(Icons.arrow_upward, color: Color(0xFF66BB6A), size: 18),
                  Text(
                    " 13% than week ago",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
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
          width: 75,
          height: 75,
          child: CircularProgressIndicator(
            value: 0.78,
            strokeWidth: 10,
            color: const Color(0xFF81C784),
            backgroundColor: const Color(0xFFF1F1F1),
            strokeCap: StrokeCap.round,
          ),
        ),
        const Text(
          "78%",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildKidneyRiskBanner() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFB7C2DD), blues, Color(0xFFD6DBE4)],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Early Drug Risk Monitoring",
                        style: GoogleFonts.cabin(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "AI-powered kidney protection",
                        style: GoogleFonts.cabin(fontSize: 12, color: white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 60),
              ],
            ),
          ),

          Positioned(
            right: 7,
            bottom: -10,
            top: -10,
            child: Image.asset(
              'lib/assets/Kidney img.png',
              width: 55,
              height: 55,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: -10,
            bottom: -10,
            right: 5,
            child: IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationItem({
    required String title,
    required String sub,
    required String days,
    required Color iconBg,
    required Color iconColor,
  }) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect( // لضمان أن التدرج لا يخرج عن حدود انحناء الحواف
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            // الجزء الخاص بالتدرج الأحمر في جهة اليمين
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 100,
                // عرض منطقة التدرج
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0), // يتلاشى للشفافية
                      Color(0xFFC10D43).withOpacity(0.1),
                      Color(0xFFC10D43).withOpacity(0.3),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // ليأخذ العمود مساحة النص فقط
                  crossAxisAlignment: CrossAxisAlignment.center, // يضمن توسيط النصوص فوق بعضها
                  children: [
                    Text(
                      'Heart Beat',
                      style: GoogleFonts.cabin(
                        color: blk,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),

                    Text(
                      '72 BPM',
                      style: GoogleFonts.barlow(
                        color: blk,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // محتوى الكارت الأساسي
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Center(
                    child: Image.asset(
                      'lib/assets/pill01_v1_w 1 (1).png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Text(
                          title,
                          style: GoogleFonts.barlow(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                            sub,
                            style: GoogleFonts.cabin(
                                color: Colors.grey,
                                fontSize: 12
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  DateTime _getStartOfCurrentWeek() {
    DateTime now = DateTime.now();
    return now.subtract(Duration(days: now.weekday - 1));
  }

  DateTime _getEndOfCurrentWeek() {
    DateTime now = DateTime.now();
    return now.add(Duration(days: 7 - now.weekday));
  }
}