import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasq_tech/features/home/data/models/home_response.dart';

import '../../../../theme/app_colors.dart';
import '../../../notifications/ui/widgets.dart';

class ImagesPicker extends StatefulWidget {
  const ImagesPicker({
    Key? key,
    required this.onImagePicked,
    this.isUserImage = false,
    this.canEdit = true,
    required this.attachments,
  }) : super(key: key);

  final Function(List<XFile?>) onImagePicked;
  final bool isUserImage;
  final bool canEdit;
  final List<Attachment> attachments;

  @override
  State<ImagesPicker> createState() => _ImagesPickerState();
}

class _ImagesPickerState extends State<ImagesPicker> {
  List<XFile?> pickedImages = [];

  Future pickImages(ImageSource source) async {
    ImagePicker pickerServiceCoverImage = ImagePicker();
    // pickerServiceCoverImage.pickImage(source:  ImageSource.camera);

    List<XFile?> pickedFiles = pickedImages;
    if (source == ImageSource.camera) {
      XFile? image =
          await pickerServiceCoverImage.pickImage(source: ImageSource.camera);
      if (image != null) {
        // pickedFiles?? = [];
        pickedFiles.add(image);
      }
    } else {
      List<XFile> picked = await pickerServiceCoverImage.pickMultiImage();
      if (picked != null) pickedFiles += picked;
    }
    if (pickedFiles != null) {
      setState(() {
        pickedImages = pickedFiles;
      });
      widget.onImagePicked(pickedImages);
    }
  }

  void deleteImage(int index) {
    setState(() {
      pickedImages.removeAt(index);
    });
    widget.onImagePicked(pickedImages);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          whiteButtonTile(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
            title: "ارفاق صوره وفاتوره المشتريات ",
            context: context,
            pressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                        height: 100,
                        width: double.infinity,
                        child: Column(
                          children: [
                            TextButton(
                              child: Text(
                                "الكاميرا",
                                style: TextStyle(color: AppColors.primaryColor),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                // get image from gallery
                                pickImages(ImageSource.camera);
                              },
                            ),
                            TextButton(
                              child: Text(
                                "الاستوديو",
                                style: TextStyle(color: AppColors.primaryColor),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                // get image from gallery
                                pickImages(ImageSource.gallery);
                              },
                            ),
                          ],
                        ),
                      )
                  //  CupertinoActionSheet(
                  //   actions: [
                  //     CupertinoActionSheetAction(
                  //       child: Text('Photo Gallery'),
                  //       onPressed: () {
                  //         // close the options modal

                  //       },
                  //     ),
                  //     CupertinoActionSheetAction(
                  //       child: Text('Camera'),
                  //       onPressed: () {
                  //         // close the options modal
                  //         Navigator.of(context).pop();
                  //         // get image from camera
                  //         pickImages(ImageSource.camera);
                  //       },
                  //     ),
                  //   ],
                  // ),

                  );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          if (widget.attachments.isNotEmpty && pickedImages.isEmpty)
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.grayWhite, width: 1),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  Attachment attachment = widget.attachments[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 2,
                            ),
                            image: DecorationImage(
                              image: NetworkImage(attachment.url!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: widget.attachments.length,
              ),
            ),
          const SizedBox(height: 20),
          // Display picked images
          if (pickedImages.isNotEmpty)
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.grayWhite, width: 1),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 2,
                            ),
                            image: DecorationImage(
                              image: pickedImages[index] != null
                                  ? FileImage(File(pickedImages[index]!.path))
                                  : AssetImage("res/assets/logo_rec.png")
                                      as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        if (widget.canEdit)
                          Positioned(
                            right: -10,
                            top: -10,
                            child: IconButton(
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                deleteImage(index);
                              },
                            ),
                          ),
                      ],
                    ),
                  );
                },
                itemCount: pickedImages.length,
              ),
            ),
        ],
      ),
    );
  }
}
