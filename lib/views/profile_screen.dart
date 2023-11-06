import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:netwin_test/globals/functions/loading_builder.dart';
import 'package:netwin_test/globals/widgets/custom_appbar.dart';
import 'package:netwin_test/models/get_users_response.dart';
import 'package:netwin_test/services/apis/get_users_api.dart';
import 'package:netwin_test/views/custom_web_view.dart';
import 'package:netwin_test/views/drawer.dart';
import 'package:netwin_test/views/menu.dart';
import 'package:table_calendar/table_calendar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<DateTime> bookings = [
    DateTime.parse("2023-11-09"),
    DateTime.parse("2023-11-13"),
    DateTime.parse("2023-11-23"),
  ];

  Future<GetUsersResponse>? getUsersApi;
  var connectivity = Connectivity();
  @override
  void initState() {
    getUsersApi = getUsers();
    connectivity.checkConnectivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Profile",
      ),
      drawer: const CustomDrawer(),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              minRadius: 80,
              backgroundImage: NetworkImage(
                "https://images.mid-day.com/images/images/2016/apr/27Robert-Downey-Jr-1.jpg",
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: const [
              Text(
                "Zara Briner",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                "Johannesburg, South Africa",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: Image.network(
                    "https://www.myfreetextures.com/wp-content/uploads/2014/10/seamless-wood3.jpg",
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    color: Colors.black26,
                    child: Row(
                      children: const [
                        Expanded(
                          child: RowItem(
                            title: "121",
                            subtitle: "Coming soon",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: VerticalDivider(
                            color: Colors.white,
                            thickness: 3,
                          ),
                        ),
                        Expanded(
                          child: RowItem(
                            title: "3",
                            subtitle: "Tabs",
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Menu(
            title: "Bookings",
            color: Colors.teal[900]!,
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    TableCalendar(
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: DateTime.now(),
                      calendarStyle: const CalendarStyle(
                          selectedDecoration: BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle)),
                      selectedDayPredicate: (day) => bookings.contains(
                          DateTime.parse(day.toString().split(" ")[0])),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    CarouselSlider(
                      items: const [
                        NextBookingItem(),
                        NextBookingItem(),
                        NextBookingItem(),
                      ],
                      options: CarouselOptions(
                        viewportFraction: 0.5,
                        height: 100,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Menu(
            title: "Reviews",
            color: Colors.green[800]!,
            children: const [],
          ),
          Menu(
            title: "History",
            color: Colors.red,
            children: [
              Container(
                height: 200,
                color: Colors.white,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: CarouselSlider(
                          items: [0, 1]
                              .map((e) => Image.network(
                                    'https://thumbs.dreamstime.com/b/cozy-restaurant-tables-ready-dinner-39875776.jpg',
                                    fit: BoxFit.fitWidth,
                                    width: MediaQuery.of(context).size.width,
                                    loadingBuilder: loadingBuilder,
                                  ))
                              .toList(),
                          options: CarouselOptions(
                            height: 250,
                            viewportFraction: 1,
                          )),
                    ),
                    Positioned(
                      right: 0,
                      top: 5,
                      child: Column(
                        children: [
                          Container(
                            color: Colors.black,
                            padding: const EdgeInsets.all(5),
                            child: const Icon(
                              Icons.share,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            color: Colors.black,
                            padding: const EdgeInsets.all(5),
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            color: Colors.black,
                            padding: const EdgeInsets.all(5),
                            child: const Icon(
                              Icons.fullscreen,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Monks Kitchen",
                      style: TextStyle(
                          color: Colors.green[700],
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.star,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("8.2")
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Menu(
            title: "Your Details",
            color: Colors.brown[700]!,
            children: [
              Container(
                color: Colors.white,
                child: StreamBuilder(
                    stream: connectivity.onConnectivityChanged,
                    builder:
                        (context, AsyncSnapshot<ConnectivityResult> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data! == ConnectivityResult.none) {
                          return const Text("No internet connection");
                        }
                        return FutureBuilder(
                          future: getUsersApi,
                          builder: (context,
                              AsyncSnapshot<GetUsersResponse> snapshot) {
                            if (snapshot.hasData) {
                              var users = snapshot.data!.data;
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: users.length,
                                itemBuilder: (context, index) => ListTile(
                                  leading: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Image.network(
                                      users[index].avatar,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Center(
                                                  child: Icon(Icons.error)),
                                      loadingBuilder: loadingBuilder,
                                      fit: BoxFit.cover,
                                      // loadingBuilder:
                                      //     (context, child, loadingProgress) =>
                                      //         const Loader(),
                                    ),
                                  ),
                                  title: Text(
                                      "${users[index].firstName} ${users[index].lastName}"),
                                  subtitle: Text(users[index].email),
                                ),
                              );
                            }
                            return const CircularProgressIndicator();
                          },
                        );
                      }
                      return const CircularProgressIndicator();
                    }),
              )
            ],
          ),
          Menu(
            title: "Wish List",
            color: Colors.brown[600]!,
            children: const [],
          ),
          Menu(
            title: "Suggestions",
            color: Colors.brown[500]!,
            children: [
              Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          // launchUrl(Uri.parse("https://www.lipsum.com"));
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const CustomWebView(
                                title: "Show Suggestion",
                                url: "https://www.lipsum.com"),
                          ));
                        },
                        child: const Text(("Show Suggestion"))),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class RowItem extends StatelessWidget {
  final String title;
  final String subtitle;
  const RowItem({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            // fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

class NextBookingItem extends StatelessWidget {
  const NextBookingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          "NEXT BOOKING",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
        Text("October 9th Gemeli"),
        Text("Table for 4 to 7 pm"),
      ],
    );
  }
}
