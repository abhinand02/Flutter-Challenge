import 'dart:convert';

import "package:flutter/material.dart";
import 'package:students_record/add_student.dart';
import 'package:students_record/constants/styles.dart';
import 'package:students_record/db/db.dart';
import 'package:students_record/db/functions/db_functions.dart';
import 'student_details.dart';

class StudentsRecord extends StatefulWidget {
  const StudentsRecord({super.key});

  @override
  State<StudentsRecord> createState() => _StudentsRecordState();
}

class _StudentsRecordState extends State<StudentsRecord> {
  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
        child: Column(
          children: [
            studentsList(context),
          ],
        ),
      ),
      floatingActionButton: studentDataAddButton(context),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        'Students Record',
        style: whiteColor,
      ),
      centerTitle: true,
    );
  }

  FloatingActionButton studentDataAddButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddStudentPage()));
      },
      child: const Icon(
        Icons.person_add_alt_rounded,
        color: Colors.white,
      ),
    );
  }

  Expanded studentsList(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
          valueListenable: studentListNotifier,
          builder: (BuildContext ctx, List<StudentModel> studentList,
              Widget? child) {
            return ListView.separated(
                itemBuilder: (ctx, index) {
                  final data = studentList[index];
                  return ListTile(
                    onTap: () {
                      if (data.image == null) {
                        return;
                      }
                      // print(data.image);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => StudentDetails(
                            id: data.id!,
                            name: data.name,
                            age: data.age,
                            phnNumber: data.phnnumber,
                            sclass: data.standard,
                            image: data.image!,
                          ),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundImage:
                          data.image != null ? MemoryImage(data.image!) : null,
                      radius: 30,
                    ),
                    title: Text(data.name),
                    subtitle: Text("class: ${data.standard}"),
                    trailing: IconButton(
                      onPressed: () {
                        if (data.id != null) {
                          deletestudent(context, data.id!);
                        } else {
                          print('unable to delete id is null');
                        }
                      },
                      icon: Icon(Icons.delete),
                    ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const Divider();
                },
                itemCount: studentList.length);
          }),
    );
  }

  deletestudent(BuildContext ctx, int id) async {
    return showDialog(
      context: ctx,
      builder: (ctx1) {
        return AlertDialog(
          content: Text(
            'Are you sure to delete?',
            style: popupHeading,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: buttonTextStyle,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    deleteStudent(id);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Yes',
                    style: buttonTextStyle,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
