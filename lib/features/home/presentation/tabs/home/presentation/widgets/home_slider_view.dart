import 'package:carousel_slider/carousel_slider.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';

class HomeSliderView extends StatelessWidget {
  HomeSliderView({super.key});

  final images = [
    AssetsManager.slider1,
    AssetsManager.slider2,
    AssetsManager.slider3,
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.easeInCirc,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: images.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey,
                image: DecorationImage(
                  image: AssetImage(url),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
