// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ImageController {
//   File _image;

  
//   _imgFromCamera() async
//   {
//     File image = await ImagePicker.pickImage(
//       source: ImageSource.camera, imageQuality: 50
//     );

//     _image = image;
//   }
  
//   _imgFromGallery() async {
//     File image = await  ImagePicker.pickImage(
//         source: ImageSource.gallery, imageQuality: 50
//     );
    
//     _image = image;
//   }
         
//   void showPicker(context)
//   {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Container(
//               child: new Wrap(
//                 children: <Widget>[
//                   new ListTile(
//                       leading: new Icon(Icons.photo_library),
//                       title: new Text('Photo Library'),
//                       onTap: () {
//                         _imgFromGallery();
//                         Navigator.of(context).pop();
//                       }),
//                   new ListTile(
//                     leading: new Icon(Icons.photo_camera),
//                     title: new Text('Camera'),
//                     onTap: () {
//                       _imgFromCamera();
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//     );
//   }

//   File get image
//   {
//     return _image;
//   }

//   void set image(image)
//   {
//     _image = image;
//   } 

//   File getImage() {
//         return this._image;
//     }

// }


