// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:inventory_mangament_app/constatns/color.dart';
import 'package:inventory_mangament_app/constatns/pm.dart';
import 'package:get/get.dart';
import 'package:inventory_mangament_app/constatns/string.dart';
import 'package:inventory_mangament_app/ui/pages/registration/controller/register-controller.dart';

import '../../../widgets/custom-button.dart';
import '../../../widgets/text-box.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final RegisterController registerController = Get.put(RegisterController());
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(pm28),
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bgwithcircle.png'),
                fit: BoxFit.cover)),
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
                controller: registerController.emailController,
              ),
              const SizedBox(
                height: pm20,
              ),
              CustomTextBox(
                isPassword: true,
                hint: enterPassword,
                controller: registerController.passwordController,
              ),
              const SizedBox(
                height: pm20,
              ),
              CustomTextBox(
                isPassword: true,
                hint: enterConfirmPass,
                controller: registerController.confirmPasswordController,
              ),
              const SizedBox(
                height: pm20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Obx(() {
                  return registerController.isLoading.value
                      ? CustomButton(
                          tap: () {},
                          title: create,
                          isLoadingButton: true,
                        )
                      : CustomButton(
                          tap: () {
                            registerController.doValidateUser();
                          },
                          title: create,
                        );
                }),
              ),
              const SizedBox(
                height: pm65,
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
        register,
        style: Theme.of(context)
            .textTheme
            .displaySmall!
            .copyWith(fontSize: pm20, fontWeight: FontWeight.w700),
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
            .copyWith(fontSize: pm26, fontWeight: FontWeight.w500),
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
              text: alreadyHavaAccount,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 14,
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
