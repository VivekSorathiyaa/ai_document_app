import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

class PinchPage extends StatelessWidget {
  PinchPage({Key? key}) : super(key: key);

  var pdfController = Get.put(PdfController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Pdfx example'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.navigate_before),
            onPressed: () {
              Get.find<PinchController>().previousPage();
            },
          ),
          GetX<PinchController>(
            builder: (controller) {
              return Container(
                alignment: Alignment.center,
                child: Text(
                  '${controller.currentPage}/${controller.totalPages}',
                  style: const TextStyle(fontSize: 22),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            onPressed: () {
              Get.find<PinchController>().nextPage();
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Get.find<PinchController>().refreshDocument();
            },
          )
        ],
      ),
      body: GetBuilder<PinchController>(
        builder: (controller) {
          return PdfViewPinch(
            builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
              options: const DefaultBuilderOptions(),
              documentLoaderBuilder: (_) =>
                  const Center(child: CircularProgressIndicator()),
              pageLoaderBuilder: (_) =>
                  const Center(child: CircularProgressIndicator()),
              errorBuilder: (_, error) => Center(child: Text(error.toString())),
            ),
            controller: controller.pdfControllerPinch,
          );
        },
      ),
    );
  }
}

class PdfController extends GetxController {
  static const int _initialPage = 1;
  var currentPage = 1.obs;
  var totalPages = 0.obs;
  DocShown _showing = DocShown.sample;
  late PdfControllerPinch pdfControllerPinch;

  @override
  void onInit() {
    pdfControllerPinch = PdfControllerPinch(
      document: PdfDocument.openData(
        InternetFile.get(
          "https://cdn.filestackcontent.com/wcrjf9qPTCKXV3hMXDwK",
        ),
      ),
      initialPage: _initialPage,
    );
    pdfControllerPinch.addListener(_onPageChanged);
    super.onInit();
  }

  @override
  void onClose() {
    pdfControllerPinch.removeListener(_onPageChanged);
    pdfControllerPinch.dispose();
    super.onClose();
  }

  void _onPageChanged() {
    currentPage.value = pdfControllerPinch.page ?? 1;
    totalPages.value = pdfControllerPinch.pagesCount ?? 0;
  }

  void previousPage() {
    pdfControllerPinch.previousPage(
      curve: Curves.ease,
      duration: const Duration(milliseconds: 100),
    );
  }

  void nextPage() {
    pdfControllerPinch.nextPage(
      curve: Curves.ease,
      duration: const Duration(milliseconds: 100),
    );
  }

  void refreshDocument() {
    switch (_showing) {
      case DocShown.sample:
      case DocShown.tutorial:
        pdfControllerPinch
            .loadDocument(PdfDocument.openAsset('assets/flutter_tutorial.pdf'));
        _showing = DocShown.hello;
        break;
      case DocShown.hello:
        pdfControllerPinch
            .loadDocument(PdfDocument.openAsset('assets/hello.pdf'));
        _showing = GetPlatform.isWeb ? DocShown.password : DocShown.tutorial;
        break;

      case DocShown.password:
        pdfControllerPinch.loadDocument(PdfDocument.openAsset(
          'assets/password.pdf',
          password: 'MyPassword',
        ));
        _showing = DocShown.tutorial;
        break;
    }
  }
}

enum DocShown { sample, tutorial, hello, password }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Pdfx GetX Example',
      initialBinding: BindingsBuilder(() {
        Get.put(PinchController());
      }),
      home: const PinchPage(),
    );
  }
}
