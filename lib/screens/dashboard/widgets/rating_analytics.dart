import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RatingAnalytics extends StatefulWidget {
  static String id = 'analytics_screen';
  const RatingAnalytics({Key? key}) : super(key: key);

  @override
  State<RatingAnalytics> createState() => _RatingAnalyticsState();
}

class _RatingAnalyticsState extends State<RatingAnalytics> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('rating')
      .orderBy('createdAt', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
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
            appBar: AppBar(title: Text('Analytics')),
            body: ListView(
              physics: BouncingScrollPhysics(),
              // crossAxisCount: 4,
              // childAspectRatio: 2,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Card(
                  child: ExpansionTile(
                    title: Text(
                      data['name'],
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(data['phone'],
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold)),
                    trailing: Image.asset(
                      'assets/images/Profile_Image.png',
                      width: 30,
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "Collection: ${data['collection'].toString()}"),
                            Text(
                              'Favourite Collection: ${data['FavCollection'].toString()}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Satisfied?: " + data['satisfy']),
                            Text("Staff: " + data['staff'].toString()),
                            Text(
                              "Overall: " + data['overall'].toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
