// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_mangament_app/constatns/color.dart';
import 'package:inventory_mangament_app/constatns/string.dart';
import 'package:inventory_mangament_app/ui/pages/registration/model/register-request-model.dart';
import 'package:inventory_mangament_app/ui/pages/registration/service/registration-service.dart';

class RegisterController extends GetxController {
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
      registerUser(RegisterRequestModel(
          name: "none",
          email: emailController.text,
          password: passwordController.text));
    }
  }

  void registerUser(RegisterRequestModel data) async {
    isLoading.value = true;
    bool isSuccessFullyRegistered = await RegisterService.registerUser(data);
    if (isSuccessFullyRegistered) {
      Get.snackbar("Congress", "Successfully Registerd",
          backgroundColor: Colors.green, colorText: whiteColor);
      Get.offNamed(loginRoute);
    } else {
      Get.snackbar("Wrong", "Something went wrong",
          backgroundColor: Colors.red);
    }
    isLoading.value = false;
  }
}
