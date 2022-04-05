import 'dart:io';

import 'package:blog_app/Services/crud_method.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({Key? key}) : super(key: key);

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  // Pick a Image from ImageSources

  File? selectedImage;
  final picker = ImagePicker();

  CrudMethods crudMethods = CrudMethods();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
      } else {
        print("No Image selected");
      }
    });
  }

  // Upload Image and extra details on firebase

  Future<void> uploadBlog() async {
    if (selectedImage != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              SizedBox(
                width: 30,
              ),
              Text(
                "Uploading......",
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
        ),
      );

      Reference FirebasetoRef = FirebaseStorage.instance
          .ref()
          .child("blogImages")
          .child("${randomAlphaNumeric(9)}.jpg");

      final UploadTask task = FirebasetoRef.putFile(selectedImage!);

      var imageUrl;
      await task.whenComplete(() async {
        try {
          imageUrl = await FirebasetoRef.getDownloadURL();
        } catch (e) {
          print("Error");
        }

        print(imageUrl);
      });

      Map<String, dynamic> blogData = {
        "imgUrl": imageUrl,
        "author": authorTextEditingController.text,
        "title": titleTextEditingController.text,
        "desc": descTextEditingController.text,
        "time": DateTime.now()
      };

      crudMethods
          .addData(blogData, authorTextEditingController.text)
          .then((value) {
        Fluttertoast.showToast(msg: "Image Added");
        Navigator.pop(context);
        Navigator.pop(context);
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.error, color: Colors.red),
              SizedBox(width: 30),
              Expanded(
                child: Text("Image Required"),
              ),
            ],
          ),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Okay",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ))
          ],
        ),
      );
    }
  }

  TextEditingController authorTextEditingController = TextEditingController();
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController descTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: BackButton(color: Colors.black),
        title: const Text(
          "Add Image",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              uploadBlog();
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                Icons.file_upload,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: selectedImage != null
                    ? Container(
                        height: 210,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        margin: EdgeInsets.symmetric(vertical: 24),
                        width: MediaQuery.of(context).size.width,
                        child: Image.file(
                          selectedImage!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        height: 210,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        margin: EdgeInsets.symmetric(vertical: 24),
                        width: MediaQuery.of(context).size.width,
                        child: Icon(
                          Icons.camera_alt,
                          size: 51,
                          color: Colors.white,
                        ),
                      ),
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                controller: titleTextEditingController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.solid, color: Colors.black),
                    ),
                    hintStyle:
                        TextStyle(color: Colors.black, fontFamily: "Quicksand"),
                    hintText: "Enter title"),
              ),
              SizedBox(
                height: 11,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                maxLines: null,
                controller: descTextEditingController,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.solid, color: Colors.black),
                    ),
                    hintStyle:
                        TextStyle(color: Colors.black, fontFamily: "Quicksand"),
                    hintText: "Enter description"),
              ),
              SizedBox(
                height: 11,
              ),
              TextField(
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                controller: authorTextEditingController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.solid, color: Colors.black),
                    ),
                    hintStyle:
                        TextStyle(color: Colors.black, fontFamily: "Quicksand"),
                    hintText: "Enter author name"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 7,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
