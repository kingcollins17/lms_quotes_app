// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_quotes_app/controllers/controller.dart';

import 'package:lms_quotes_app/constants.dart';
import 'package:lms_quotes_app/screens.dart';

class SearchListScreen extends GetWidget<QuotesController> {
  @override
  Widget build(BuildContext context) {
    final loadingIndicator = Center(
      child: SizedBox.square(
          dimension: 30, child: CircularProgressIndicator(strokeWidth: 3.0, color: cerulean)),
    );
    return Stack(
      children: [
        Material(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
              child: Column(children: [
                spacer(y: 10),
                SearchBar(
                    onChanged: controller.search,
                    hintText: 'Search Quote',
                    trailing: [Icon(Icons.search, size: 25), spacer()]),
                spacer(y: 15),
                //
                Expanded(child: Obx(() {
                  final hasSearchResults = controller.hasSearchResults;
                  final searchResults = controller.searchResults.value;
                  return hasSearchResults
                      ? ListView.builder(
                          itemCount: searchResults.length,
                          itemBuilder: (context, i) => QuoteItem(data: searchResults[i]))
                      : Center(
                          child: Text(
                            'No results yet ...',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        );
                }))
              ]),
            ),
          ),
        ),
        GetBuilder<QuotesController>(
          builder: (ctrl) => ctrl.isLoading.value ? loadingIndicator : SizedBox(),
        )
      ],
    );
  }
}
