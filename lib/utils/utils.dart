import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// for picking up image from gallery
pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No Image Selected');
}

// for displaying snackbars
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

class AvailableFonts {
  static const primaryFont = "Quicksand";
}

class AvailableImages {
  static const postBanner = {
    'assetImage': AssetImage('assets/images/post_banner.jpg'),
    'assetPath': 'assets/images/post_banner.jpg',
  };

  static const emptyState = {
    'assetImage': AssetImage('assets/images/empty.png'),
    'assetPath': 'assets/images/empty.png',
  };

  static const homePage = const AssetImage('assets/images/home_page.png');
  static const appLogo = const AssetImage('assets/images/logo.png');
  static const loading = const AssetImage('assets/images/loading.gif');
  static const user = const AssetImage('assets/images/user.jpg');
}
