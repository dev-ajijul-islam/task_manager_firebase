import 'package:flutter/material.dart';

void createTaskDialog({required BuildContext context}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Dismiss",
    pageBuilder: (context, animation, secondaryAnimation) {
      return Align(
        alignment: Alignment.center,
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            padding: .all(20),
            decoration: BoxDecoration(
              borderRadius: .circular(10),
              color: Colors.white,
            ),
            margin: .symmetric(horizontal: 15),
            width: double.infinity,
            child: Column(
              mainAxisSize: .min,
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      "Create New Task",
                      style: TextTheme.of(context).titleLarge,
                    ),
                    IconButton(onPressed: () {
                      
                    }, icon: Icon(Icons.close))
                  ],
                ),
                Form(
                  child: Column(
                    spacing: 5,
                    mainAxisAlignment: .start,
                    crossAxisAlignment: .start,
                    children: [
                      Text("Task Title",style: TextTheme.of(context).titleMedium,),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter Task Title"
                        ),
                      ),   Text("Task Title",style: TextTheme.of(context).titleMedium,),
                      TextFormField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Enter Task Title"
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
