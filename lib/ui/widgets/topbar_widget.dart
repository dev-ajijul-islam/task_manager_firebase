import 'package:flutter/material.dart';

class TopbarWidget extends StatelessWidget {
  const TopbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisAlignment: .spaceBetween,
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Row(
                spacing: 10,
                children: [
                  CircleAvatar(radius: 25),
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        "Welcome back!",
                        style: TextTheme.of(context).titleMedium,
                      ),
                      Text(
                        "MD. Ajijul Islam",
                        style: TextTheme.of(context).bodyMedium?.copyWith(
                          color: ColorScheme.of(context).primary
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search_outlined,
                      size: 30,
                      color: ColorScheme.of(context).primary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_outlined,
                      size: 30,
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
