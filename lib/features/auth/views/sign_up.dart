import 'package:flutter/material.dart';
import 'package:flutter_english_study/config/extensions/context_extension.dart';
import 'package:flutter_english_study/config/items/app_colors.dart';
import 'package:flutter_english_study/config/utility/enum/image_enum.dart';
import 'package:flutter_english_study/config/utility/enum/svg_enum.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/routes/route_names.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                        Container(
                          padding: context.paddingVerticalLow,
                          alignment: Alignment.center,
                          child: MaterialButton(
                            onPressed: () {},
                            color: AppColors.whiteColor,
                            minWidth: context.dynamicWidth(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text("Sign Up"),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Do you have an account?",
                              style: context.textTheme.titleMedium?.copyWith(
                                color: AppColors.whiteColor.withOpacity(0.5),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, RouteNames.signIn),
                              child: Text(
                                "Sign In",
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
