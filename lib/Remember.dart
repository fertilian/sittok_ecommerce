import 'package:ecommerce_ui/RememberUser.dart';
import 'package:ecommerce_ui/models/model_user.dart';
import 'package:get/get.dart';

class CurrentUser extends GetxController {
  final Rx<Users> _currentUser = Users(
    idCustomer: 0,
    namaCustomer: '',
    email: '',
    noTelpCustomer: '',
    alamat: '',
  ).obs;

  Users get user => _currentUser.value;

  Future<void> getUserInfo() async {
    Users getUserLocalStorage = await RememberUser.readUser();
    _currentUser.value = getUserLocalStorage;
  }
}