import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../ui/input_decorations.dart';
import 'package:flutter_application_1/providers/login_form_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                      'Iniciar Sesión',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall!.copyWith(color: Colors.pinkAccent),
                    ),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: const LoginForm(),
                    ),
                    const SizedBox(height: 30),
                    TextButton(
                      onPressed:
                          () => Navigator.pushReplacementNamed(
                            context,
                            'register',
                          ),
                      style: TextButton.styleFrom(foregroundColor: Colors.pink),
                      child: const Text('¿No tienes cuenta? Regístrate aquí'),
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

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

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
              hinText: 'correo@ejemplo.com',
              labelText: 'Correo electrónico',
              prefixIcon: Icons.email_outlined,
            ),
            onChanged: (value) => loginForm.email = value,
            validator:
                (value) =>
                    (value != null && value.contains('@'))
                        ? null
                        : 'Correo inválido',
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
            validator:
                (value) =>
                    (value != null && value.length >= 6)
                        ? null
                        : 'Mínimo 6 caracteres',
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
            child: Text(
              loginForm.isLoading ? 'Espere...' : 'Ingresar',
              style: const TextStyle(color: Colors.white, fontSize: 16),
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

                      final String? errorMessage = await authService.login(
                        loginForm.email,
                        loginForm.password,
                      );

                      if (errorMessage == null) {
                        Navigator.pushReplacementNamed(context, 'home');
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
