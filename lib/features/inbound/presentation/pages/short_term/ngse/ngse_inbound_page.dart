// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:rotary_nl_rye/features/inbound/data/ngse_students_data.dart';
import 'package:rotary_nl_rye/features/inbound/presentation/models/ngse_student_model.dart';
import 'package:rotary_nl_rye/features/inbound/presentation/pages/short_term/ngse/ngse_student_details_page.dart';

class NGSEInboundStudentsPage extends StatefulWidget {
  @override
  _NGSEInboundStudentsPageState createState() =>
      _NGSEInboundStudentsPageState();
}

class _NGSEInboundStudentsPageState extends State<NGSEInboundStudentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: BackButton(),
        title: Text(
          'NGSE Inbound Students',
          style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return buildStudentCard(
            context,
            student,
          );
        },
      ),
    );
  }

  Widget buildStudentCard(BuildContext context, NGSEStudent student) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StudentDetailPage(
                  name: student.name,
                  country: student.country,
                  combinedText: student.combinedText, // Pass combinedText
                  imagePath: student.imageUrl,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  student.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Country: ${student.country}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  student.combinedText,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
