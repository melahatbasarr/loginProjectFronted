import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/rounded_button.dart';
import '../components/rounded_input_field.dart';
import '../components/square_box.dart';
import '../constant/app_text_style.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController = TextEditingController();
  bool isLoading = false;

  Future<void> handleRegister() async {
    if (passwordController.text != repeatPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    setState(() => isLoading = true);
    final auth = AuthService();
    try {
      final result = await auth.register(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Unknown response')),
      );

      if (result['message'] == "Registered successfully") {
        // Kayıt başarılı, login ekranına yönlendir
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            child: Opacity(
              opacity: 0.7,
              child: SvgPicture.asset(
                "assets/images/wave_purple_up.svg",
                height: 250,
                width: 100,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Opacity(
              opacity: 0.1,
              child: SvgPicture.asset(
                "assets/images/wave-grey_down.svg",
                height: 200,
                width: 50,
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 200),
              SvgPicture.asset(
                "assets/images/welcome.svg",
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(20),
                    height: 360,
                    width: 340,
                    decoration: BoxDecoration(
                      color: const Color(0xffF3F3F5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        RoundedInputField(
                          controller: emailController,
                          isEmail: true,
                          isPassword: false,
                          hintText: "E-mail",
                          icon: Icons.mail,
                          onChange: (value) {},
                        ),
                        RoundedInputField(
                          controller: passwordController,
                          isEmail: false,
                          isPassword: true,
                          hintText: "Password",
                          icon: Icons.lock,
                          onChange: (value) {},
                        ),
                        RoundedInputField(
                          controller: repeatPasswordController,
                          isEmail: false,
                          isPassword: true,
                          hintText: "Repeat Password",
                          icon: Icons.lock,
                          onChange: (value) {},
                        ),
                        RoundedButton(
                          text: isLoading ? "Loading..." : "REGISTER",
                          press: isLoading ? null : () => handleRegister(), // DOĞRU SİNTAX
                          color: const Color(0xFF3F3D56),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        indent: 50,
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Or Continue with",
                        style: AppTextStyle.MINI_DESCRIPTION_TEXT,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        endIndent: 50,
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SquareBox(imagePath: "assets/logo/google.png"),
                  SizedBox(width: 25),
                  SquareBox(imagePath: "assets/logo/apple-logo.png"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already Have an Account? ",
                    style: AppTextStyle.MINI_DEFAULT_DESCRIPTION_TEXT,
                  ),
                  const SizedBox(width: 3),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Login",
                      style: AppTextStyle.MINI_DESCRIPTION_TEXT,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
            ],
          ),
        ],
      ),
    );
  }
}
