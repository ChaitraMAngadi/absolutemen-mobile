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

  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyZGF0YSI6NzY3MywiaWF0IjoxNzE3MTQ3NDc5fQ.vHoxikUMccIZoTa4AHAajLCU_KYzYVOJDp9wRE6iiRk";

  //////////////////////////////// Banners /////////////////////////////////////

  Future<void> fetchBannerData() async {
    final response = await http.get(
      //in the place of 10.0.2.2 in api use laptop local ip
      //adress while running the code by connecting to android
      Uri.parse('http://192.168.29.238:4000/app/banners'),
      //     headers: {
      //   'Authorization': 'Bearer $token',
      //   'Content-Type': 'application/json',
      // }
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      bannerData =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      notifyListeners();
      print('bannerdata');
      print(data);
      // print(bannerData);
    } else {
      throw Exception('Failed to load data');
    }
  }

  ////////////////////////// Main - Categories /////////////////////////////////////

  Future<void> fetchMainCategories() async {
    final response = await http
        .get(Uri.parse('http://192.168.29.238:4000/app/maincategories'));
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
        .get(Uri.parse('http://192.168.29.238:4000/app/productlist/topdeals'));
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
    final response = await http.get(
        Uri.parse('http://192.168.29.238:4000/app/productlist/newarrivals'));
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
    final response = await http.get(
        Uri.parse('http://192.168.29.238:4000/app/productlist/trendingoffers'));
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
        await http.get(Uri.parse('http://192.168.29.238:4000/app/partners'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      ourPartners =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      notifyListeners();
      print('-----------our-partner-----------------');
      // print(ourPartners);
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
