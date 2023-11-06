import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:netwin_test/bloc/selection_bloc/selection_bloc.dart';
import 'package:netwin_test/bloc/selection_bloc/selection_bloc_events.dart';
import 'package:netwin_test/bloc/selection_bloc/selection_bloc_states.dart';
import 'package:netwin_test/globals/widgets/loader.dart';
import 'package:netwin_test/models/city_model.dart';
import 'package:share_plus/share_plus.dart';

class HotelListItem extends StatefulWidget {
  final HotelData city;
  const HotelListItem({super.key, required this.city});

  @override
  State<HotelListItem> createState() => _HotelListItemState();
}

class _HotelListItemState extends State<HotelListItem> {
  List<String> images = [];

  var carouselController = CarouselController();
  var selectCurrentIndexBloc = SelectionBloc(SelectionBlocInitialState())
    ..add(SelectIntEvent(1));

  var selectFvrtBloc = SelectionBloc(SelectionBlocInitialState())
    ..add(SelectBoolEvent(false));
  add(String? image) {
    if (image != null && image.isNotEmpty) {
      images.add(image);
    }
  }

  @override
  void initState() {
    add(widget.city.photo1);
    add(widget.city.photo2);
    add(widget.city.photo3);
    add(widget.city.photo4);
    add(widget.city.photo5);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              // fit: StackFit.expand,
              children: [
                SizedBox(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: CarouselSlider.builder(
                      carouselController: carouselController,
                      itemCount: images.length,
                      itemBuilder: (context, index, realIndex) => ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              images[index],
                              fit: BoxFit.fitWidth,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                      options: CarouselOptions(
                        height: 250,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          selectCurrentIndexBloc.add(SelectIntEvent(index + 1));
                        },
                        // enlargeCenterPage: true,
                        // viewportFraction: 1,
                      )),
                ),
                Positioned(
                    left: 10,
                    bottom: 10,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(5)),
                      child: BlocBuilder(
                          bloc: selectCurrentIndexBloc,
                          builder: (context, state) {
                            if (state is SelectIntState) {
                              return Text(
                                "${state.value}/${images.length}",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              );
                            }
                            return Text(
                              "0/${images.length}",
                            );
                          }),
                    ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Promoted"),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.city.hotelName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        Share.share(widget.city.url);
                      },
                      icon: const Icon(
                        Icons.share,
                        color: Colors.grey,
                      ),
                    ),
                    BlocBuilder(
                        bloc: selectFvrtBloc,
                        builder: (context, state) {
                          if (state is SelectBoolState) {
                            return IconButton(
                              visualDensity: VisualDensity.compact,
                              onPressed: () {
                                selectFvrtBloc
                                    .add(SelectBoolEvent(!state.value));
                              },
                              icon: Icon(
                                state.value
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color: state.value ? Colors.red : Colors.grey,
                              ),
                            );
                          }
                          return const Loader();
                        }),
                  ],
                ),
              ],
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            Row(
              children: [
                RatingBar(
                  ratingWidget: RatingWidget(
                      full: const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                      ),
                      empty: const Icon(Icons.star_border_rounded),
                      half: const Icon(
                        Icons.star_half_rounded,
                        color: Colors.amber,
                      )),
                  onRatingUpdate: (rating) {},
                  initialRating: widget.city.starRating,
                  itemCount: 4,
                  itemSize: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.location_on,
                  color: Colors.grey,
                ),
                Text(
                  widget.city.city,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  "${widget.city.ratingAverage} ${widget.city.ratingAverage < 7 ? "Good" : "Excellent"}",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "${widget.city.numberOfReviews} reviews",
                  style: const TextStyle(
                    color: Colors.grey,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.blue.withOpacity(0.2)),
                onPressed: () {},
                child: const Text(
                  "Tap Value",
                  style: TextStyle(color: Colors.blue),
                )),
            const SizedBox(
              height: 10,
            )
          ],
        ),
        Positioned(
          top: 180,
          right: 10,
          child: SizedBox(
            height: 100,
            width: 120,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),

              // height: 150,
              // width: 150,
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   borderRadius: BorderRadius.circular(10),
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 30,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10)),
                      ),
                      child: const Center(
                        child: Text(
                          "-37% TODAY",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text(
                      "₹ 22104",
                      style: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text(
                      "₹ ${widget.city.ratesFrom}",
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
