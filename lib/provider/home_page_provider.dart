import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePageProvider extends ChangeNotifier {
  List<Map<String, dynamic>> bannerData = [];

  List<Map<String, dynamic>> mainCategories = [];

  List<Map<String, dynamic>> topDeals = [];

  List<Map<String, dynamic>> newArrivals = [];

  List<Map<String, dynamic>> trendingOffers = [];

  List<Map<String, dynamic>> ourPartners = [];

  //////////////////////////////// Banners /////////////////////////////////////

  Future<void> fetchBannerData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:4000/banners'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      bannerData =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      notifyListeners();
      // print(bannerData);
    } else {
      throw Exception('Failed to load data');
    }
  }

  ////////////////////////// Main - Categories /////////////////////////////////////

  Future<void> fetchMainCategories() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:4000/main-categories'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      mainCategories =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      notifyListeners();
      // print('----------------------------');
      // print(mainCategories);
    } else {
      throw Exception('Failed to load data');
    }
  }

///////////////////////////////// top-deals ////////////////////////////////////

  Future<void> fetchTopDeals() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:4000/product-list/top-deals'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      topDeals =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      notifyListeners();
      print('----------top------------------');
      // print(topDeals);
    } else {
      throw Exception('Failed to load data');
    }
  }

  //////////////////////////// new-arrivals ////////////////////////////////////

  Future<void> fetchNewArrivals() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:4000/product-list/new-arrivals'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      newArrivals =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      notifyListeners();
      print('-----------new-arrivals-----------------');
      // print(newArrivals);
    } else {
      throw Exception('Failed to load data');
    }
  }

///////////////////////////////// trending-offers //////////////////////////////

  Future<void> fetchTrendingOffers() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:4000/product-list/trending-offers'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      trendingOffers =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      notifyListeners();
      print('-----------trending-----------------');
      // print(trendingOffers);
    } else {
      throw Exception('Failed to load data');
    }
  }

////////////////////////// Our-Partners ////////////////////////////////////////

  Future<void> fetchOurPartners() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:4000/partners-list'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      ourPartners =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      notifyListeners();
      print('-----------our-partner-----------------');
      print(ourPartners);
    } else {
      throw Exception('Failed to load data');
    }
  }

  // List<BannerModel> get data => _data;

  // void setBannerData(List<Map<String, dynamic>> jsonData) {
  //   _data = jsonData.map((json) => BannerModel.fromJson(json)).toList();
  //   print('object');
  //   print(_data);
  //   notifyListeners();
  // }
}
