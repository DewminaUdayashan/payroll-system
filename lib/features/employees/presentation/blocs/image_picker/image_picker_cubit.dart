import 'dart:io';
import 'dart:typed_data';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit() : super(const ImagePickerState(null));

  void onDragDone(DropDoneDetails details) async {
    if (details.files.isNotEmpty) {
      emit(ImagePickerState(File(details.files.first.path)));
    }
  }

  void setImage(Uint8List data) {
    emit(ImagePickerState(File.fromRawPath(data)));
  }

  void pickImage() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      emit(ImagePickerState(File(result.files.first.path!)));
    }
  }
}
