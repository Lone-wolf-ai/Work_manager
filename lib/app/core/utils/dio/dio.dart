import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dio Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const ElevatedButton(
              onPressed: fetchAllProducts,
              child: Text('Fetch All Products'),
            ),
            ElevatedButton(
              onPressed: () => fetchSingleProduct(1),
              child: const Text('Fetch Single Product'),
            ),
            ElevatedButton(
              onPressed: () => fetchProductsByCategory('jewelery'),
              child: const Text('Fetch Products by Category'),
            ),
            const ElevatedButton(
              onPressed: fetchAllCategories,
              child: Text('Fetch All Categories'),
            ),
            const ElevatedButton(
              onPressed: fetchAllUsers,
              child: Text('Fetch All Users'),
            ),
            ElevatedButton(
              onPressed: () => fetchSingleUser(1),
              child: const Text('Fetch Single User'),
            ),
            const ElevatedButton(
              onPressed: addNewProduct,
              child: Text('Add New Product'),
            ),
            const ElevatedButton(
              onPressed: addNewUser,
              child: Text('Add New User'),
            ),
            const ElevatedButton(
              onPressed: userLogin,
              child: Text('User Login'),
            ),
            ElevatedButton(
              onPressed: () => updateProduct(1),
              child: const Text('Update Product'),
            ),
            ElevatedButton(
              onPressed: () => updateUser(1),
              child: const Text('Update User'),
            ),
            ElevatedButton(
              onPressed: () => deleteProduct(1),
              child: const Text('Delete Product'),
            ),
            ElevatedButton(
              onPressed: () => deleteUser(1),
              child: const Text('Delete User'),
            ),
          ],
        ),
      ),
    );
  }
}

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late Dio _dio;

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://fakestoreapi.com',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ));

    // Adding a log interceptor
    _dio.interceptors.add(LogInterceptor(responseBody: false));
  }

  Dio get dio => _dio;
}

Future<void> fetchAllProducts() async {
  try {
    final response = await ApiClient().dio.get('/products');
    print(response.data);
  } on DioException catch (e) {
    handleError(e);
  }
}

Future<void> fetchSingleProduct(int id) async {
  try {
    final response = await ApiClient().dio.get('/products/$id');
    print(response.data);
  } on DioException catch (e) {
    handleError(e);
  }
}

Future<void> fetchProductsByCategory(String category) async {
  try {
    final response = await ApiClient().dio.get('/products/category/$category');
    print(response.data);
  } on DioException catch (e) {
    handleError(e);
  }
}

Future<void> fetchAllCategories() async {
  try {
    final response = await ApiClient().dio.get('/products/categories');
    print(response.data);
  } on DioException catch (e) {
    handleError(e);
  }
}

Future<void> fetchAllUsers() async {
  try {
    final response = await ApiClient().dio.get('/users');
    print(response.data);
  } on DioException catch (e) {
    handleError(e);
  }
}

Future<void> fetchSingleUser(int id) async {
  try {
    final response = await ApiClient().dio.get('/users/$id');
    print(response.data);
  } on DioException catch (e) {
    handleError(e);
  }
}

Future<void> addNewProduct() async {
  try {
    final response = await ApiClient().dio.post(
      '/products',
      data: {
        'title': 'test product',
        'price': 13.5,
        'description': 'lorem ipsum set',
        'image': 'https://i.pravatar.cc',
        'category': 'electronic'
      },
    );
    print(response.data);
  } on DioException catch (e) {
    handleError(e);
  }
}

Future<void> addNewUser() async {
  try {
    final response = await ApiClient().dio.post(
      '/users',
      data: {
        'email': 'John@gmail.com',
        'username': 'johnd',
        'password': 'm38rmF',
        'name': {
          'firstname': 'John',
          'lastname': 'Doe'
        },
        'address': {
          'city': 'kilcoole',
          'street': '7835 new road',
          'number': 3,
          'zipcode': '12926-3874',
          'geolocation': {
            'lat': '-37.3159',
            'long': '81.1496'
          }
        },
        'phone': '1-570-236-7033'
      },
    );
    print(response.data);
  } on DioException catch (e) {
    handleError(e);
  }
}

Future<void> userLogin() async {
  try {
    final response = await ApiClient().dio.post(
      '/auth/login',
      data: {
        'username': 'mor_2314',
        'password': '83r5^_'
      },
    );
    print(response.data);
  } on DioException catch (e) {
    handleError(e);
  }
}

Future<void> updateProduct(int id) async {
  try {
    final response = await ApiClient().dio.put(
      '/products/$id',
      data: {
        'title': 'updated product',
        'price': 15.0,
        'description': 'updated description',
        'image': 'https://i.pravatar.cc',
        'category': 'electronic'
      },
    );
    print(response.data);
  } on DioException catch (e) {
    handleError(e);
  }
}

Future<void> updateUser(int id) async {
  try {
    final response = await ApiClient().dio.put(
      '/users/$id',
      data: {
        'email': 'updated@gmail.com',
        'username': 'updateduser',
        'password': 'updatedpassword',
        'name': {
          'firstname': 'Updated',
          'lastname': 'User'
        },
        'address': {
          'city': 'updatedcity',
          'street': 'updated street',
          'number': 1,
          'zipcode': '12345',
          'geolocation': {
            'lat': '-37.3159',
            'long': '81.1496'
          }
        },
        'phone': '1-570-236-7033'
      },
    );
    print(response.data);
  } on DioException catch (e) {
    handleError(e);
  }
}

Future<void> deleteProduct(int id) async {
  try {
    final response = await ApiClient().dio.delete('/products/$id');
    print(response.data);
  } on DioException catch (e) {
    handleError(e);
  }
}

Future<void> deleteUser(int id) async {
  try {
    final response = await ApiClient().dio.delete('/users/$id');
    print(response.data);
  } on DioException catch (e) {
    handleError(e);
  }
}

void handleError(DioException e) {
  if (e.response != null) {
    print(e.response!.data);
    print(e.response!.headers);
    print(e.response!.requestOptions);
  } else {
    print(e.requestOptions);
    print(e.message);
  }
}