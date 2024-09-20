import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../service/dummy_data.dart';
import 'color.dart';
import 'network_image_widget.dart';

class ClientReviewWidget extends StatefulWidget {
  ClientReviewWidget({super.key});

  @override
  _ClientReviewWidgetState createState() => _ClientReviewWidgetState();
}

class _ClientReviewWidgetState extends State<ClientReviewWidget> {
  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  Timer? _scrollTimer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _scrollTimer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      _scrollListView(_scrollController1, 0.55);
      _scrollListView(_scrollController2, 0.5);
    });
  }

  void _scrollListView(ScrollController controller, double scrollSpeed) {
    if (controller.hasClients) {
      double maxScrollExtent = controller.position.maxScrollExtent;
      double currentScrollPosition = controller.position.pixels;

      if (currentScrollPosition >= maxScrollExtent) {
        controller.jumpTo(controller.position.minScrollExtent);
      } else {
        controller.jumpTo(currentScrollPosition + scrollSpeed);
      }
    }
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _scrollController1.dispose();
    _scrollController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildReviewListView(_scrollController1),
        SizedBox(height: 20),
        _buildReviewListView(_scrollController2),
      ],
    );
  }

  Widget _buildReviewListView(ScrollController controller) {
    return SizedBox(
      height: 128,
      child: ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount: clientReviews.length * 1000,
        itemBuilder: (context, index) {
          return ReviewTile(
              context, clientReviews[index % clientReviews.length]);
        },
      ),
    );
  }
}

_responsiveHeight(BuildContext context, double defaultHeight) {
  return ResponsiveValue(
    context,
    defaultValue: defaultHeight,
    conditionalValues: [
      Condition.smallerThan(name: MOBILE, value: defaultHeight * 0.8),
      Condition.smallerThan(name: TABLET, value: defaultHeight),
      Condition.largerThan(name: DESKTOP, value: defaultHeight * 1.2),
    ],
  ).value!;
}

double _responsiveWidth(BuildContext context, double defaultWidth) {
  return ResponsiveValue<double>(
    context,
    defaultValue: defaultWidth,
    conditionalValues: [
      Condition.smallerThan(name: MOBILE, value: defaultWidth * 0.8),
      Condition.smallerThan(name: TABLET, value: defaultWidth),
      Condition.largerThan(name: DESKTOP, value: defaultWidth * 1.2),
    ],
  ).value!;
}

double _responsiveFontSize(BuildContext context, double defaultSize) {
  return ResponsiveValue<double>(
    context,
    defaultValue: defaultSize,
    conditionalValues: [
      Condition.smallerThan(name: MOBILE, value: defaultSize * 0.8),
      Condition.largerThan(name: DESKTOP, value: defaultSize * 1.2),
    ],
  ).value!;
}

Widget ReviewTile(context, review) {
  return Padding(
    padding: const EdgeInsets.only(left: 15),
    child: Container(
      width: _responsiveWidth(context, 303), // Adjust width responsively
      decoration: BoxDecoration(
        color: primaryWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                SizedBox(
                    height:
                        _responsiveHeight(context, 10)), // Responsive spacer
                NetworkImageWidget(
                  imageUrl: review['image'],
                  width: _responsiveWidth(context, 60), // Responsive image size
                  height: _responsiveHeight(context, 60),
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(50),
                ),
                SizedBox(
                    height:
                        _responsiveHeight(context, 10)), // Responsive spacer
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(5, (index) {
                    return const Icon(
                      Icons.star,
                      color: blueColor,
                      size: 10,
                    );
                  }),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Our happy customer",
                      style: GoogleFonts.manrope(
                        fontSize: _responsiveFontSize(context, 16),
                        color: primaryBlack,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          review['review'],
                          style: GoogleFonts.manrope(
                            fontSize: _responsiveFontSize(context, 10),
                            color: greyColor,
                          ),
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      review['name'],
                      style: GoogleFonts.manrope(
                        fontSize: _responsiveFontSize(context, 10),
                        color: primaryBlack,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
