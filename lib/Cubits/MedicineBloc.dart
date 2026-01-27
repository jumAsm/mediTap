import 'package:flutter_bloc/flutter_bloc.dart';
import 'medicine_event.dart';
import 'medicine_state.dart';
import '../models/medicine_model.dart';

class MedicineBloc extends Bloc<MedicineEvent, MedicineState> {
  final List<Medicine> _medicinesList = []; // قائمة مؤقتة للبيانات

  MedicineBloc() : super(MedicineInitial()) {
    on<AddMedicineEvent>((event, emit) {
      _medicinesList.add(event.medicine); // إضافة الدواء للقائمة
      emit(MedicineLoaded(List.from(_medicinesList))); // تحديث الواجهة بالقائمة الجديدة
    });
  }
}