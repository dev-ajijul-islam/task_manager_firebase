import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/data/services/firebase_services.dart';
import 'package:task_manager_firebase/app/routes/app_routes.dart';

class TopbarWidget extends StatelessWidget {
  const TopbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .only(top: 20, right: 20, left: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisAlignment: .spaceBetween,
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              StreamBuilder(
                stream: FirebaseServices.auth.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data == null) {
                    return SizedBox();
                  }
                  return Row(
                    spacing: 10,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: snapshot.data?.photoURL != null
                            ? NetworkImage(snapshot.data!.photoURL.toString())
                            : AssetImage("assets/images/dummy_profile.png"),
                      ),
                      Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            "Welcome back!",
                            style: TextTheme.of(context).titleMedium?.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "${snapshot.data?.displayName}",
                            style: TextTheme.of(context).bodyMedium?.copyWith(
                              color: ColorScheme.of(context).primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search_outlined,
                      size: 25,
                      color: ColorScheme.of(context).primary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_outlined,
                      size: 25,
                      color: ColorScheme.of(context).primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(color: Colors.grey.shade400),
        ],
      ),
    );
  }
}
