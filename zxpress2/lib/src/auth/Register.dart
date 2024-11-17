import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zxpress2/src/assets/modelo.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>(); // Añadí un GlobalKey para el formulario
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu nombre';
    } else if (value.length < 3 || value.length > 10) {
      return 'El nombre debe tener entre 3 y 10 caracteres.';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu correo electrónico';
    }
    RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@unah\.hn$');
    if (!emailRegex.hasMatch(value)) {
      return 'Correo no válido, debe ser @unah.hn';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu número de teléfono';
    }
    RegExp phoneRegex = RegExp(r'^[39]\d{7}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Teléfono inválido, debe iniciar con 3 o 9 y tener 8 números.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa una contraseña';
    } else if (value.length < 8 ||
        !RegExp(r'[A-Z]').hasMatch(value) ||
        !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'La contraseña debe tener al menos 8 caracteres, una mayúscula y un carácter especial.';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor confirma tu contraseña';
    } else if (value != _passwordController.text) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  void _register() {
  if (_formKey.currentState?.validate() ?? false) {
    User user = User(
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      password: _passwordController.text,
    );

    print('Usuario registrado: ${user.name}, ${user.email}, ${user.phone}');

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Registro exitoso'),
    ));

    context.go('/');  
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Por favor, corrige los errores en el formulario'),
    ));
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrarse')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, 
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: _validateName, 
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Correo'),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail, 
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.phone,
                validator: _validatePhone, 
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                validator: _validatePassword, 
              ),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(labelText: 'Confirmar Contraseña'),
                validator: _validateConfirmPassword, // Usamos la validación de confirmación de contraseña
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){
                  _register();
                },
                child: Text('Registrarse'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.go('/'); 
                },
                child: const Text('Volver al login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}