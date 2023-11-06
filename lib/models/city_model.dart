// To parse this JSON data, do
//
//     final cityData = cityDataFromJson(jsonString);

class HotelData {
  final int hotelId;
  final int chainId;
  final String chainName;
  final int brandId;
  final String brandName;
  final String hotelName;
  final String hotelFormerlyName;
  final String hotelTranslatedName;
  final String addressline1;
  final String addressline2;
  final String zipcode;
  final String city;
  final String state;
  final String country;
  final String countryisocode;
  final double starRating;
  final double longitude;
  final double latitude;
  final String url;
  final String checkin;
  final String checkout;
  final int? numberrooms;
  final int? numberfloors;
  final int? yearopened;
  final int? yearrenovated;
  final String photo1;
  final String photo2;
  final String photo3;
  final String photo4;
  final String photo5;
  final String overview;
  final int ratesFrom;
  final int continentId;
  final String continentName;
  final int cityId;
  final int countryId;
  final int numberOfReviews;
  final double ratingAverage;
  final String ratesCurrency;

  HotelData({
    required this.hotelId,
    required this.chainId,
    required this.chainName,
    required this.brandId,
    required this.brandName,
    required this.hotelName,
    required this.hotelFormerlyName,
    required this.hotelTranslatedName,
    required this.addressline1,
    required this.addressline2,
    required this.zipcode,
    required this.city,
    required this.state,
    required this.country,
    required this.countryisocode,
    required this.starRating,
    required this.longitude,
    required this.latitude,
    required this.url,
    required this.checkin,
    required this.checkout,
    required this.numberrooms,
    required this.numberfloors,
    required this.yearopened,
    required this.yearrenovated,
    required this.photo1,
    required this.photo2,
    required this.photo3,
    required this.photo4,
    required this.photo5,
    required this.overview,
    required this.ratesFrom,
    required this.continentId,
    required this.continentName,
    required this.cityId,
    required this.countryId,
    required this.numberOfReviews,
    required this.ratingAverage,
    required this.ratesCurrency,
  });

  factory HotelData.fromJson(Map<String, dynamic> json) => HotelData(
        hotelId: json["hotel_id"],
        chainId: json["chain_id"],
        chainName: json["chain_name"],
        brandId: json["brand_id"],
        brandName: json["brand_name"],
        hotelName: json["hotel_name"],
        hotelFormerlyName: json["hotel_formerly_name"],
        hotelTranslatedName: json["hotel_translated_name"],
        addressline1: json["addressline1"],
        addressline2: json["addressline2"],
        zipcode: json["zipcode"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        countryisocode: json["countryisocode"],
        starRating: json["star_rating"].toDouble(),
        longitude: json["longitude"].toDouble(),
        latitude: json["latitude"].toDouble(),
        url: json["url"],
        checkin: json["checkin"],
        checkout: json["checkout"],
        numberrooms: json["numberrooms"],
        numberfloors: json["numberfloors"],
        yearopened: json["yearopened"],
        yearrenovated: json["yearrenovated"],
        photo1: json["photo1"],
        photo2: json["photo2"],
        photo3: json["photo3"],
        photo4: json["photo4"],
        photo5: json["photo5"],
        overview: json["overview"],
        ratesFrom: json["rates_from"],
        continentId: json["continent_id"],
        continentName: json["continent_name"],
        cityId: json["city_id"],
        countryId: json["country_id"],
        numberOfReviews: json["number_of_reviews"],
        ratingAverage: json["rating_average"].toDouble(),
        ratesCurrency: json["rates_currency"],
      );

  Map<String, dynamic> toJson() => {
        "hotel_id": hotelId,
        "chain_id": chainId,
        "chain_name": chainName,
        "brand_id": brandId,
        "brand_name": brandName,
        "hotel_name": hotelName,
        "hotel_formerly_name": hotelFormerlyName,
        "hotel_translated_name": hotelTranslatedName,
        "addressline1": addressline1,
        "addressline2": addressline2,
        "zipcode": zipcode,
        "city": city,
        "state": state,
        "country": country,
        "countryisocode": countryisocode,
        "star_rating": starRating,
        "longitude": longitude,
        "latitude": latitude,
        "url": url,
        "checkin": checkin,
        "checkout": checkout,
        "numberrooms": numberrooms,
        "numberfloors": numberfloors,
        "yearopened": yearopened,
        "yearrenovated": yearrenovated,
        "photo1": photo1,
        "photo2": photo2,
        "photo3": photo3,
        "photo4": photo4,
        "photo5": photo5,
        "overview": overview,
        "rates_from": ratesFrom,
        "continent_id": continentId,
        "continent_name": continentName,
        "city_id": cityId,
        "country_id": countryId,
        "number_of_reviews": numberOfReviews,
        "rating_average": ratingAverage,
        "rates_currency": ratesCurrency,
      };
}
