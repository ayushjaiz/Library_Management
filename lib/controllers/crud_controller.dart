import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_project/models/book_model.dart';

class DatabaseMethods {
  final _db = FirebaseFirestore.instance.collection("Book");

  // Get all books
  Future<List<Book>> getBookDetails() async {
    try {
      var collectionSnapshot = await _db.get();
      List<Book> books = collectionSnapshot.docs.map((doc) => Book.fromJson(doc.data())).toList();
      return books;
    } catch (error) {
      throw "Error fetching book details";
    }
  }

  // Add new book
  Future<void> addBookDetails(
      {required title, required id, required author, required borrower, required date}) async {
    Book newBook = Book(title: title, id: id, author: author, borrower: borrower, date: date);
    try {
      await _db.doc(id).set(newBook.toJson());
    } catch (error) {
      throw "Error adding book details";
    }
  }

  // Edit book
  Future<void> updateBookDetail(
      {required title, required id, required author, required borrower, required date}) async {
    try {
      Book updatedBook = Book(title: title, id: id, author: author, borrower: borrower, date: date);
      await _db.doc(id).update(updatedBook.toJson());
    } catch (error) {
      throw "Error updating book details";
    }
  }

  // Delete book
  Future<void> deleteBookDetail(String id) async {
    try {
      await _db.doc(id).delete();
    } catch (error) {
      throw "Error deleting book details";
    }
  }
}
