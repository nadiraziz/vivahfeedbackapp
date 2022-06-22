import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomerInfoDashBoard extends StatefulWidget {
  static String id = 'customerdash_screen';
  const CustomerInfoDashBoard({Key? key}) : super(key: key);

  @override
  State<CustomerInfoDashBoard> createState() => _CustomerInfoDashBoardState();
}

class _CustomerInfoDashBoardState extends State<CustomerInfoDashBoard> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('customerInfo')
      .orderBy('createdAt', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(semanticsLabel: 'Loading'),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('CUSTOMER INFO'),
            ),
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Card(
                  child: ListTile(
                    title: Text(data['name']),
                    subtitle: Text(data['email']),
                    leading: const CircleAvatar(
                      child: Image(
                        image: AssetImage('assets/images/Profile_Image.png'),
                      ),
                    ),
                    trailing: SelectableText(data['phone']),
                  ),
                );
              }).toList(),
            ),
          );
        });
  }
}
