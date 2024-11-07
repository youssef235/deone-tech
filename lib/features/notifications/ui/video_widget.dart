import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wasq_tech/theme/app_colors.dart';


class VideoDialog extends StatefulWidget {

  VideoPlayerController controller;
  String title;
  VideoDialog({required this.controller , required this.title});

  @override
  State<VideoDialog> createState() => _VideoDialogState();
}

class _VideoDialogState extends State<VideoDialog> {
  TextStyle textStyle = TextStyle (color: Colors.black);


@override
  void initState() {
    // TODO: implement initState
    widget.controller.addListener(()=>setState(() {
      print("changed");
    }));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child:  AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
      title: Text(widget.title,style: TextStyle(fontSize: 14,color: AppColors.primaryColor,fontWeight:FontWeight.bold),),
      content: !widget.controller.value.isInitialized ?Container( 
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                               mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("جاري فتح الفيديو",style: TextStyle(color: AppColors.primaryColor,fontWeight:FontWeight.bold),),
                                SizedBox(height: 15,),
                                CircularProgressIndicator()
                                ] ),
                              
                            ):
                             Container(
                               child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                 mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 15,),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        widget.controller.value.isPlaying
                                            ? widget.controller.pause()
                                            : widget.controller.play();
                                      });
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(2),
                                          child: AspectRatio(
                                            aspectRatio: widget.controller.value.aspectRatio,
                                            child: VideoPlayer(widget.controller),
                                          ),
                                        ),
                                        Visibility(
                                          visible: !widget.controller.value.isPlaying,
                                          child: Icon(
                                            color: AppColors.grayWhite,
                                            Icons.play_circle,
                                            size: MediaQuery.of(context).size.width * 0.15, // Adjust the size as needed
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                                         ),
                             ),
      actions: <Widget>[
        new TextButton(
          child: Text("اغلاق" , style: TextStyle(color: AppColors.primaryColor)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
      ));
  }
}