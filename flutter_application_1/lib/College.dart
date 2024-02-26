import 'package:flutter/material.dart';
import 'package:flutter_application_1/CollegeCourses.dart';
import 'package:flutter_application_1/Style/widgets.dart';

class College extends StatefulWidget{
  const College({
    super.key,
    required this.messages,
  });

  final List<CollegeCourses> messages;

  @override
  CollegeState createState() => CollegeState();

}

class CollegeState extends State<College> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'CollegeState');
  final _controller = TextEditingController();

  @override
  // Modify from here...
  Widget build(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Row(
              children: [
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        for (var message in widget.messages)
          Paragraph(message.Name, message.coursesOffered),
        const SizedBox(height: 16),
      ],
    );
  }
}