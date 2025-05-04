import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../ui/input_decorations.dart';
import 'package:flutter_application_1/providers/login_form_provider.dart';

class RegisterUserScreen extends StatelessWidget {
  const RegisterUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 150),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Crea tu cuenta',
                      style: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(color: Colors.pinkAccent),
                    ),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: const RegisterForm(),
                    ),
                    const SizedBox(height: 50),
                    TextButton(
                      onPressed:
                          () =>
                              Navigator.pushReplacementNamed(context, 'login'),
                      style: TextButton.styleFrom(foregroundColor: Colors.pink),
                      child: const Text('¿Ya tienes una cuenta? Inicia sesión'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecortions.authInputDecoration(
              hinText: 'ejemplo@email.com',
              labelText: 'Correo electrónico',
              prefixIcon: Icons.email_outlined,
            ),
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              return (value != null && value.length >= 4)
                  ? null
                  : 'El correo no puede estar vacío';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            decoration: InputDecortions.authInputDecoration(
              hinText: '********',
              labelText: 'Contraseña',
              prefixIcon: Icons.lock_outline,
            ),
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? null
                  : 'Debe tener mínimo 6 caracteres';
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            disabledColor: Colors.grey,
            color: Colors.pinkAccent,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 12),
            child: const Text(
              'Registrar',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed:
                loginForm.isLoading
                    ? null
                    : () async {
                      FocusScope.of(context).unfocus();
                      final authService = Provider.of<AuthService>(
                        context,
                        listen: false,
                      );

                      if (!loginForm.isValidForm()) return;

                      loginForm.isLoading = true;

                      final String? errorMessage = await authService.createUser(
                        loginForm.email,
                        loginForm.password,
                      );

                      if (errorMessage == null) {
                        Navigator.pushReplacementNamed(context, 'login');
                      } else {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(errorMessage)));
                        loginForm.isLoading = false;
                      }
                    },
          ),
        ],
      ),
    );
  }
}
