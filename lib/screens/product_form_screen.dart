import 'dart:math';

import 'package:dev_store/models/product.dart';
import 'package:flutter/material.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final priceFocus = FocusNode();
  final descriptionFocus = FocusNode();
  final imageUrlFocus = FocusNode();

  final imageUrlController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final Map<String, Object> formData = {};

  @override
  void initState() {
    super.initState();
    imageUrlFocus.addListener(updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    priceFocus.dispose();
    descriptionFocus.dispose();
    imageUrlFocus.dispose();
    imageUrlFocus.removeListener(updateImage);
  }

  void updateImage() {
    setState(() {});
  }

  void submitForm() {
    formKey.currentState?.save();

    final newProduct = Product(
        id: Random().nextDouble().toString(),
        title: formData['name'] as String,
        description: formData['description'] as String,
        price: formData['price'] as double,
        imageUrl: formData['name'] as String);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de produto'),
        actions: [
          IconButton(
            onPressed: submitForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(
                      priceFocus); // Faz com que o focus do input "preço" seja atribuído
                },
                onSaved: (value) => formData['name'] = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Preço'),
                textInputAction: TextInputAction.next,
                focusNode: priceFocus,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(descriptionFocus);
                },
                onSaved: (value) =>
                    formData['price'] = double.parse(value ?? '0'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descrição'),
                focusNode: descriptionFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onSaved: (value) => formData['description'] = value ?? '',
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Url da imagem'),
                      focusNode: imageUrlFocus,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: imageUrlController,
                      onFieldSubmitted: (_) => submitForm(),
                      onSaved: (value) => formData['imageUrl'] = value ?? '',
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    )),
                    alignment: Alignment.center,
                    child: imageUrlController.text.isEmpty
                        ? const Text('Informe a url')
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(imageUrlController.text),
                          ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
