import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_auth_crud/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth/sign_in_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final Stream<QuerySnapshot> _wordsStream =
      FirebaseFirestore.instance.collection('words').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              signOut();
            },
            icon: const Icon(Icons.logout_outlined),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          writeData(context);
        },
        child: const Icon(Icons.add_outlined),
      ),
      body: Column(
        children: [
          Expanded(
            child: ReadData(wordsStream: _wordsStream),
          )
        ],
      ),
    );
  }

  void signOut() {
    auth.signOut().then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInScreen(),
          ),
          (route) => false);
    }).onError((error, stackTrace) {
      Utils.toastMessage(error.toString());
    });
  }

  CollectionReference words = FirebaseFirestore.instance.collection('words');

  Future<void> addWords() {
    String id = DateTime.now().microsecondsSinceEpoch.toString();
    return words.doc(id).set({
      'word': _nameController.text.trim(),
      "id": id,
    }).then((value) {
      _nameController.clear();
      Utils.toastMessage("Word is added");
    }).onError((error, stackTrace) {
      Center(
        child: Text(error.toString()),
      );
    }).then((value) {
      Navigator.pop(context);
    });
  }

  writeData(context) async {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            child: Container(
              height: 300,
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        labelText: "Write Word",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter word";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          addWords();
                        },
                        child: const Text("Add"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }
}

class ReadData extends StatelessWidget {
  const ReadData({
    super.key,
    required Stream<QuerySnapshot<Object?>> wordsStream,
  }) : _wordsStream = wordsStream;

  final Stream<QuerySnapshot<Object?>> _wordsStream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _wordsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.green,
          ));
        }

        final sortedDocs = snapshot.data!.docs.toList()
          ..sort((a, b) => a['word'].compareTo(b['word']));

        return ListView.separated(
          itemCount: sortedDocs.length,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot document = sortedDocs[index];
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
                title: Text(data['word'] ?? "Something error"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Utils.toastMessage("Comming Soon");
                      },
                      icon: const Icon(Icons.edit_outlined),
                    ),
                    IconButton(
                      onPressed: () {
                        deleteWord(data);
                      },
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ],
                ));
          },
        );
      },
    );
  }

  Future<void> deleteWord(Map<String, dynamic> data) {
    CollectionReference words = FirebaseFirestore.instance.collection('words');

    return words
        .doc(data["id"])
        .delete()
        .then((value) => Utils.toastMessage("Word deleted"))
        .catchError((error) {
      Utils.toastMessage(error.toString());
    });
  }

  Future<void> editWord(Map<String, dynamic> data) {
    CollectionReference words = FirebaseFirestore.instance.collection('words');

    return words
        .doc(data["id"])
        .update(data)
        .then((value) => Utils.toastMessage("Word deleted"))
        .catchError((error) {
      Utils.toastMessage(error.toString());
    });
  }

}
