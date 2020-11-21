import 'package:firetodowithauth/controllers/authController.dart';
import 'package:get/get.dart';

class AuthBinginds extends Bindings {
  // Create Pipeline between contrller to UI
  @override
  void dependencies() {
    Get.put(AuthController());
    // It will help us to load controller to Ui
  }
}
