import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtech_school_app/api/api.dart';
import 'package:mtech_school_app/utils/config.dart';
import 'package:mtech_school_app/widgets/clip_paths.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';
import 'package:mtech_school_app/widgets/essential_functions.dart';
import 'package:mtech_school_app/widgets/loaders.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ExamsPage extends StatefulWidget {
  final String school;
  final String id;

  const ExamsPage({Key? key, required this.school, required this.id})
      : super(key: key);

  @override
  State<ExamsPage> createState() => _ExamsPageState();
}

class _ExamsPageState extends State<ExamsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myGrey,
      appBar: bar("Exams"),
      body: Stack(
        children: [
          ClipPath(
            clipper: MyClipper(false),
            child: Container(
              color: primaryBlue,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: dynamicWidth(context, 0.02),
                vertical: dynamicHeight(context, 0.02)),
            child: Column(
              children: [
                SizedBox(
                  height: dynamicHeight(context, 0.02),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: ApiData()
                        .getStudentDetails("exams", widget.school, widget.id),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data == false || snapshot.data == null) {
                          return Center(
                            child: Text(
                              "Server Error",
                              style: TextStyle(
                                color: myBlack,
                                fontSize: dynamicWidth(context, .06),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        } else if (snapshot.data["data"].length == 0) {
                          return const Center(
                            child: Text("No exams Yet!!"),
                          );
                        } else {
                          return upperCards(context, snapshot.data["data"],
                              widget.school, widget.id);
                        }
                      } else {
                        return customLoader(context, color: myWhite);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

upperCards(context, snapshot, school, studentId) {
  final _pageController = PageController(viewportFraction: 1, keepPage: true);
  return Center(
    child: PageView(
      controller: _pageController,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      children: List.generate(
        snapshot.length,
        (int index) {
          final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
          return Container(
            margin: EdgeInsets.only(
              right: dynamicWidth(context, .02),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                dynamicWidth(context, .024),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  snapshot[index]["title"].toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: dynamicHeight(context, 0.8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      dynamicWidth(context, 0.04),
                    ),
                    child: FutureBuilder(
                      future: ApiData().getStudentExamDetails("examsByID",
                          school, snapshot[index]["id"], studentId),
                      builder: (BuildContext context, AsyncSnapshot snapshot1) {
                        if (snapshot1.connectionState == ConnectionState.done) {
                          if (snapshot1.data == false ||
                              snapshot1.data == null) {
                            return const Text("Server Error");
                          } else {
                            return (snapshot1.data["report"] == null ||
                                    snapshot1.data == "")
                                ? const Center(
                                    child: Text("no Results Yet!!"),
                                  )
                                : ViewPDF(
                                    snapshot1: snapshot1,
                                    pdfViewerKey: _pdfViewerKey,
                                    fileName:
                                        snapshot[index]["title"].toString(),
                                  );
                          }
                        } else {
                          return customLoader(context, color: myBlack);
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    ),
  );
}

class ViewPDF extends StatelessWidget {
  final AsyncSnapshot snapshot1;
  final Key pdfViewerKey;
  final String fileName;
  const ViewPDF(
      {Key? key,
      required this.snapshot1,
      required this.pdfViewerKey,
      required this.fileName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingDownloadButton(
        snapshot1: snapshot1,
        fileName: fileName,
      ),
      body: SfPdfViewer.network(
        snapshot1.data["report"],
        key: pdfViewerKey,
      ),
    );
  }
}

class FloatingDownloadButton extends StatefulWidget {
  final AsyncSnapshot snapshot1;
  final String fileName;
  const FloatingDownloadButton(
      {Key? key, required this.snapshot1, required this.fileName})
      : super(key: key);

  @override
  State<FloatingDownloadButton> createState() => _FloatingDownloadButtonState();
}

class _FloatingDownloadButtonState extends State<FloatingDownloadButton> {
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: primaryBlue,
      onPressed: () => openFile(
          url: widget.snapshot1.data["report"], fileName: widget.fileName),
      child: isloading == true
          ? const CircularProgressIndicator(
              color: myWhite,
            )
          : const Icon(
              Icons.download,
              color: myWhite,
            ),
    );
  }

  Future openFile({required String url, String? fileName}) async {
    setState(() {
      isloading = true;
    });
    final file = await downloadFile(url, fileName);
    if (file == null) {
      setState(() {
        isloading = false;
      });
      Fluttertoast.showToast(
          msg: "File didn't download",
          backgroundColor: Colors.red,
          textColor: myWhite);
    } else {
      setState(() {
        isloading = false;
      });

      Fluttertoast.showToast(
          timeInSecForIosWeb: 5,
          msg: "✔️ Downloaded successfully\nPath : ${file.path}",
          backgroundColor: Colors.green,
          textColor: myWhite);
    }
  }

  Future<File?> downloadFile(String url, String? fileName) async {
    try {
      final file = File("/storage/emulated/0/Download/$fileName.pdf");
      final response = await Dio().get(url,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0));
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } catch (e) {
      return null;
    }
  }
}
