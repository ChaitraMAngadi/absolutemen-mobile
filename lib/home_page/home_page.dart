import 'package:absolutemen_app/autentication/login_page.dart';
import 'package:absolutemen_app/home_page/widgets/menu_details.dart';
import 'package:absolutemen_app/home_page/provider/home_page_provider.dart';
import 'package:absolutemen_app/routes/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'widgets/item_card.dart';
import 'widgets/review_card.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final review_controller = PageController();
  final saleposter_controller = PageController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    HomePageProvider homePageProvider = context.read<HomePageProvider>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Image(
          height: 56,
          // width: 79,
          image: AssetImage('assets/svg/main_logo.png'),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.heart,
              color: Colors.black,
              size: 24,
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                FontAwesomeIcons.bagShopping,
                color: Colors.black,
                size: 24,
              )),
          PopupMenuButton(
            color: Colors.white,
            offset: const Offset(0, 42),
            itemBuilder: (context) => [
              PopupMenuItem(
                  onTap: () => context.router.push(LoginRoute()),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )),
              PopupMenuItem(
                  onTap: () => context.router.push(const SignUpRoute()),
                  child: const Text(
                    "Register",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )),
            ],
            child: const Icon(
              Icons.account_circle_outlined,
              color: Colors.black,
              size: 24,
            ),
          ),
          // IconButton(
          //   onPressed: () {

          //   },
          //   icon: const Icon(
          //     Icons.account_circle_outlined,
          //     color: Colors.black,
          //     size: 24,
          //   ),
          // ),
          IconButton(
              onPressed: () => scaffoldKey.currentState!.openEndDrawer(),
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
                size: 24,
              )),
        ],
      ),
      endDrawer: const MenuDetails(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 150,
                child: FutureBuilder(
                    future: homePageProvider.fetchBannerData(),
                    builder: (context, snapshot) {
                      return PageView.builder(
                        controller: saleposter_controller,
                        scrollDirection: Axis.horizontal,
                        itemCount: homePageProvider.bannerData.length,
                        itemBuilder: (context, index) {
                          final item = homePageProvider.bannerData[index];
                          return Container(
                            height: 150,
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        //  NetworkImage(item['web_image']),
                                        AssetImage(
                                            'assets/images/banners/${item['web_image']}'),
                                    fit: BoxFit.fill),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            // child: Text(item['id'].toString()),
                          );
                        },
                      );
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: SmoothPageIndicator(
                  controller: saleposter_controller,
                  count: 2,
                  effect: ColorTransitionEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: const Color(0xFF2556B9),
                      dotColor: Colors.black.withOpacity(0.1)),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "START SHOPPING BY CATEGORY",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 250,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: FutureBuilder(
                    future: homePageProvider.fetchMainCategories(),
                    builder: (context, snapshot) => GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                          ),
                          itemCount: homePageProvider.mainCategories.length,
                          itemBuilder: (context, index) {
                            final item = homePageProvider.mainCategories[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              height: 106,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        // NetworkImage(item['app_image']),
                                        AssetImage(
                                            'assets/images/${item['app_image']}'),
                                    fit: BoxFit.fill),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                              ),
                            );
                          },
                        )),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "TOP DEALS",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.symmetric(vertical: 32),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFF2556B9), Color(0xFF132B5D)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: Column(
                  children: [
                    SizedBox(
                        height: 340,
                        child: FutureBuilder(
                            future: homePageProvider.fetchTopDeals(),
                            builder: (context, snapshot) {
                              return ListView.builder(
                                padding: const EdgeInsets.only(left: 8),
                                scrollDirection: Axis.horizontal,
                                itemCount: homePageProvider.topDeals.length,
                                itemBuilder: (context, index) {
                                  final item = homePageProvider.topDeals[index];
                                  // return Center(child: Text(item['name']));
                                  return ItemCard(
                                    brandName: item['brand_name'],
                                    name: item['name'],
                                    price: item['price'],
                                    salePrice: item['saleprice'],
                                    rating: item['review'],
                                    imagePath:
                                        'assets/images/productsimage/${item['image']}',
                                    // imageLink: userData[index].image,
                                  );
                                },
                              );
                            })),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 33,
                              vertical: 10,
                            )),
                        child: const Text(
                          "View All",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2556B9)),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "NEW ARRIVALS",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                  side: BorderSide(color: Color(0xFF2556B9)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 33,
                                vertical: 10,
                              )),
                          child: const Text(
                            "View All",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2556B9)),
                          ))
                    ],
                  )),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                  height: 340,
                  child: FutureBuilder(
                      future: homePageProvider.fetchNewArrivals(),
                      builder: (context, snapshot) {
                        return ListView.builder(
                          padding: const EdgeInsets.only(left: 8),
                          scrollDirection: Axis.horizontal,
                          itemCount: homePageProvider.newArrivals.length,
                          itemBuilder: (context, index) {
                            final item = homePageProvider.newArrivals[index];
                            // return Center(child: Text(item['name']));
                            return ItemCard(
                              brandName: item['brand_name'],
                              name: item['name'],
                              price: item['price'],
                              salePrice: item['saleprice'],
                              rating: item['review'],
                              imagePath:
                                  'assets/images/productsimage/${item['image']}',

                              // imageLink: userData[index].image,
                            );
                          },
                        );
                      })),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 150,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/bloom_sakura.jpg'),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.all(Radius.circular(16))),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "TRENDING OFFERS",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.symmetric(vertical: 32),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFF2556B9), Color(0xFF132B5D)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: Column(
                  children: [
                    SizedBox(
                        height: 340,
                        child: FutureBuilder(
                            future: homePageProvider.fetchTrendingOffers(),
                            builder: (context, snapshot) {
                              return ListView.builder(
                                padding: const EdgeInsets.only(left: 8),
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    homePageProvider.trendingOffers.length,
                                itemBuilder: (context, index) {
                                  final item =
                                      homePageProvider.trendingOffers[index];
                                  // return Center(child: Text(item['name']));
                                  return ItemCard(
                                    brandName: item['brand_name'],
                                    name: item['name'],
                                    price: item['price'],
                                    salePrice: item['saleprice'],
                                    rating: item['review'],
                                    imagePath:
                                        'assets/images/productsimage/${item['image']}',

                                    // imageLink: userData[index].image,
                                  );
                                },
                              );
                            })),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 33,
                              vertical: 10,
                            )),
                        child: const Text(
                          "View All",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2556B9)),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 34,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "OUR PARTNERS",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 160,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: FutureBuilder(
                    future: homePageProvider.fetchOurPartners(),
                    builder: (context, snapshot) => GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.5,
                          ),
                          itemCount: homePageProvider.ourPartners.length,
                          itemBuilder: (context, index) {
                            final item = homePageProvider.ourPartners[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              // height: 10,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      // NetworkImage(item['app_image']),
                                      AssetImage(
                                          'assets/images/ourPartners/${item['image']}'),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                              ),
                            );
                          },
                        )),
              ),
              const SizedBox(
                height: 24,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Our Customers’ Feedback",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "What Our Customers are Saying",
                  style: TextStyle(fontSize: 12, color: Color(0xFF2556B9)),
                ),
              ),
              const SizedBox(
                height: 21,
              ),
              SizedBox(
                  height: 400,
                  child: PageView(
                    controller: review_controller,
                    // padding: const EdgeInsets.only(left: 8),
                    scrollDirection: Axis.horizontal,
                    children: const [ReviewCard(), ReviewCard(), ReviewCard()],
                  )),
              const SizedBox(
                height: 12,
              ),
              Align(
                  alignment: Alignment.center,
                  child: SmoothPageIndicator(
                    effect: ExpandingDotsEffect(
                      activeDotColor: Colors.black.withOpacity(0.5),
                      dotColor: Colors.black.withOpacity(0.1),
                      radius: 50,
                      dotHeight: 12,
                      dotWidth: 12,
                    ),
                    controller: review_controller,
                    count: 3,
                  )),
              const SizedBox(
                height: 42,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 150,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/video.jpg'),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.all(Radius.circular(16))),
              ),
              const SizedBox(
                height: 42,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 31),
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Popular Category",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 100,
                      // margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: FutureBuilder(
                          future: homePageProvider.fetchMainCategories(),
                          builder: (context, snapshot) => GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 2.2,
                                ),
                                itemCount:
                                    homePageProvider.mainCategories.length,
                                itemBuilder: (context, index) {
                                  final item =
                                      homePageProvider.mainCategories[index];
                                  return Text(
                                    item['category_name'],
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  );
                                },
                              )),
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.grey[300],
                      // color: Color(0xFF0000001A),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Popular Searches",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Hari Fall | Shampoo | Face Cream | Hair Oil | Grooming Kit | Saving Cream | Fitness | Hari Fall | Shampoo | Face Cream | Hair Oil | Grooming Kit | Saving Cream | Fitness | Hari Fall | Shampoo | Face Cream | Hair Oil | Grooming Kit | Saving Cream | Fitness | Hari Fall | Shampoo | Face Cream | Hair Oil | Grooming Kit | Hari Fall | Shampoo | Face Cream | Hair Oil | Grooming Kit | Saving Cream | Fitness | Hari Fall",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[800],
                          letterSpacing: 0.1),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.grey[300],
                      // color: Color(0xFF0000001A),
                    ),
                    const SizedBox(
                      height: 42,
                    ),
                    Text(
                      "© 2022 - 2023 Copyright AbsoluteMen Private Limited",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Wrap(
                      children: [
                        GestureDetector(
                            onTap: () {},
                            //            style: ButtonStyle(
                            // padding: MaterialStateProperty.all(EdgeInsetsDirectional.all(0))
                            //            ),
                            child: const Text(
                              'Terms and Conditions',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF2556B9),
                                  fontWeight: FontWeight.bold),
                            )),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 2),
                          height: 14,
                          width: 1.8,
                          color: Colors.grey[900],
                        ),
                        GestureDetector(
                            onTap: () {},
                            //            style: ButtonStyle(
                            // padding: MaterialStateProperty.all(EdgeInsetsDirectional.all(0))
                            //            ),
                            child: const Text(
                              'Privacy Policy',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2556B9),
                              ),
                            )),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 2),
                          height: 14,
                          width: 1.8,
                          color: Colors.grey[900],
                        ),
                        GestureDetector(
                            onTap: () {},
                            //            style: ButtonStyle(
                            // padding: MaterialStateProperty.all(EdgeInsetsDirectional.all(0))
                            //            ),
                            child: const Text(
                              'Cancellation And Refund Policy',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2556B9),
                              ),
                            )),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 2),
                          height: 14,
                          width: 1.8,
                          color: Colors.grey[900],
                        ),
                        GestureDetector(
                            onTap: () {},
                            //            style: ButtonStyle(
                            // padding: MaterialStateProperty.all(EdgeInsetsDirectional.zero)
                            //            ),
                            child: const Text(
                              'Delivery Partner',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2556B9),
                              ),
                            )),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 2),
                          height: 14,
                          width: 1.8,
                          color: Colors.grey[900],
                        ),
                        GestureDetector(
                            onTap: () {},
                            //            style: ButtonStyle(
                            // padding: MaterialStateProperty.all(EdgeInsetsDirectional.zero)
                            //            ),
                            child: const Text(
                              'Shipping Policy',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2556B9),
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    const Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.facebookF,
                          size: 20,
                          color: Color(0xFF2556B9),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Icon(
                          FontAwesomeIcons.youtube,
                          size: 20,
                          color: Color(0xFF2556B9),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Icon(
                          FontAwesomeIcons.twitter,
                          size: 20,
                          color: Color(0xFF2556B9),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Icon(
                          FontAwesomeIcons.instagram,
                          size: 20,
                          color: Color(0xFF2556B9),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<List<Products>> getData() async {
  //   final String response =
  //       await rootBundle.loadString('assets/topdetails.json');
  //   final data = await json.decode(response);
  //   // print(data);
  //   for (Map<String, dynamic> index in data) {
  //     userData.add(Products.fromJson(index));
  //   }
  //   return userData;
  // }
  //  Future<List<Products>> getData() async {
  //   final response = await http.get(Uri.parse('https://api.jsonserve.com/PwLzWQ'));
  //   var data = jsonDecode(response.body.toString());

  //   if (response.statusCode == 200) {
  // for (Map<String, dynamic> index in data) {
  //   userData.add(Products.fromJson(index));
  // }
  //     return userData;
  //   }
  //   return userData; //empty list
  // }
  // Future<void> fetchBannerData() async {
  //   final response = await http.get(Uri.parse('http://10.0.2.2:4000/banners'));
  //   var data = jsonDecode(response.body.toString());
  //   if (response.statusCode == 200) {
  //     print("hiiii");
  //     print(data);

  //     setState(() {
  //       _data = json.decode(response.body)['data'].cast<Map<String, dynamic>>();
  //     });
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }
}
