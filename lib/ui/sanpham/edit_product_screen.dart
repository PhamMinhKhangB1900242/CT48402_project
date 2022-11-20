import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/product.dart';
import '../shared/dialog_utils.dart';
import 'Quan_Ly_SP.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  EditProductScreen(
    Product? product, {
    super.key,
  }) {
    if (product == null) {
      this.product = Product(
        id: null,
        title: '',
        author: '',
        price: 0,
        dateTime: DateTime.now(),
        description: '',
        imageUrl: '',
      );
    } else {
      this.product = product;
    }
  }
  late final Product product;
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _editForm = GlobalKey<FormState>();
  DateTime dateTime = DateTime.now();
  final TextEditingController date =
      TextEditingController(text: 'Chọn Ngay Cap Nhat');

  late Product _editedProduct;
  var _isLoading = false;
  bool _isValidImageUrl(String value) {
    return (value.startsWith('http') || value.startsWith('http')) &&
        (value.endsWith('.png') ||
            value.endsWith('.jpg') ||
            value.endsWith('.jpeg'));
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(() {
      if (!_imageUrlFocusNode.hasFocus) {
        if (!_isValidImageUrl(_imageUrlController.text)) {
          return;
        }
        setState(() {});
      }
    });
    _editedProduct = widget.product;
    _imageUrlController.text = _editedProduct.imageUrl;
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    _editForm.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      final productsManager = context.read<ProductsManager>();
      if (_editedProduct.id != null) {
        await productsManager.updateProduct(_editedProduct);
      } else {
        await productsManager.addProduct(_editedProduct);
      }
    } catch (error) {
      await showErrorDialog(context, 'Something went wrong.');
    }

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _editForm,
                child: ListView(
                  children: <Widget>[
                    buildTitleField(),
                    buildAuthorField(),
                    buildPriceField(),
                    buildDescriptionField(),
                    buildDateField(context),
                    buildProductPreview(),
                  ],
                ),
              ),
            ),
    );
  }

  Container buildTitleField() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        initialValue: _editedProduct.title,
        decoration: const InputDecoration(
            labelText: 'Tên Sách', border: OutlineInputBorder()),
        textInputAction: TextInputAction.next,
        autofocus: true,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Vui Lòng Nhập Tên Sách';
          }
          return null;
        },
        onSaved: (value) {
          _editedProduct = _editedProduct.copyWith(title: value);
        },
      ),
    );
  }

  Container buildAuthorField() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        initialValue: _editedProduct.title,
        decoration: const InputDecoration(
            labelText: 'Tên Tác Giả', border: OutlineInputBorder()),
        textInputAction: TextInputAction.next,
        autofocus: true,
        validator: (value) {
          return null;
        },
        onSaved: (value) {
          _editedProduct = _editedProduct.copyWith(author: value);
        },
      ),
    );
  }

  Container buildPriceField() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        initialValue: _editedProduct.price.toString(),
        decoration: const InputDecoration(
            labelText: 'Giá Sách', border: OutlineInputBorder()),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Vui lòng nhập giá Sách';
          }
          if (double.tryParse(value) == null) {
            return 'Vui lòng nhập một số hợp lệ';
          }
          if (double.parse(value) <= 0) {
            return 'Vui lòng nhập một số lớn hơn 0';
          }
          return null;
        },
        onSaved: (value) {
          _editedProduct = _editedProduct.copyWith(price: double.parse(value!));
        },
      ),
    );
  }

  Container buildDescriptionField() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        initialValue: _editedProduct.description,
        decoration: const InputDecoration(
            labelText: 'Giới Thiệu Sách', border: OutlineInputBorder()),
        // maxLines: 3,
        keyboardType: TextInputType.multiline,
        validator: (value) {
          return null;
        },
        onSaved: (value) {
          _editedProduct = _editedProduct.copyWith(description: value);
        },
      ),
    );
  }

  Widget buildProductPreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(
            top: 8,
            right: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _imageUrlController.text.isEmpty
              ? const Text('Enter a URL')
              : FittedBox(
                  child: Image.network(
                    _imageUrlController.text,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        Expanded(
          child: buildImageURLField(),
        ),
      ],
    );
  }

  TextFormField buildDateField(context) {
    Padding(
      padding: const EdgeInsets.all(5),
    );
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Ngày Cập Nhật ',
        icon: Icon(Icons.date_range),
      ),
      controller: date,
      onTap: () async {
        final currentDate = DateTime.now();
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: currentDate,
          firstDate: currentDate,
          lastDate: DateTime(currentDate.year + 5),
        );
        setState(() {
          if (selectedDate != null) {
            dateTime = selectedDate;
            date.text = DateFormat('dd-MM-yyyy').format(selectedDate);
          }
        });
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(dateTime: dateTime);
      },
    );
  }

  Container buildImageURLField() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        decoration: const InputDecoration(
            labelText: 'Image URL', border: OutlineInputBorder()),
        keyboardType: TextInputType.url,
        textInputAction: TextInputAction.done,
        controller: _imageUrlController,
        focusNode: _imageUrlFocusNode,
        onFieldSubmitted: (value) => _saveForm(),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Vui lòng nhập URL hình ảnh';
          }
          if (!_isValidImageUrl(value)) {
            return 'Vui lòng nhập URL hình ảnh hợp lệ';
          }
          return null;
        },
        onSaved: (value) {
          _editedProduct = _editedProduct.copyWith(imageUrl: value);
        },
      ),
    );
  }

  Future<void> showErrorDialog(BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Đã xảy ra lỗi!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
}
