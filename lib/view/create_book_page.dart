import 'package:first_project/controllers/crud_controller.dart';
import 'package:flutter/material.dart';
import 'package:first_project/utils/uiHelper.dart';
import 'package:random_string/random_string.dart';

class CreateBook extends StatefulWidget {
  const CreateBook({super.key});

  @override
  State<CreateBook> createState() => _CreateBookState();
}

class _CreateBookState extends State<CreateBook> {
  TextEditingController bookController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController borrowerController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  void _handleAddBook() async {
    try {
      String id = randomAlphaNumeric(10);

      await DatabaseMethods()
          .addBookDetails(
        title: bookController.text.toString(),
        id: id,
        author: authorController.text.toString(),
        borrower: borrowerController.text.toString(),
        date: dateController.text.toString(),
      )
          .then((value) {
        return UiHelper.CustomAlertBox(context, "Book added successfully");
      });
    } catch (e) {
      return UiHelper.CustomAlertBox(context, "Error occurred while adding book");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title:
            const Text('Add Book Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, top: 30),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20), // Set the top margin as needed
              child: Row(
                children: [
                  Container(
                    width: 80,
                    child: const Text(
                      "Title",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  Container(
                    width: 250,
                    child: UiHelper.CustomTextField(
                        bookController, "Title of Book", Icons.book, false),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20), // Set the top margin as needed
              child: Row(
                children: [
                  Container(
                    width: 80,
                    child: const Text(
                      "Author",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  Container(
                    width: 250,
                    child: UiHelper.CustomTextField(
                        authorController, "Author Name", Icons.person, false),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20), // Set the top margin as needed
              child: Row(
                children: [
                  Container(
                    width: 80,
                    child: const Text(
                      "Borrower",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  Container(
                    width: 250,
                    child: UiHelper.CustomTextField(
                        borrowerController, "Borrower", Icons.person_2, false),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              // Set the top margin as needed
              child: Row(
                children: [
                  Container(
                    width: 80,
                    child: const Text(
                      "Issued on",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  Container(
                    width: 250,
                    child: UiHelper.CustomTextField(
                        dateController, "Enter Date", Icons.calendar_month, false),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              width: 150,
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: _handleAddBook,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.blue), // Set the background color to blue
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
