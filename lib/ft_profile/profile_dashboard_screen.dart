// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_quotes_app/constants.dart';
import 'package:lms_quotes_app/controllers/controller.dart';

class ProfileDashboardScreen extends StatelessWidget {
  const ProfileDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    final avatar = Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: cerulean,
        border: Border.all(color: heather, width: 4.0),
      ),
      child: Text(
        controller.user?.email?[0] ?? 'N',
        style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: SizedBox(
        width: screen(context).width,
        height: screen(context).height,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              spacer(y: 20),
              avatar,
              spacer(y: 20),
              Text(controller.user?.email ?? 'None', style: TextStyle(fontSize: 18)),
              spacer(y: 40),
              _ProfileItem(label: 'Email', value: controller.user?.email ?? 'None'),
              spacer(y: 15),
              _ProfileItem(label: 'First Name', value: 'Jon'),
              spacer(y: 15),
              _ProfileItem(label: 'Last Name', value: 'Doe'),
              spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  const _ProfileItem({required this.label, required this.value});
  final String label, value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screen(context).width,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.white, boxShadow: [
        BoxShadow(
          blurRadius: 3,
          offset: Offset(0, 2),
          color: cerulean.withOpacity(0.3),
        ),
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
