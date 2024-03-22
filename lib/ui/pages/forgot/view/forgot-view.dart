// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:inventory_mangament_app/constatns/color.dart';
import 'package:inventory_mangament_app/constatns/pm.dart';
import 'package:get/get.dart';
import 'package:inventory_mangament_app/constatns/string.dart';
import 'package:get/get.dart';
import 'package:inventory_mangament_app/ui/pages/forgot/controller/forgot-controller.dart';
import '../../../widgets/custom-button.dart';
import '../../../widgets/text-box.dart';

class ForgotView extends StatelessWidget {
  const ForgotView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ForgotController forgotController = Get.put(ForgotController());
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bgwithcircle.png'),
                fit: BoxFit.cover)),
        padding: const EdgeInsets.all(pm28),
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              const Title(),
              ScreenTitle(size: size),
              const SizedBox(
                height: pm24,
              ),
              CustomTextBox(
                  hint: enterEmail,
                  controller: forgotController.emailController),
              const SizedBox(
                height: pm20,
              ),
              CustomTextBox(
                  hint: enterNewPass,
                  controller: forgotController.passwordController),
              const SizedBox(
                height: pm20,
              ),
              CustomTextBox(
                hint: enterConfirmPass,
                controller: forgotController.confirmPasswordController,
              ),
              const SizedBox(
                height: pm20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Obx(() {
                  return forgotController.isLoading.value == false
                      ? CustomButton(
                          tap: () {
                            forgotController.doValidateUser();
                          },
                          title: change,
                        )
                      : CustomButton(
                          isLoadingButton: true,
                          tap: () {},
                          title: change,
                        );
                }),
              ),
              const SizedBox(
                height: pm40,
              ),
              const DonotHaveAnAccount()
            ],
          ),
        ),
      ),
    );
  }
}

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.06),
      child: Text(
        resetPassword,
        style: Theme.of(context)
            .textTheme
            .displaySmall!
            .copyWith(fontSize: pm26, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      child: Text(
        appName,
        style: Theme.of(context)
            .textTheme
            .displaySmall!
            .copyWith(fontSize: pm35, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        forgotPassword,
        style: Theme.of(context).textTheme.displaySmall!.copyWith(
            fontSize: pm17,
            fontWeight: FontWeight.w500,
            color: orangeColor,
            decoration: TextDecoration.underline,
            decorationColor: orangeColor),
      ),
    );
  }
}

class DonotHaveAnAccount extends StatelessWidget {
  const DonotHaveAnAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () => Get.offAllNamed(initialRoute),
        child: Text.rich(
          TextSpan(
              text: backtoLogin,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: pm17,
                    fontWeight: FontWeight.w500,
                  ),
              children: [
                TextSpan(
                    text: " $login",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: pm17,
                        fontWeight: FontWeight.w500,
                        color: orangeColor,
                        decoration: TextDecoration.underline,
                        decorationColor: orangeColor))
              ]),
        ),
      ),
    );
  }
}
