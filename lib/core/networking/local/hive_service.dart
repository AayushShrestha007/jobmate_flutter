import 'package:final_assignment/app/constants/hive_table_constant.dart';
import 'package:final_assignment/features/auth/data/model/auth_hive_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

final hiveServiceProvider = Provider((ref) => HiveService());

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    // Register Adapters

    Hive.registerAdapter(AuthHiveModelAdapter());
  }

  Future<void> addApplicant(AuthHiveModel applicant) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.applicantBox);
    await box.put(applicant.applicantId, applicant);
  }

  Future<List<AuthHiveModel>> getAllApplicant() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.applicantBox);
    var applicants = box.values.toList();
    box.close();
    return applicants;
  }

  //Login
  Future<AuthHiveModel?> login(String email, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.applicantBox);
    var applicant = box.values.firstWhere(
        (element) => element.email == email && element.password == password);
    box.close();
    return applicant;
  }
}
