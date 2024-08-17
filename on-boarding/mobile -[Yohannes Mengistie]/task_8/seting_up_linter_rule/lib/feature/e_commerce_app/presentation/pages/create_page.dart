import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/product_model.dart';
import '../../domain/entities/e_commerce.dart';
import '../bloc/e_commerce_bloc.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({super.key});

  @override
  State<CreateProductPage> createState() => _AddUpdateState();
}

class _AddUpdateState extends State<CreateProductPage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  Uint8List? _imageBytes;

  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _imagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _saveProduct() async {
    final name = _nameController.text.trim();
    final price = double.tryParse(_priceController.text.trim());
    final description = _descriptionController.text.trim();

    if (name.isNotEmpty && price != null && description.isNotEmpty) {
      final newProduct = ProductModel(
        name: name,
        price: price,
        description: description,
        imageUrl: _image?.path ?? 'images/defaultImage.jpg',
        id: '',
      );

      context.read<ECommerceBloc>().add(CreatProductEvent(newProduct));
      await Future.delayed(Duration(seconds: 1));
      context.read<ECommerceBloc>().add(const LoadAllProductEvent());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all the required fields.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Add Product"),
      ),
      body: BlocListener<ECommerceBloc, ECommerceState>(
        listener: (context, state) {
          if (state is LoadedSingleProductState) {
            Navigator.of(context).pop(); // Close the progress dialog
            Navigator.of(context).pop(state.product); // Return the new product
          } else if (state is ErrorState) {
            Navigator.of(context).pop(); // Close the progress dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _imagePicker,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _image != null
                      ? Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        )
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.grey,
                            ),
                            Text(
                              "Upload Image",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                ),
              ),
              SizedBox(height: 16),
              Text("Name", style: TextStyle(fontSize: 16)),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text("Price", style: TextStyle(fontSize: 16)),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('\$', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text("Description", style: TextStyle(fontSize: 16)),
              TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // showDialog(
                    //   context: context,
                    //   barrierDismissible: false,
                    //   builder: (context) => const AlertDialog(
                    //     title: Text('Adding Product!'),
                    //     content: CircularProgressIndicator(),
                    //   ),
                    // );
                    _saveProduct();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 79, 43, 240),
                    padding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 140),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "ADD",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 125),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "CANCEL",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
