import 'package:get/get.dart';

class UserController extends GetxController {
  var user = {}.obs;

  void setUser(Map<String, dynamic> userData) {
    user.value = userData;
  }
}
