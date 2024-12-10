import 'package:brichbackoffice/config/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:brichbackoffice/ui/signin/signinViewModel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthViewModel viewModel = Get.find<AuthViewModel>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  String _emailError = '';
  String _passwordError = '';

  void _validateInputs() {
    setState(() {
      _emailError = _validateEmail(emailController.text);
      _passwordError = _validatePassword(passwordController.text);
    });
  }

  String _validateEmail(String email) {
    if (email.isEmpty) return 'Email cannot be empty';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(email)) return 'Invalid email format';
    return '';
  }

  String _validatePassword(String password) {
    if (password.isEmpty) return 'Password cannot be empty';
    if (password.length < 6) return 'Password must be at least 6 characters';
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF2A2D3E),
              Colors.purple[700]!,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Obx(() {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: 120,
                          height: 120,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Welcome Back',
                          style: GoogleFonts.roboto(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2A2D3E),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sign in to continue to your dashboard',
                          style: GoogleFonts.roboto(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        _buildTextField(
                          controller: emailController,
                          labelText: 'Email',
                          icon: Icons.email_outlined,
                          errorText: _emailError,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: passwordController,
                          labelText: 'Password',
                          icon: Icons.lock_outlined,
                          errorText: _passwordError,
                          isPassword: true,
                        ),
                        const SizedBox(height: 16),
                        _buildRememberAndForgot(),
                        const SizedBox(height: 24),
                        _buildSignInButton(),
                        const SizedBox(height: 16),
                        if (viewModel.loginError.value.isNotEmpty)
                          Text(
                            viewModel.loginError.value,
                            style: GoogleFonts.roboto(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        const SizedBox(height: 16),
                        _buildSignUpRow(),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    String? errorText,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword && !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.roboto(color: Colors.grey[700]),
        prefixIcon: Icon(icon, color: const Color(0xFF2A2D3E)),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey[700],
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
        errorText: errorText?.isNotEmpty == true ? errorText : null,
        errorStyle: GoogleFonts.roboto(color: Colors.red),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF2A2D3E), width: 2),
        ),
      ),
      style: GoogleFonts.roboto(),
    );
  }

  Widget _buildRememberAndForgot() {
    return Row(
      children: [
        Checkbox(
          value: _rememberMe,
          onChanged: (bool? value) {
            setState(() {
              _rememberMe = value ?? false;
            });
          },
          activeColor: const Color(0xFF2A2D3E),
        ),
        Text(
          'Remember me',
          style: GoogleFonts.roboto(),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            // Implement forgot password navigation
          },
          child: Text(
            'Forgot password?',
            style: GoogleFonts.roboto(
              color: const Color(0xFF2A2D3E),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignInButton() {
    return ElevatedButton(
      onPressed: () {
        _validateInputs();
        if (_emailError.isEmpty && _passwordError.isEmpty) {
          Get.toNamed(AppRoutes.dashboardPage);
          if (_rememberMe) {
            // Implement saving credentials securely
          }

          // Perform login
          viewModel.signIn(emailController.text, passwordController.text);
        }
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: const Color(0xFF2A2D3E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: viewModel.isLoading.value
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(
              'Sign In',
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }

  Widget _buildSignUpRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: GoogleFonts.roboto(),
        ),
        TextButton(
          onPressed: () {
            // Navigate to signup page
            Get.toNamed('/signup');
          },
          child: Text(
            'Sign Up',
            style: GoogleFonts.roboto(
              color: const Color(0xFF2A2D3E),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}