import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netwin_test/bloc/selection_bloc/selection_bloc.dart';
import 'package:netwin_test/bloc/selection_bloc/selection_bloc_events.dart';
import 'package:netwin_test/bloc/selection_bloc/selection_bloc_states.dart';
import 'package:netwin_test/globals/widgets/loader.dart';
import 'package:netwin_test/models/city_model.dart';
import 'package:netwin_test/views/drop_down_btn.dart';
import 'package:netwin_test/views/listitems/hotel_listitem.dart';

class HotelListScreen extends StatefulWidget {
  const HotelListScreen({super.key});

  @override
  State<HotelListScreen> createState() => _HotelListScreenState();
}

class _HotelListScreenState extends State<HotelListScreen> {
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
  List<HotelData> hotels = [];

  Future<List<HotelData>>? readCityData;

  Future<List<HotelData>> getHotels() async {
    final String response =
        await rootBundle.loadString('assets/json/city.json');
    List data = await json.decode(response);
    hotels = data.map((e) => HotelData.fromJson(e)).toList();
    return hotels;
  }

  @override
  void initState() {
    readCityData = getHotels();
    selectFilterBloc.add(SelectStringEvent(filters.first));
    selectPriceBloc.add(SelectStringEvent(priceFilter.first));
    selectSortBloc.add(SelectStringEvent(sortFilter.first));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(title: "Hotel List"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // shrinkWrap: true,
            // padding: const EdgeInsets.all(10),
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
                    future: readCityData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: hotels.length,
                          itemBuilder: (context, index) =>
                              HotelListItem(city: hotels[index]),
                        );
                      }
                      return const Loader();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
