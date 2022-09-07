import 'package:downloaddemo/screens/download_file_widget.dart';
import 'package:downloaddemo/screens/widget.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import 'download_model.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({Key? key}) : super(key: key);

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {

  List<DownloadModel> downloadList = [];
  bool isDownloading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for(int i =0 ; i<3 ;i++){
      if(i==0) {
        downloadList.add(DownloadModel(
          title: "Pdf Url",
          downloadUrl: "https://allmetalika.com/admin/AML2022Sep753433.pdf",
        ));
      }
      if(i==1) {
        downloadList.add(DownloadModel(
          title: "Image Url",
          downloadUrl: "https://allmetalika.com/admin/uploads/first_invoice/image_picker2446135725918164326.jpg",
        ));
      }
      if(i==2) {
        downloadList.add(DownloadModel(
          title: "PNG Url",
          downloadUrl: "https://cdn.maikoapp.com/3d4b/4qhf5/180h.png",
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Download Demo",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
        ),
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: downloadList.length,
              itemBuilder: (BuildContext context, int index) {
                final itemDownload = downloadList[index];
                return DownloadFileWidget(title: itemDownload.title!,file: itemDownload.downloadUrl!);
              },
            ),
          ),
        ),
      ),
    );
  }

}
