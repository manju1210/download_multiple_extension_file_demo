import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'download_screen.dart';

class WebViewScreen extends StatefulWidget {
  String? url;
  String? title;
  String? screenName;

  WebViewScreen({this.url, this.title,this.screenName});
  @override
  _WebViewScreenState createState() => _WebViewScreenState(url!, title == null ? url! : title!);
}

class _WebViewScreenState extends State<WebViewScreen> {
  double progress = 0;
  double loadingContainerHeight = 5;
  String url;
  String title;
  _WebViewScreenState(this.url, this.title);
  bool isLoading = true;
  final _key = UniqueKey();

  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() async{
        return await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DownloadScreen(),
        ),);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.red,elevation: 1.0,
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),//SvgPicture.asset("assets/chevron-left.svg"),
              onPressed: (){
                Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) =>
                    DownloadScreen()));
              }
          ),
          title: Text(title),
        ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * progress,
                  height: loadingContainerHeight,
                  color: Colors.redAccent,
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * (2 / 3),
                    child: WebView(
                      key: _key,
                      initialUrl: url,
                      javascriptMode: JavascriptMode.unrestricted,

                      onPageFinished: (finish){
                        setState(() {
                          isLoading=false;
                        });
                      },
                      onProgress: (int progress) {
                        setState(() {
                          this.progress = progress/100;
                          if(progress == 100){
                            loadingContainerHeight = 0;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            isLoading ? const Center(child: CircularProgressIndicator(),):Stack(),
          ],
        ),
      ),
    );
  }
}