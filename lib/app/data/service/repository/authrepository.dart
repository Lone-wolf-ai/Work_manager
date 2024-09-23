
import '../../../core/utils/constants/string_const.dart';
import '../../../core/utils/exceptions/firebase_exceptions.dart';
import '../../../core/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FirebaseRepo extends GetxController {
  static FirebaseRepo get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  User? get currenuser=>_auth.currentUser;

  bool get isAuthenticated=>currenuser!=null;
  
  ////HEre wrote auth codes
  ///signinwithemailandpassword
  signin(String email, String password) async {
    try {
      print("starte in firebase repo");
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      print("executed and returning");
      return userCredential;
    } on FirebaseExceptionString catch (e) {
      throw FirebaseExceptionString(e.code).message;
    } on PlatformException catch (e) {
      throw PlatformExceptionString(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  ///register with email and password
  registerWithEmailandPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseExceptionString catch (e) {
      throw FirebaseExceptionString(e.code).message;
    } on PlatformException catch (e) {
      throw PlatformExceptionString(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  sendVerificationEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    } on FirebaseExceptionString catch (e) {
      throw FirebaseExceptionString(e.code).message;
    } on PlatformException catch (e) {
      throw PlatformExceptionString(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  ///signinaninomusly
  signinanynomusly() async {
    try {
      final UserCredential userCredential = await _auth.signInAnonymously();
      return userCredential.user!.uid;
    } on FirebaseExceptionString catch (e) {
      throw FirebaseExceptionString(e.code).message;
    } on PlatformException catch (e) {
      throw PlatformExceptionString(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  //signout
  void signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseExceptionString catch (e) {
      throw FirebaseExceptionString(e.code).message;
    } on PlatformException catch (e) {
      throw PlatformExceptionString(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  ///data storage code

  ///create collection and add data
  Future<DocumentReference<Map<String, dynamic>>> createCollection(
      String collectionName, Map<String, dynamic> data,
      {String? docId}) async {
    try {
      final CollectionReference<Map<String, dynamic>> collectionRef =
          _firestore.collection(collectionName);

      DocumentReference<Map<String, dynamic>> docRef;
      if (docId != null) {
        //  custom document ID
        docRef = collectionRef.doc(docId);
        await docRef.set(data);
      } else {
        // Auto-generate the document ID
        docRef = await collectionRef.add(data);
      }

      return docRef;
    } on FirebaseExceptionString catch (e) {
      throw FirebaseExceptionString(e.code).message;
    } on PlatformException catch (e) {
      throw PlatformExceptionString(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw e.toString();
    }
  }

  //create subcollection data
  createSubCollection(String collectionName, String subCollectionName,
      dynamic docId, dynamic subDocId, Map<String, dynamic> data) async {
    try {
      final docref = await _firestore
          .collection(collectionName)
          .doc(docId)
          .collection(subCollectionName)
          .doc(subDocId)
          .set(data);
      return docref;
    } on FirebaseExceptionString catch (e) {
      throw FirebaseExceptionString(e.code).message;
    } on PlatformException catch (e) {
      throw PlatformExceptionString(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  //filtter data
  filterUsingQuery(
      String collectionName, String fieldName, dynamic value) async {
    try {
      final data = await _firestore
          .collection(collectionName)
          .where(fieldName, isEqualTo: value)
          .get();
      return data;
    } on FirebaseExceptionString catch (e) {
      throw FirebaseExceptionString(e.code).message;
    } on PlatformException catch (e) {
      throw PlatformExceptionString(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  ///read data from database using name and id
  Future<DocumentSnapshot<Map<String, dynamic>>>
      readDataUsingIdandColletionname(String collectionName, dynamic id) async {
    try {
      final docref = await _firestore.collection(collectionName).doc(id).get();
      return docref;
    } on FirebaseExceptionString catch (e) {
      throw FirebaseExceptionString(e.code).message;
    } on PlatformException catch (e) {
      throw PlatformExceptionString(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    throw 'Something went wrong';
  }

  fetchdatafromattendance(dynamic date) async {
    try {
      final data = await FirebaseFirestore.instance
          .collection(StringConst.userdata)
          .doc(currenuser!.uid)
          .collection(StringConst.attendancerecord)
          .doc(date)
          .get();
      return data;
    } on FirebaseExceptionString catch (e) {
      throw FirebaseExceptionString(e.code).message;
    } on PlatformException catch (e) {
      throw PlatformExceptionString(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  ///read sub collection

  Future<QuerySnapshot<Map<String, dynamic>>>
      readSubCollectionDataUsingIdandColletionname(String collectionName,
          dynamic docId, String subCollectionName) async {
    try {
      final docref = _firestore
          .collection(collectionName)
          .doc(docId)
          .collection(collectionName)
          .get();
      return docref;
    } on FirebaseExceptionString catch (e) {
      throw FirebaseExceptionString(e.code).message;
    } on PlatformException catch (e) {
      throw PlatformExceptionString(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    throw 'Something went wrong';
  }
  //read data from subcollection using qury
  //   Future<QuerySnapshot<Map<String, dynamic>>>
  //     readSubCollectionUsingquery(
  //         String collectionName, dynamic id, String subCollectionName) async {
  //   try {
  //     final docref = await _firestore
  //         .collection(collectionName)
  //         .doc(id)
  //         .collection(collectionName);
  //     return docref;
  //   } on FirebaseExceptionString catch (e) {
  //     throw FirebaseExceptionString(e.code).message;
  //   } on PlatformException catch (e) {
  //     throw PlatformExceptionString(e.code).message;
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e.toString());
  //     }
  //   }
  //   throw 'Something went wrong';
  // }
  ///read all data from database using collection

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> readAllDocuments(
    String collectionName,
  ) async {
    try {
      final querySnapshot = await _firestore.collection(collectionName).get();
      return querySnapshot.docs;
    } on FirebaseExceptionString catch (e) {
      throw FirebaseExceptionString(e.code).message; // Or handle the error as needed
    } on PlatformException catch (e) {
      throw PlatformExceptionString(e.code).message; // Or handle the error as needed
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw 'An unexpected error occurred.'; // Or provide a more user-friendly message
    }
  }

  ///update data
  updateData(
      String collectionName, dynamic id, Map<String, dynamic> data) async {
    try {
      _firestore.collection(collectionName).doc(id).update(data);
    } on FirebaseExceptionString catch (e) {
      throw FirebaseExceptionString(e.code).message; // Or handle the error as needed
    } on PlatformException catch (e) {
      throw PlatformExceptionString(e.code).message; // Or handle the error as needed
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw 'An unexpected error occurred.'; // Or provide a more user-friendly message
    }
  }

  Future<void> updateSubcollectionData(
    String collectionName,
    dynamic id,
    dynamic subcollectionId,
    String subCollectionName,
    Map<String, dynamic> data,
  ) async {
    try {
      // Reference to the subcollection
       _firestore
          .collection(collectionName)
          .doc(id)
          .collection(subCollectionName)
          .doc(subcollectionId)
          .update(data);
    } on FirebaseExceptionString catch (e) {
      throw Exception('Firebase error: ${e.code} - ${e.message}');
    } on PlatformException catch (e) {
      throw Exception('Platform error: ${e.code} - ${e.message}');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception('An unexpected error occurred.');
    }
  }

  ///delete doc
  deleteDate(String collectionName, dynamic id) async {
    try {
      await _firestore.collection(collectionName).doc(id).delete();
    } on FirebaseExceptionString catch (e) {
      throw FirebaseExceptionString(e.code).message; // Or handle the error as needed
    } on PlatformException catch (e) {
      throw PlatformExceptionString(e.code).message; // Or handle the error as needed
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw 'An unexpected error occurred.'; // Or provide a more user-friendly message
    }
  }
  //cloud storage

  Future<String> uploadFile(Uint8List data, String path) async {
     if (!isAuthenticated) {
    throw 'User not authenticated';
  
  }
    try {
      final TaskSnapshot snapshot =
          await FirebaseStorage.instance.ref(path).putData(data);
      return await snapshot.ref.getDownloadURL();
    } on FirebaseExceptionString catch (e) {
      throw FirebaseExceptionString(e.code).message; // Or handle errors as needed
    } on PlatformException catch (e) {
      throw PlatformExceptionString(e.code).message; // Or handle errors as needed
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw 'An unexpected error occurred.'; // Or provide a user-friendly message
    }
  }

// Add this function to compress the image (replace with your logic if needed)
  deleteFile(String path) async {
    try {
      await FirebaseStorage.instance.ref(path).delete();
    } on FirebaseExceptionString catch (e) {
      throw FirebaseExceptionString(e.code).message; // Or handle errors as needed
    } on PlatformException catch (e) {
      throw PlatformExceptionString(e.code).message; // Or handle errors as needed
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw 'An unexpected error occurred.'; // Or provide a user-friendly message
    }
  }
  readDataUsingIdAndCollectionName(String attendancerecord, String s) {}
}
