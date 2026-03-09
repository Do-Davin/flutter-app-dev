import 'package:flutter/material.dart';
import 'package:week2_profile/widgets/interactive_student_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: InteractiveStudentCard());
  }
}
