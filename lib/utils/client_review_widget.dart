import 'dart:async';

import 'package:ai_document_app/utils/static_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';
import 'network_image_widget.dart';

class ClientReviewWidget extends StatelessWidget {
  ClientReviewWidget({super.key});
  final AutoScrollController _controller = Get.put(AutoScrollController());

  final List<Map<String, dynamic>> clientReviews = [
    {
      'image':
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWxlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'Jane Doe',
      'review':
          'Laborum quasidistinctiott Sequi omnis molestus. Officia accusantium voluptatem accusantium. Et comuptsape quam.'
    },
    {
      'image':
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=1064&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWxlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'John Smith',
      'review':
          'Laborum quasidistinctiott Sequi omnis molestus. Officia accusantium voluptatem accusantium. Et comuptsape quam.'
    },
    {
      'image':
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDJ8fHxlbnwwfHx8fHw%3D',
      'name': 'Emily Brown',
      'review':
          'Laborum quasidistinctiott Sequi omnis molestus. Officia accusantium voluptatem accusantium. Et comuptsape quam.'
    },
    {
      'image':
          'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDV8fHxlbnwwfHx8fHw%3D',
      'name': 'Emily Brown',
      'review':
          'Laborum quasidistinctiott Sequi omnis molestus. Officia accusantium voluptatem accusantium. Et comuptsape quam.'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 128, // Set the height for the review tiles
          child: ListView.builder(
            controller: _controller.scrollController1,
            scrollDirection: Axis.horizontal,
            itemCount:
                clientReviews.length * 1000, // Repeat the list many times
            itemBuilder: (context, index) {
              return ReviewTile(clientReviews[
                  index % clientReviews.length]); // Loop over the reviews
            },
          ),
        ),
        height20,
        SizedBox(
          height: 128, // Set the height for the review tiles
          child: ListView.builder(
            controller: _controller.scrollController2,
            scrollDirection: Axis.horizontal,
            itemCount:
                clientReviews.length * 1000, // Repeat the list many times
            itemBuilder: (context, index) {
              return ReviewTile(clientReviews[
                  index % clientReviews.length]); // Loop over the reviews
            },
          ),
        ),
      ],
    );
  }

  Widget ReviewTile(review) {
    return Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Container(
          width: 303,
          decoration: BoxDecoration(
              color: primaryWhite, borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    height10,
                    NetworkImageWidget(
                        imageUrl: review['image'],
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        borderRadius: BorderRadius.circular(50)),
                    height10,
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
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              review['review'],
                              style: GoogleFonts.manrope(
                                  fontSize: 8, color: greyColor),
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          review['name'],
                          style: GoogleFonts.manrope(
                              fontSize: 8,
                              color: primaryBlack,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class AutoScrollController extends GetxController {
  final ScrollController scrollController1 = ScrollController();
  final ScrollController scrollController2 = ScrollController();
  Timer? _scrollTimer;

  final double scrollSpeed1 = 0.55; // Speed of scroll for controller1
  final double scrollSpeed2 = 0.5; // Speed of scroll for controller2

  @override
  void onInit() {
    super.onInit();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    // Start a periodic timer to auto-scroll both controllers
    _scrollTimer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      _scrollListView(scrollController1, scrollSpeed1);
      _scrollListView(scrollController2, scrollSpeed2);
    });
  }

  void _scrollListView(ScrollController controller, double scrollSpeed) {
    if (controller.hasClients) {
      double maxScrollExtent = controller.position.maxScrollExtent;
      double currentScrollPosition = controller.position.pixels;

      // When reaching the end, reset the scroll to the beginning to simulate infinite scrolling
      if (currentScrollPosition >= maxScrollExtent) {
        controller.jumpTo(controller.position.minScrollExtent);
      } else {
        controller.jumpTo(currentScrollPosition + scrollSpeed);
      }
    }
  }

  @override
  void onClose() {
    _scrollTimer?.cancel(); // Cancel the timer when the controller is disposed
    scrollController1.dispose();
    scrollController2.dispose();
    super.onClose();
  }
}
