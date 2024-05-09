import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'dart:developer' as dev;

class FeedUploadController extends ChangeNotifier {
  XFile? video;
  final ImagePicker picker = ImagePicker();
  VideoPlayerController? videoController;

  Future getVideo(ImageSource imageSource, BuildContext context) async {
    final XFile? pickedFile = await picker.pickVideo(source: imageSource);
    if (pickedFile != null) {
      videoController = VideoPlayerController.file(File(pickedFile.path))
        ..initialize().then((_) {
          final Duration duration = videoController!.value.duration;
          // 영상 길이가 1분을 초과하는지 확인
          if (duration.inSeconds > 60.1) {
            dev.log('경고 너무 김');
            showMessage(context, '영상은 1분을\n초과할 수 없습니다.');
          } else {
            video = XFile(pickedFile.path);
            dev.log('영상 선택 성공');
            videoController?.setLooping(true);
            context.push('/videoUpload');
          }
        });
    } else {
      dev.log('영상 선택 실패');
      showMessage(context, '영상 업로드가 취소되었습니다.');
    }

    notifyListeners();
  }

  void setVideo() async {
    if (videoController == null) {
      dev.log('wowowowowoowowowowow');
    }
    videoController!.play();
  }

  void disposeController() {
    dev.log('asdsaasasasasasas');
    videoController?.pause();
    videoController?.dispose();
  }
}

Future showMessage(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          child: const Text('확인'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}
