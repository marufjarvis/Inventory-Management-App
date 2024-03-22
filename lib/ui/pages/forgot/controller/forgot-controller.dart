import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_mangament_app/constatns/color.dart';
import 'package:inventory_mangament_app/ui/pages/forgot/service/forgot-service.dart';
import 'package:inventory_mangament_app/ui/pages/login/model/login-request-model.dart';

class ForgotController extends GetxController {
  var isLoading = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void doValidateUser() {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar("Empty", "Field cannot be emtpy",
          backgroundColor: Colors.red, colorText: whiteColor);
    } else if (!emailController.text.isEmail) {
      Get.snackbar("Invalid", "Invalid Email",
          backgroundColor: Colors.red, colorText: whiteColor);
    } else if (passwordController.text.length < 8) {
      Get.snackbar("Invalid", "Invalid password lenght",
          backgroundColor: Colors.red, colorText: whiteColor);
    } else if (passwordController.text.length !=
        confirmPasswordController.text.length) {
      Get.snackbar("Ops", "Confirm password not matched",
          backgroundColor: Colors.red, colorText: whiteColor);
    } else {
      debugPrint("Done");
      changePass(LoginRequestModel(
          email: emailController.text, password: passwordController.text));
    }
  }

  void changePass(LoginRequestModel data) async {
    isLoading.value = true;
    String message = await ForgotService.changePassword(data);
    if (message == "Password was changed successfully!") {
      Get.back();
      Get.snackbar("Congress", "Successfully Reset the password",
          backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      isLoading.value = false;
      Get.snackbar(
        "Ops",
        message,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    isLoading.value = false;
  }
}
