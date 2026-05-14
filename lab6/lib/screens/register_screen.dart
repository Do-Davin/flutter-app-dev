import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF8C5A3C);
const Color backgroundColor = Color(0xFFF5E6D8);

enum Skill { beginner, intermediate, advanced }

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  Skill _level = Skill.beginner;
  bool _agreed = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _submitForm() {
    bool formIsValid = _formKey.currentState!.validate();

    if (formIsValid && _agreed) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return SuccessScreen(name: _nameCtrl.text);
          },
        ),
      );
    }

    if (formIsValid && !_agreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to the terms first.')),
      );
    }
  }

  String _skillText(Skill skill) {
    if (skill == Skill.beginner) {
      return 'Beginner';
    } else if (skill == Skill.intermediate) {
      return 'Intermediate';
    } else {
      return 'Advanced';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration Form')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Create Account',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passCtrl,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'Skill Level',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                RadioGroup<Skill>(
                  groupValue: _level,
                  onChanged: (value) {
                    setState(() {
                      _level = value!;
                    });
                  },
                  child: Column(
                    children: [
                      RadioListTile<Skill>(
                        title: Text(_skillText(Skill.beginner)),
                        value: Skill.beginner,
                        activeColor: primaryColor,
                      ),
                      RadioListTile<Skill>(
                        title: Text(_skillText(Skill.intermediate)),
                        value: Skill.intermediate,
                        activeColor: primaryColor,
                      ),
                      RadioListTile<Skill>(
                        title: Text(_skillText(Skill.advanced)),
                        value: Skill.advanced,
                        activeColor: primaryColor,
                      ),
                    ],
                  ),
                ),
                CheckboxListTile(
                  title: const Text('I agree to the terms and conditions'),
                  value: _agreed,
                  activeColor: primaryColor,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) {
                    setState(() {
                      _agreed = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Padding(
                    padding: EdgeInsets.all(14),
                    child: Text('Register', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Success')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: primaryColor, size: 90),
              const SizedBox(height: 20),
              const Text(
                'Registration Successful!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Welcome, $name.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
