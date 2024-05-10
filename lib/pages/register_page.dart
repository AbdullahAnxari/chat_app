import '../lib.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void register() {
      if (!_formKey.currentState!.validate()) {
        Get.showSnackbar(const GetSnackBar(
          message: 'Please fill in all fields',
        ));
        return;
      }
      if (passwordController.text != confirmPasswordController.text) {
        debugPrint(' Passwords do not match');
        Get.showSnackbar(const GetSnackBar(
          message: 'Passwords do not match',
        ));
        return;
      }
      final authServices = AuthServices();
      try {
        authServices.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Get.to(() => HomePage());
      } catch (e) {
        Get.showSnackbar(GetSnackBar(message: e.toString()));
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              const SizedBox(height: 50),
              Text(
                'Register',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: emailController,
                hintText: 'Email',
                validator: _validateEmail,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: passwordController,
                hintText: 'Password',
                validator: _validatePassword,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  fixedSize: const Size(300, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    register();
                  }
                },
                child: const Text('Register',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
              //
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text("Already have an account?"),
                  const SizedBox(width: 5),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const LoginPage());
                    },
                    child: const Text('Login',
                        style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        fillColor: Colors.grey[100],
        filled: controller.text.isNotEmpty,
        hintStyle: const TextStyle(color: Colors.black),
      ),
      validator: validator,
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
