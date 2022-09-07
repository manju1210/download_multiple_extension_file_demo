
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


buildCircularIndicator({double height = 150}){
  return SizedBox(
    height: height,
    child: Center(
      child: CircularProgressIndicator(strokeWidth: 1.5,color: Colors.redAccent,),
    ),
  );
}


/*------------------------------------DOWNLOAD FILE & IMAGES--------------------------------------------------------------------------*/

///download pdf file
class DownloadFile{

  ///download file
  bool downloading = false;
  var progress = "";
  var path = "No Data";
  var platformVersion = "Unknown";
  var _onPressed;
  Directory? externalDir;

  String convertCurrentDateTimeToString() {
    String formattedDateTime =
    DateFormat('yyyyMMdd_kkmmss').format(DateTime.now()).toString();
    return formattedDateTime;
  }

  Future<void> downloadFile(String file , {String flag = ""}) async {
    Dio dio = Dio();
    final status = await Permission.storage.request();
    if (status.isGranted) {
      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc = "/sdcard/download/";
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path;
      }

      try {
        FileUtils.mkdir([dirloc]);
        await dio.download(file, "${dirloc}AllMetalika_${convertCurrentDateTimeToString()}.pdf",
            onReceiveProgress: (receivedBytes, totalBytes) {
              print('here 1');
              downloading = true;
              progress = "${((receivedBytes / totalBytes) * 100).toStringAsFixed(0)}%";
              print(progress);
              print('here 2');
            });

        Future.delayed(const Duration(seconds: 4), () {
          downloading = false;
          progress = "Download Completed.";
          path = "${dirloc}AllMetalika_${convertCurrentDateTimeToString()}.pdf";
          showToast("Invoice successfully downloaded, Please check your downloads...");
        });
        print(path);
        print('here give alert-->completed');
        downloading = false;

      } catch (e) {
        showToast("Please try again later.");
        print('catch catch catch');
        downloading = false;
        print(e);
      }
    } else {
      downloading = false;
      progress = "Permission Denied!";
      _onPressed = () {
        downloadFile(file);
      };
    }
  }
}

///download jpg file
class DownloadJPGFile{

  ///download file
  bool downloading = false;
  var progress = "";
  var path = "No Data";
  var platformVersion = "Unknown";
  var _onPressed;
  Directory? externalDir;

  String convertCurrentDateTimeToString() {
    String formattedDateTime =
    DateFormat('yyyyMMdd_kkmmss').format(DateTime.now()).toString();
    return formattedDateTime;
  }

  Future<void> downloadFile(String file , {String flag = ""}) async {
    Dio dio = Dio();
    final status = await Permission.storage.request();
    if (status.isGranted) {
      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc = "/sdcard/download/";
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path;
      }

      try {
        FileUtils.mkdir([dirloc]);
        await dio.download(file, "${dirloc}AllMetalika_${convertCurrentDateTimeToString()}.jpg",
            onReceiveProgress: (receivedBytes, totalBytes) {
              print('here 1');
              downloading = true;
              progress = "${((receivedBytes / totalBytes) * 100).toStringAsFixed(0)}%";
              print(progress);
              print('here 2');
            });

        Future.delayed(const Duration(seconds: 4), () {
          downloading = false;
          progress = "Download Completed.";
          path = "${dirloc}AllMetalika_${convertCurrentDateTimeToString()}.jpg";
          showToast("Invoice successfully downloaded, Please check your downloads...");
        });
        print(path);
        print('here give alert-->completed');
        downloading = false;

      } catch (e) {
        showToast("Please try again later.");
        // showToast(e.toString());
        print('catch catch catch');
        downloading = false;
        print(e);
      }
    } else {
      downloading = false;
      progress = "Permission Denied!";
      _onPressed = () {
        downloadFile(file);
      };
    }
  }
}

///download jpeg file
class DownloadJPEGFile{

  ///download file
  bool downloading = false;
  var progress = "";
  var path = "No Data";
  var platformVersion = "Unknown";
  var _onPressed;
  Directory? externalDir;

  String convertCurrentDateTimeToString() {
    String formattedDateTime =
    DateFormat('yyyyMMdd_kkmmss').format(DateTime.now()).toString();
    return formattedDateTime;
  }

  Future<void> downloadFile(String file , {String flag = ""}) async {
    Dio dio = Dio();
    final status = await Permission.storage.request();
    if (status.isGranted) {
      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc = "/sdcard/download/";
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path;
      }

      try {
        FileUtils.mkdir([dirloc]);
        await dio.download(file, "${dirloc}AllMetalika_${convertCurrentDateTimeToString()}.jpeg",
            onReceiveProgress: (receivedBytes, totalBytes) {
              print('here 1');
              downloading = true;
              progress = "${((receivedBytes / totalBytes) * 100).toStringAsFixed(0)}%";
              print(progress);
              print('here 2');
            });

        Future.delayed(const Duration(seconds: 4), () {
          downloading = false;
          progress = "Download Completed.";
          path = "${dirloc}AllMetalika_${convertCurrentDateTimeToString()}.jpeg";
          showToast("Invoice successfully downloaded, Please check your downloads...");
        });
        print(path);
        print('here give alert-->completed');
        downloading = false;

      } catch (e) {
        showToast("Please try again later.");
        // showToast(e.toString());
        print('catch catch catch');
        downloading = false;
        print(e);
      }
    } else {
      downloading = false;
      progress = "Permission Denied!";
      _onPressed = () {
        downloadFile(file);
      };
    }
  }
}

///download png file
class DownloadPNGFile{

  ///download file
  bool downloading = false;
  var progress = "";
  var path = "No Data";
  var platformVersion = "Unknown";
  var _onPressed;
  Directory? externalDir;

  String convertCurrentDateTimeToString() {
    String formattedDateTime =
    DateFormat('yyyyMMdd_kkmmss').format(DateTime.now()).toString();
    return formattedDateTime;
  }

  Future<void> downloadFile(String file , {String flag = ""}) async {
    Dio dio = Dio();
    final status = await Permission.storage.request();
    if (status.isGranted) {
      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc = "/sdcard/download/";
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path;
      }

      try {
        FileUtils.mkdir([dirloc]);
        await dio.download(file, "${dirloc}AllMetalika_${convertCurrentDateTimeToString()}.png",
            onReceiveProgress: (receivedBytes, totalBytes) {
              print('here 1');
              downloading = true;
              progress = "${((receivedBytes / totalBytes) * 100).toStringAsFixed(0)}%";
              print(progress);
              print('here 2');
            });

        Future.delayed(const Duration(seconds: 4), () {
          downloading = false;
          progress = "Download Completed.";
          path = "${dirloc}AllMetalika_${convertCurrentDateTimeToString()}.png";
          showToast("Invoice successfully downloaded, Please check your downloads...");
        });
        print(path);
        print('here give alert-->completed');
        downloading = false;


      } catch (e) {
        showToast("Please try again later.");
        // showToast(e.toString());
        print('catch catch catch');
        downloading = false;
        print(e);
      }

    } else {
      downloading = false;
      progress = "Permission Denied!";
      _onPressed = () {
        downloadFile(file);
      };
    }
  }
}