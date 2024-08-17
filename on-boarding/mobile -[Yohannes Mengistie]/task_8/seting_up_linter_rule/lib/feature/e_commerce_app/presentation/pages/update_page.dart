import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/product_model.dart';
import '../../domain/entities/e_commerce.dart';
import '../bloc/e_commerce_bloc.dart';

class UpdateProductPage extends StatefulWidget {
  final Product product;

  const UpdateProductPage({super.key, required this.product});

  @override
  _UpdateProductPageState createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();
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

  Future<void> _updateProduct() async {
    final name = _nameController.text.trim();

    final price = double.tryParse(_priceController.text.trim());
    final description = _descriptionController.text.trim();
    final image = _image ?? 'images/defaultImage.jpg';

    if (name.isNotEmpty && price != null && description.isNotEmpty) {
      final updatedProduct = ProductModel(
        id: widget.product.id,
        name: name,
        price: price,
        description: description,
        imageUrl: _image!.path,
      );

      context.read<ECommerceBloc>().add(
          UpdateProductEvent(updatedProduct.id.toString(), updatedProduct));

      await Future.delayed(Duration(seconds: 1));
      context.read<ECommerceBloc>().add(const LoadAllProductEvent());

      Navigator.of(context).pop(updatedProduct);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all the required fields.'),
        ),
      );
    }
  }

  void _deleteProduct() {
    Navigator.of(context).pop();
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
        title: Text("Update Product"),
      ),
      body: SingleChildScrollView(
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
                child: _imageBytes != null
                    ? Image.memory(
                        _imageBytes!,
                        fit: BoxFit.cover,
                      )
                    : Column(
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
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateProduct,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 79, 43, 240),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 125),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "UPDATE",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
