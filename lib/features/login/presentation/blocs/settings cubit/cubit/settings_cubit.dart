import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());
  File? imagefile;
  Future pickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) return;
    final imageTemporary = File(image.path);
//final imagePermanent =await saveim(image.path);
    imagefile = imageTemporary;
    emit(ChangeimageStates());
    if (kDebugMode) {
      print(imagefile);
    }
  }
}
