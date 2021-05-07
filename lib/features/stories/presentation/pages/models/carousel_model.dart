// @dart=2.9
class CarouselModel {
  String image;

  CarouselModel(this.image);
}

List<CarouselModel> carousels =
    carouselsData.map((item) => CarouselModel(item['image'])).toList();

var carouselsData = [
  {"image": "assets/image/1.PNG"},
  {"image": "assets/image/2.PNG"},
  {"image": "assets/image/3.PNG"},
];
