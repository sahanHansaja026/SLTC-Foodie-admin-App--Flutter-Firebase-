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
  TextEditingController priceController = TextEditingController();
  TextEditingController offerController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String selectedCategory = "Select Category"; // Default value for category

  File? _image; // Selected image file
  final ImagePicker _picker = ImagePicker(); // Image picker instance

  // Food categories to choose from
  final List<String> categories = [
    "Select Category",
    "Beverages",
    "Snacks",
    "Main Course",
    "Desserts",
    "Fast Food"
  ];

  Future pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
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
    priceController.clear();
    offerController.clear();
    descriptionController.clear();
    setState(() {
      _image = null;
      selectedCategory = "Select Category";
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
              priceController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            buildInputCard(
              "Offer",
              "Enter Offer",
              offerController,
            ),
            const SizedBox(height: 20),
            buildInputCard(
              "Description",
              "Enter Food Description",
              descriptionController,
            ),
            const SizedBox(height: 20),
            // Dropdown for selecting category
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Category",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButton<String>(
                      value: selectedCategory,
                      isExpanded: true,
                      items: categories.map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCategory = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ),
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
                      priceController.text.isEmpty ||
                      offerController.text.isEmpty ||
                      descriptionController.text.isEmpty ||
                      selectedCategory == "Select Category" ||
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
                      "food": priceController.text,
                      "ID": id,
                      "offer": offerController.text,
                      "description": descriptionController.text,
                      "category": selectedCategory,
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
                    Navigator.pop(context);
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
}
