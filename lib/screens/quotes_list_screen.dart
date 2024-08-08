// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_quotes_app/constants.dart';

import 'package:http/http.dart' as http;
import 'package:lms_quotes_app/controllers/quotes_controller.dart';
import 'package:lms_quotes_app/screens/profile_dashboard_screen.dart';

import '../repository/repository.dart';

class QuotesListScreen extends StatelessWidget {
  const QuotesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuotesController>();
    final loadingIndicator = SizedBox.square(
      dimension: 25,
      child: CircularProgressIndicator(color: cerulean),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: stardust,
        foregroundColor: Colors.white,
        title: Text(
          'Quotes',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      drawer: _SimpleDrawer(),
      body: Obx(() {
        final isLoading = controller.isLoading.value;
        final hasQuotes = controller.hasQuotes;
        final quotes = controller.quotes.value;

        return isLoading
            ? Center(child: loadingIndicator)
            : hasQuotes
                ? ListView.builder(
                    itemCount: quotes.length,
                    itemBuilder: (context, i) => QuoteItem(
                      data: quotes[i],
                      showBorder: i != 0,
                    ),
                  )
                : Center(
                    child: Text('No Quotes', style: TextStyle(fontSize: 18)),
                  );
      }),
    );
  }
}

class _SimpleDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Material(
          color: Colors.white,
    
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
                child: Text(
              'Quotes App 1.0',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )),
            InkWell(
              onTap: () => Get.to(ProfileDashboardScreen()),
                child: Ink(
                  width: screen(context).width * 0.8,
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
                    child: Text('Profile',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))))
          ],
        ),
      ),
    ));
  }
}

class QuoteItem extends StatelessWidget {
  const QuoteItem({super.key, required this.data, this.showBorder = true});
  final Quote data;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: showBorder ? Border(top: BorderSide(color: Colors.grey)) : null,
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            Icons.copy,
            size: 20,
            color: cerulean,
          ),
          spacer(x: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.quote,
                  style: TextStyle(fontSize: 16),
                ),
                spacer(),
                Text(
                  data.author,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
