import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:random_string/random_string.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  File? _image; // Selected image file
  final ImagePicker _picker = ImagePicker(); // Image picker instance

  Future pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        // ignore: avoid_print
        print("No image selected.");
      }
    });
  }

  Future<String?> uploadImage(String id) async {
    if (_image != null) {
      firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('employeeImages/$id');
      firebase_storage.UploadTask uploadTask = storageRef.putFile(_image!);
      firebase_storage.TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } else {
      return null;
    }
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Adding Details..."),
              ],
            ),
          ),
        );
      },
    );
  }

  void clearFields() {
    nameController.clear();
    ageController.clear();
    locationController.clear();
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Food Details",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 1, 2),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add New Food Item",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal),
            ),
            const SizedBox(height: 20),
            buildInputCard(
              "Food Name",
              "Enter Food name",
              nameController,
            ),
            const SizedBox(height: 20),
            buildInputCard(
              "Price",
              "Enter Price",
              ageController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            buildInputCard(
              "Offer",
              "Enter Offer",
              locationController,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: pickImage,
                icon: const Icon(Icons.image),
                label: const Text("Pick Image"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            _image != null
                ? Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.file(
                        _image!,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : const Center(
                    child: Text("No image selected",
                        style: TextStyle(color: Colors.red))),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (nameController.text.isEmpty ||
                      ageController.text.isEmpty ||
                      locationController.text.isEmpty ||
                      _image == null) {
                    Fluttertoast.showToast(
                      msg: "Please fill all fields and select an image",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                    return;
                  }

                  showLoadingDialog(context);
                  try {
                    String id = randomAlphaNumeric(10);
                    String? imageUrl = await uploadImage(id);
                    Map<String, dynamic> employeeInfoMap = {
                      "Name": nameController.text,
                      "food": ageController.text,
                      "ID": id,
                      "offer": locationController.text,
                      "ImageURL": imageUrl,
                    };
                    await DatabaseMethod()
                        .addEmployeeDetails(employeeInfoMap, id)
                        .then((value) {
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                        msg: "Details added successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      clearFields();
                    });
                  } catch (e) {
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    // ignore: avoid_print
                    print(e);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 48,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Add Food Item",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for creating input cards
  Widget buildInputCard(
      String label, String hint, TextEditingController controller,
      {TextInputType? keyboardType}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              keyboardType: keyboardType ?? TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: hint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DatabaseMethod {
  Future addEmployeeDetails(
      Map<String, dynamic> employeeInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .set(employeeInfoMap);
  }

  getEmployeeDeatails() {}
}
