import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brichbackoffice/ui/signin/signinViewModel.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brichbackoffice/ui/signin/signinViewModel.dart';

class LoginPage extends StatelessWidget {
  final AuthViewModel viewModel = Get.find<AuthViewModel>(); // Utilisez Get.find pour récupérer l'instance

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connexion')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return Column(
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Mot de passe'),
              ),
              const SizedBox(height: 20),
              if (viewModel.isLoading.value)
                const CircularProgressIndicator(),
              if (viewModel.loginError.value.isNotEmpty)
                Text(viewModel.loginError.value, style: const TextStyle(color: Colors.red)),
              ElevatedButton(
                onPressed: () {
                  if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                    viewModel.loginError.value = 'Veuillez remplir tous les champs.';
                    return;
                  }
                  viewModel.signIn(emailController.text, passwordController.text);
                },
                child: const Text('Se connecter'),
              ),
            ],
          );
        }),
      ),
    );
  }
}