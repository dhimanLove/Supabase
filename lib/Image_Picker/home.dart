import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? _imagefile;
  File? img;

  // pick image
  Future pickimage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagefile = File(image.path);
      });
    }
  }

  // click image
  Future cliickimage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        img = File(image.path);  // Update img instead of _imagefile
      });
    }
  }

  // upload
  // upload
  Future upload() async {
    if (_imagefile == null) {
      return;
    }

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    String path = "Imagedata/$fileName";

    await Supabase.instance.client.storage
        .from('Imagedata')
        .upload(path, _imagefile!);

    // After successful upload, clear the image
    setState(() {
      _imagefile = null;
    });

    Get.snackbar("Success", "Image uploaded successfully", snackPosition: SnackPosition.TOP, colorText: Colors.white);
  }

  Future uploadd() async {
    if (img == null) {
      return;
    }

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    String path = "Imagedata/$fileName";

    await Supabase.instance.client.storage
        .from('Imagedata')
        .upload(path, img!);

    // After successful upload, clear the image
    setState(() {
      img = null;  // Hata diya image ko
    });

    Get.snackbar("Success", "Image uploaded successfully", snackPosition: SnackPosition.TOP, colorText: Colors.white);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text("Picked"),
                      _imagefile != null
                          ? Image.file(
                        _imagefile!,
                        height: 200,
                        width: 150,
                        fit: BoxFit.cover,
                      )
                          : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            size: 100,
                            color: Colors.grey,
                          ),
                          Text("No Files Selected"),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text("Clicked"),
                      img != null
                          ? Image.file(
                        img!,
                        height: 200,
                        width: 150,
                        fit: BoxFit.cover,
                      )
                          : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            size: 100,
                            color: Colors.grey,
                          ),
                          Text("No Files Selected"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: pickimage,
                    child: Text("Pick Image"),
                  ),
                  SizedBox(width: 70),
                  ElevatedButton(
                    onPressed: cliickimage,
                    child: Text("Click Image"),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: upload,
                    child: Text("Picked Upload"),
                  ),
                  SizedBox(width: 35),
                  ElevatedButton(
                    onPressed: uploadd,
                    child: Text("Clicked Upload"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}