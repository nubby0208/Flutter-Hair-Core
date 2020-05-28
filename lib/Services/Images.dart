import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:image_picker/image_picker.dart';

class ImageServices {
  static Future getImageFromCamera() async {
    return await ImagePicker.pickImage(source: ImageSource.camera);
  }

  static Future getImageFromGallery() async {
    return await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  static ImageProvider getNetworkImage(url) {
    try {
      return NetworkImage(url);
    } catch (e) {
      return AssetImage("asserts/no_profile.jpg");
    }
  }

  static CachedNetworkImage getProfileImage(url, {double radius = 50}) {
    return CachedNetworkImage(
      imageUrl: url ?? "",
      imageBuilder: (context, imageProvider) {
        return CircleAvatar(
          radius: radius,
          backgroundImage: ImageServices.getNetworkImage(
            url,
          ),
        );
      },
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) {
        return CircleAvatar(
          radius: radius,
          backgroundImage: AssetImage("assets/images/no_profile.jpg"),
        );
      },
    );
  }

  static ImageProvider getFileImage(file) {
    try {
      return FileImage(file);
    } catch (e) {
      return AssetImage("asserts/no_profile.jpg");
    }
  }

  static CachedNetworkImage getPreviewStyleImage(
    url, {
    double height = 120,
    double width = 120,
  }) {
    return CachedNetworkImage(
      imageUrl: url ?? "",
      imageBuilder: (context, imageProvider) {
        return Container(
          width: height,
          height: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
            ),
          ),
        );
      },
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) {
        return Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage("assets/images/no_profile.jpg"),
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }

  static CachedNetworkImage getServiceStyleImage(url) {
    return CachedNetworkImage(
      imageUrl: url ?? "",
      imageBuilder: (context, imageProvider) {
        return Image.network(url);
      },
      placeholder: (context, url) => Stack(
        children: <Widget>[
          Image.asset('assets/images/no_profile.jpg'),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: CircularProgressIndicator(),
          ),
        ],
      ),
      errorWidget: (context, url, error) {
        return Image.asset('assets/images/no_profile.jpg');
      },
    );
  }
}
