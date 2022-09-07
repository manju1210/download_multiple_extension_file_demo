import 'dart:io';

import 'package:dio/dio.dart';
import 'package:downloaddemo/screens/download_screen.dart';
import 'package:downloaddemo/screens/widget.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadFileWidget extends StatefulWidget {
  String? title, file;
  DownloadFileWidget({Key? key,this.title,this.file}) : super(key: key);

  @override
  State<DownloadFileWidget> createState() => _DownloadFileWidgetState();
}

class _DownloadFileWidgetState extends State<DownloadFileWidget> {

  ///download file
  bool downloading = false;
  var progress = "";
  double downloadProgress = 0.0;
  var path = "No Data";
  var platformVersion = "Unknown";
  var _onPressed;
  Directory? externalDir;


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return downloading ? Padding(
      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                progress == "100%" ? const Icon(Icons.check_circle_outline_outlined,color: Colors.green,size: 40,) :
                const CircularProgressIndicator(),

                const SizedBox(height: 10.0,),
                Text(
                  'Downloading File: $progress',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    ) :
    GestureDetector(
      onTap: (){
        setState(() {
          if (widget.file == null || widget.file == "") {
            showToast("There is no file available");
          } else {
            var parts = widget.file!.split('.');
            var prefix = parts[0].trim();
            var fileFormat = parts.sublist(2).join(':').trim();
            print(prefix);print(fileFormat);

            downloading = true;
            downloadFile(widget.file!,fileFormat);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Title : ',
                    style: const TextStyle(fontWeight: FontWeight.w500,color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: widget.title!, style: const TextStyle(fontWeight: FontWeight.w400,color: Colors.black),),
                    ],
                  ),
                ),
                const SizedBox(height: 5,),
                RichText(
                  text: TextSpan(
                    text: 'Url : ',
                    style: const TextStyle(fontWeight: FontWeight.w500,color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: widget.file!, style: const TextStyle(fontWeight: FontWeight.w400,color: Colors.blue),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  String convertCurrentDateTimeToString() {
    String formattedDateTime =
    DateFormat('yyyyMMdd_kkmmss').format(DateTime.now()).toString();
    return formattedDateTime;
  }

  Future<void> downloadFile(String file,String fileFormat) async {
    Dio dio = Dio();
    final status = await Permission.storage.request();
    if (status.isGranted) {
      String dirLoc = "";
      if (Platform.isAndroid) {
        dirLoc = "/sdcard/download/";
      } else {
        dirLoc = (await getApplicationDocumentsDirectory()).path;
      }

      try {
        FileUtils.mkdir([dirLoc]);
        await dio.download(
          file,
          fileFormat == "pdf" ? "${dirLoc}AllMetalika_${convertCurrentDateTimeToString()}.pdf" :
          fileFormat == "jpg" ? "${dirLoc}AllMetalika_${convertCurrentDateTimeToString()}.jpg" :
          fileFormat == "jpeg" ? "${dirLoc}AllMetalika_${convertCurrentDateTimeToString()}.jpeg" :
          "${dirLoc}AllMetalika_${convertCurrentDateTimeToString()}.png",

          onReceiveProgress: (receivedBytes, totalBytes) {
            setState(() {
              print('here 1');
              downloading = true;
              progress = "${((receivedBytes / totalBytes) * 100).toStringAsFixed(0)}%";
              print(progress);
              print('here 2');
            });
          },
        );

        if(progress == "100%") {
          Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              downloading = false;
              progress = "Download Completed.";
              path = fileFormat == "pdf" ? "${dirLoc}AllMetalika_${convertCurrentDateTimeToString()}.pdf" :
              fileFormat == "jpg" ? "${dirLoc}AllMetalika_${convertCurrentDateTimeToString()}.jpg" :
              fileFormat == "jpeg" ? "${dirLoc}AllMetalika_${convertCurrentDateTimeToString()}.jpeg" :
              "${dirLoc}AllMetalika_${convertCurrentDateTimeToString()}.png";

              openFileDownloadDialog(context,widget.title!,file,fileFormat);

              print(path);
              print('here give alert-->completed');
            });
          });
        }

      } catch (e) {
        showToast("Please try again later.");
        print('catch catch catch');
        setState(() {
          downloading = false;
        });
        print(e);
      }
    } else {
      setState(() {
        downloading = false;
      });
      progress = "Permission Denied!";
      _onPressed = () {
        downloadFile(file,fileFormat);
      };
    }
  }

  ///popup for file details
  openFileDownloadDialog(BuildContext dialogContext,String title,String file,String fileFormat) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      overlayColor: Colors.black.withOpacity(0.4),
      isCloseButton: false,
      isOverlayTapDismiss: true,
      alertPadding: const EdgeInsets.all(20),
      titleTextAlign: TextAlign.center,
      descTextAlign: TextAlign.center,
      // titleStyle: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600,),),
      // descStyle: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400,)),
      animationDuration: const Duration(milliseconds: 400),
    );
    Alert(
      context: dialogContext,
      style: alertStyle,
      title: "Successfully Downloaded",
      desc: "Invoice successfully downloaded, Please check your downloads.",
      buttons: [
        DialogButton(
          height: 40,
          color: Colors.white60,
          border: Border.all(color: Colors.black, width: 1.2),
          radius: BorderRadius.circular(5.0),
          splashColor: Colors.black,//Colors.primaryColor,
          child: Text("Cancel"),
          // child: buildTextPoppinsRegularWidgetWithoutSizer("Cancel", AppColors.primaryColor,context,13,),
          onPressed: () {
            setState(() {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => DownloadScreen()), (route) => false);
            });
          },
        ),
        DialogButton(
          height: 40,
          color: Colors.white60,
          border: Border.all(color: Colors.red, width: 1.2),
          radius: BorderRadius.circular(5.0),
          splashColor: Colors.red,
          child: Text("Open"),
          // child: buildTextPoppinsRegularWidgetWithoutSizer("Subscribe Now",AppColors.textRedServiceColor,context, 13,align: TextAlign.center),
          onPressed: () {
            setState(() {

              launchURL(file);
              Navigator.of(context).pop();

              // fileFormat == "pdf" ? launchURL(file) :
              // fileFormat == "jpg" || fileFormat == "jpeg"  || fileFormat == "png" ?
              // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => WebViewScreen(url: file, title: title,)), (route) => false) :
              // null;

              // Navigator.pushReplacement(context, SlideUpNavigation(widget: PackageSubscriptionScreen()));
            });
          },
        ),
      ],
    ).show();
  }

  Future<void> launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

}
