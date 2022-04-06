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
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
                          return ListView.builder(
                            itemCount: snapshot.data["data"].length,
                            itemBuilder: (BuildContext context, int index) {
                              return examCards(snapshot.data["data"][index]);
                            },
                          );
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

  Widget examCards(data) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: myWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                offset: const Offset(1, 1),
                spreadRadius: 2,
                blurRadius: 2,
                color: primaryBlue.withOpacity(0.3))
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: myBlack.withOpacity(0.2),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "assets/paper.png",
              width: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    data["title"].toString(),
                    maxLines: 2,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
                DownloadButton(
                  fileName: data["title"].toString(),
                  id: data["id"],
                  school: widget.school,
                  studentId: widget.id,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DownloadButton extends StatefulWidget {
  final String fileName;
  final String school;
  final String studentId;
  final int id;
  const DownloadButton(
      {Key? key,
      required this.fileName,
      required this.id,
      required this.school,
      required this.studentId})
      : super(key: key);

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          setState(() {
            isloading = true;
          });
          var res = await ApiData().getStudentExamDetails(
              "examsByID", widget.school, widget.id, widget.studentId);
          if (res == false) {
            Fluttertoast.showToast(
                msg: "Check your internet or try again later");
          } else {
            await openFile(url: res["report"], fileName: widget.fileName);
          }
          setState(() {
            isloading = false;
          });
        },
        child: !isloading
            ? const Icon(Icons.open_in_new)
            : Column(
                children: const [
                  CircularProgressIndicator.adaptive(
                    backgroundColor: primaryBlue,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Opening...")
                ],
              ));

    // FloatingActionButton(

    //   backgroundColor: primaryBlue,
    //   onPressed: () => openFile(
    //       url: widget.snapshot.data["report"], fileName: widget.fileName),
    //   child: isloading == true
    //       ? const CircularProgressIndicator(
    //           color: myWhite,
    //         )
    //       : const Icon(
    //           Icons.download,
    //           color: myWhite,
    //         ),
    // );
  }

  Future openFile({required String url, String? fileName}) async {
    PermissionStatus storageStatus = await Permission.storage.status;

    if (storageStatus.isDenied) {
      await Permission.manageExternalStorage.request();
      await Permission.storage.request().then((value) {
        if (value.isDenied) {
          Fluttertoast.showToast(msg: "Please enable storage permission");
        }
      });
    } else if (storageStatus.isPermanentlyDenied) {
      Fluttertoast.showToast(
          msg: "Please enable storage permission from settings");
    } else {
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
        OpenFile.open(file.path);
      }
    }
  }

  Future<File?> downloadFile(String url, String? fileName) async {
    try {
      if (await Permission.storage.isGranted) {
        late final String appStorage;
        if (Platform.isIOS) {
          final path = await getApplicationDocumentsDirectory();
          appStorage = path.path;
        } else {
          final path = await getApplicationDocumentsDirectory();
          appStorage = path.path;
        }

        final file = File("$appStorage/$fileName.pdf");
        final response = await Dio().get(url,
            options: Options(
                responseType: ResponseType.bytes,
                followRedirects: false,
                receiveTimeout: 0));
        final raf = file.openSync(mode: FileMode.write);
        raf.writeFromSync(response.data);
        await raf.close();
        return file;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
