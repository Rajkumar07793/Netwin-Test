import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:netwin_test/bloc/selection_bloc/selection_bloc.dart';
import 'package:netwin_test/bloc/selection_bloc/selection_bloc_events.dart';
import 'package:netwin_test/bloc/selection_bloc/selection_bloc_states.dart';
import 'package:netwin_test/globals/widgets/loader.dart';
import 'package:netwin_test/models/city_model.dart';
import 'package:netwin_test/views/drop_down_btn.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<String> filters = [
    "Filters",
    "Latest",
    "High Rated",
  ];

  List<String> priceFilter = [
    "Price",
    "Low to High",
    "High to Low",
  ];

  List<String> sortFilter = [
    "Sort",
    "Name",
    "Date created",
    "Date added",
  ];

  var selectFilterBloc = SelectionBloc(SelectionBlocInitialState());
  var selectPriceBloc = SelectionBloc(SelectionBlocInitialState());
  var selectSortBloc = SelectionBloc(SelectionBlocInitialState());
  var selectFvrtBloc = SelectionBloc(SelectionBlocInitialState())
    ..add(SelectBoolEvent(false));
  List<HotelData> hotels = [];

  Future<List<HotelData>>? readHotelsData;

  Future<List<HotelData>> getHotels() async {
    final String response =
        await rootBundle.loadString('assets/json/city.json');
    List data = await json.decode(response);
    hotels = data.map((e) => HotelData.fromJson(e)).toList();
    return hotels;
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Future<void> _goToTheLake(CameraPosition newHotelLatLong) async {
    final GoogleMapController controller = await _controller.future;
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(newHotelLatLong));
  }

  @override
  void initState() {
    readHotelsData = getHotels();
    selectFilterBloc.add(SelectStringEvent(filters.first));
    selectPriceBloc.add(SelectStringEvent(priceFilter.first));
    selectSortBloc.add(SelectStringEvent(sortFilter.first));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropDownBtn(bloc: selectFilterBloc, items: filters),
                DropDownBtn(bloc: selectPriceBloc, items: priceFilter),
                DropDownBtn(bloc: selectSortBloc, items: sortFilter),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                  future: readHotelsData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      hotels = snapshot.data!;
                      if (hotels.isNotEmpty) {
                        return Stack(
                          children: [
                            GoogleMap(
                              // mapType: MapType.normal,
                              // liteModeEnabled: true,
                              markers: hotels
                                  .map((hotel) => Marker(
                                      markerId:
                                          MarkerId(hotel.hotelId.toString()),
                                      position: LatLng(
                                          hotel.latitude, hotel.longitude),
                                      // icon: BitmapDescriptor.fromBytes(byteData)
                                      infoWindow: InfoWindow(
                                          title: hotel.hotelName,
                                          snippet: "₹ ${hotel.ratesFrom}")))
                                  .toSet(),
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                  hotels.first.latitude,
                                  hotels.first.longitude,
                                ),
                                zoom: 15,
                              ),
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: CarouselSlider.builder(
                                  itemCount: hotels.length,
                                  itemBuilder: (context, index, realIndex) =>
                                      InkWell(
                                        onTap: () {
                                          _goToTheLake(CameraPosition(
                                            target: LatLng(
                                              hotels[index].latitude,
                                              hotels[index].longitude,
                                            ),
                                            bearing: 192.8334901395799,
                                            tilt: 59.440717697143555,
                                            zoom: 19.151926040649414,
                                          ));
                                        },
                                        child: Card(
                                          elevation: 10,
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Image.network(
                                                hotels[index].photo1,
                                                height: 160,
                                                width: 100,
                                                fit: BoxFit.cover,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            hotels[index]
                                                                .hotelName,
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        BlocBuilder(
                                                            bloc:
                                                                selectFvrtBloc,
                                                            builder: (context,
                                                                state) {
                                                              if (state
                                                                  is SelectBoolState) {
                                                                return IconButton(
                                                                  visualDensity:
                                                                      VisualDensity
                                                                          .compact,
                                                                  onPressed:
                                                                      () {
                                                                    selectFvrtBloc.add(
                                                                        SelectBoolEvent(
                                                                            !state.value));
                                                                  },
                                                                  icon: Icon(
                                                                    state.value
                                                                        ? Icons
                                                                            .favorite
                                                                        : Icons
                                                                            .favorite_border_outlined,
                                                                    color: state.value
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .grey,
                                                                  ),
                                                                );
                                                              }
                                                              return const Loader();
                                                            }),
                                                      ],
                                                    ),
                                                    RatingBar(
                                                      ratingWidget:
                                                          RatingWidget(
                                                              full: const Icon(
                                                                Icons
                                                                    .star_rounded,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                              empty: const Icon(
                                                                  Icons
                                                                      .star_border_rounded),
                                                              half: const Icon(
                                                                Icons
                                                                    .star_half_rounded,
                                                                color: Colors
                                                                    .amber,
                                                              )),
                                                      onRatingUpdate:
                                                          (rating) {},
                                                      initialRating:
                                                          hotels[index]
                                                              .starRating,
                                                      itemCount: 4,
                                                      itemSize: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.blue,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topRight: Radius
                                                                  .circular(0),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                              topLeft: Radius
                                                                  .circular(10),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            "${hotels[index].ratingAverage}",
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              hotels[index]
                                                                          .ratingAverage <
                                                                      7
                                                                  ? "Good"
                                                                  : "Excellent",
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                // fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              "${hotels[index].numberOfReviews} reviews",
                                                              style:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                // fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Container(
                                                            color: Colors.red,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            child: const Text(
                                                              "-63%",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                          const Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical:
                                                                        2),
                                                            child: Text(
                                                              "₹ 22104",
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical:
                                                                        2),
                                                            child: Text(
                                                              "₹ ${hotels[index].ratesFrom}",
                                                              style:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                  options: CarouselOptions(height: 190)),
                            )
                          ],
                        );
                      }
                      return const Loader();
                    }
                    return const Loader();
                  }),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }
}
