import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/MedicineModel.dart';
import 'MedicineEvent.dart';
import 'MedicineState.dart';

// تأكدي أنكِ تستخدمين Bloc وليس Cubit كما هو موضح هنا
class MedicineBloc extends Bloc<MedicineEvent, MedicineState> {
  final List<MedicineModel> _medicinesList = [];

  MedicineBloc() : super(MedicineInitial()) {
    // استقبال الحدث وإضافة الدواء للقائمة
    on<AddMedicineEvent>((event, emit) {
      _medicinesList.add(event.medicine);
      emit(MedicineLoaded(List.from(_medicinesList)));
    });
  }
}