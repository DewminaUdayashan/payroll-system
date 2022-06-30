part of 'image_picker_cubit.dart';

class ImagePickerState extends Equatable {
  const ImagePickerState(this.file);
  final File? file;
  @override
  List<Object?> get props => [file];
}
