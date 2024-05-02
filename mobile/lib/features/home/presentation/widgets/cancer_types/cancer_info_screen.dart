import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/utils/assets_path.dart';
import '../../../../../core/widgets/custom_dailog.dart';
import '../cancer_type_widget.dart';

class CancerInfoScreen extends StatefulWidget {
  const CancerInfoScreen({super.key});

  @override
  State<CancerInfoScreen> createState() => _CancerInfoScreenState();
}

class _CancerInfoScreenState extends State<CancerInfoScreen> {
  late VideoPlayerController _controller;
  Future<void> showMyDialog({required BuildContext context,required VideoPlayerController controller }) async {
    return showDialog<void>(
      context: context,

      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          clipBehavior: Clip.antiAlias,
            backgroundColor: Colors.transparent,
            shadowColor:Colors.transparent ,
            content: InkWell(
              onTap: (){
                setState(() {
                  controller.value.isPlaying
                      ? controller.pause()
                      : controller.play();
                });
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.transparent),
                ),
                child: Center(
                  child: controller.value.isInitialized
                      ? AspectRatio(aspectRatio: controller.value.aspectRatio,child: VideoPlayer(controller))
                      : Container(
                  ),
                ),
              ),
            )
        );
      },
    );
  }
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://firebasestorage.googleapis.com/v0/b/skinyapp.appspot.com/o/video_2024-02-17_20-32-27.mp4?alt=media&token=486fcbe9-f00b-4703-b41d-1aee4875659d'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }
  @override
  Widget build(BuildContext context) {
    return  CancerTypesWidgets(
      cancerType: "What is Skin Caner?",
      imagePath:  AssetsManager.gifCell,
      info:
          "Skin cancer is the out-of-control growth of abnormal cells in the epidermis, the outermost skin layer, caused by unrepaired DNA damage that triggers mutations. These mutations lead the skin cells to multiply rapidly and form malignant tumors. The main types of skin cancer are basal cell carcinoma (BCC), squamous cell carcinoma (SCC), melanoma and Merkel cell carcinoma (MCC).",
      isnetwork: false, onTap: () {
      _controller.value.isPlaying
          ? _controller.pause()
          : _controller.play();
      showMyDialog(context: context,controller: _controller) ;
      // DailogAlertFun2.showMyDialog(
      //     context: context, controller: _controller,
      // );
    },
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
}
