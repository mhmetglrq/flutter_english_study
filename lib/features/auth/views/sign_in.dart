import 'package:flutter/material.dart';
import 'package:flutter_english_study/config/extensions/context_extension.dart';
import 'package:flutter_english_study/config/items/app_colors.dart';
import 'package:flutter_english_study/config/utility/enum/image_enum.dart';
import 'package:flutter_english_study/config/utility/enum/svg_enum.dart';
import 'package:flutter_english_study/features/auth/controller/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/routes/route_names.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Stack(
            children: [
              Container(
                height: context.dynamicHeight(1),
                width: context.dynamicWidth(1),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageConstants.authBg.getJpg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: AppColors.whiteColor.withOpacity(0.3),
                  ),
                  child: Padding(
                    padding: context.paddingAllDefault,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: context.textTheme.titleMedium?.copyWith(
                            color: AppColors.whiteColor,
                          ),
                        ),
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Enter your email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: AppColors.whiteColor.withOpacity(0.3),
                            filled: true,
                            errorStyle: context.textTheme.bodyMedium?.copyWith(
                              color: AppColors.errorColor,
                            ),
                          ),
                        ),
                        SizedBox(height: context.dynamicHeight(0.02)),
                        Text(
                          "Password",
                          style: context.textTheme.titleMedium?.copyWith(
                            color: AppColors.whiteColor,
                          ),
                        ),
                        TextFormField(
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _isObscure,
                          decoration: InputDecoration(
                            hintText: "Enter your password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: AppColors.whiteColor.withOpacity(0.3),
                            filled: true,
                            suffixIconConstraints: BoxConstraints(
                              maxHeight: context.dynamicHeight(0.03),
                              maxWidth: context.dynamicWidth(0.1),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                              child: SvgPicture.asset(
                                _isObscure
                                    ? SvgConstants.eyeOpen.getSvg
                                    : SvgConstants.eyeClose.getSvg,
                              ),
                            ),
                            errorStyle: context.textTheme.bodyMedium?.copyWith(
                              color: AppColors.errorColor,
                            ),
                          ),
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            return Container(
                              padding: context.paddingVerticalLow,
                              alignment: Alignment.center,
                              child: MaterialButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ref
                                        .read(authControllerProvider)
                                        .signInWithEmailAndPassword(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        )
                                        .then((value) {
                                      if (value?.user != null) {
                                        Navigator.pushNamed(
                                            context, RouteNames.home);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                "Invalid email or password"),
                                          ),
                                        );
                                      }
                                    });
                                  }
                                },
                                color: AppColors.whiteColor,
                                minWidth: context.dynamicWidth(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text("Sign In"),
                              ),
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: context.textTheme.titleMedium?.copyWith(
                                color: AppColors.whiteColor.withOpacity(0.5),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, RouteNames.signUp),
                              child: Text(
                                "Sign Up",
                                style: context.textTheme.titleMedium?.copyWith(
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
