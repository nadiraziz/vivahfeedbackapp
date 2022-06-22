import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:vivah/screens/core/constant.dart';
import 'package:vivah/services/questions/question_service.dart';

import 'compents/back_ground.dart';
import 'compents/end_video_screen.dart';

QuestionService ratingQuestion = QuestionService();

class RatingScreen extends StatefulWidget {
  static String id = 'rating_screen';
  final String customerName;
  final String customerEmail;
  final String customerPhone;

  const RatingScreen(
      {Key? key,
      required this.customerName,
      required this.customerEmail,
      required this.customerPhone})
      : super(key: key);
  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double rating = 4.0;
  String option = '';
  List<dynamic> ratedList = [];

  int questionIndex = 0;

  void nextQuestion() {
    if (questionIndex < ratingQuestion.questions.length) {
      questionIndex++;
    }
  }

  // is question is finished
  bool isFinished() {
    if (questionIndex == ratingQuestion.questions.length - 1) {
      print('Now returning true');
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          BackgroundVideo(),
          Column(
            children: [
              Image.asset(
                'assets/images/vivahblack.png',
                fit: BoxFit.fitHeight,
                width: 250,
              ),
              Center(
                child: Container(
                  color: Colors.amber.withOpacity(0.3),
                  width: size.width,
                  height: size.height / 1.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 35,
                        width: double.infinity,
                        color: Colors.amber.withOpacity(0.2),
                        child: Center(
                          child: Text(
                            ratingQuestion
                                .questions[questionIndex].questionText,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                      kHeight10,
                      if (ratingQuestion.questions[questionIndex].notRate ==
                          false) ...[
                        Container(
                          width: double.infinity,
                          color: Colors.white60.withOpacity(0.2),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: Center(
                              child: RatingBar.builder(
                                initialRating: rating,
                                allowHalfRating: true,
                                minRating: 1,
                                itemCount: 5,
                                itemBuilder: (context, _) =>
                                    const Icon(Icons.star, color: Colors.amber),
                                onRatingUpdate: (value) {
                                  Future.delayed(
                                      const Duration(milliseconds: 400), () {
                                    setState(() {
                                      rating = value;
                                      ratedList.add(rating.toInt());

                                      updateRate(
                                        customerEmail: widget.customerEmail,
                                        customerName: widget.customerName,
                                        customerPhone: widget.customerPhone,
                                      );
                                    });
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ] else ...[
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            color: Colors.amber.withOpacity(0.2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: ratingQuestion
                                      .questions[questionIndex]
                                      .questionOption
                                      .length,
                                  itemBuilder: (context, index) {
                                    return RadioListTile(
                                      activeColor: Colors.amber,
                                      value: ratingQuestion
                                          .questions[questionIndex]
                                          .questionOption[index]
                                          .toString(),
                                      groupValue: option,
                                      onChanged: (value) {
                                        Future.delayed(
                                            const Duration(milliseconds: 300),
                                            () {
                                          setState(() {
                                            option = value.toString();
                                            ratedList.add(value);
                                            print(widget.customerEmail);
                                            updateRate(
                                              customerEmail:
                                                  widget.customerEmail,
                                              customerName: widget.customerName,
                                              customerPhone:
                                                  widget.customerPhone,
                                            );
                                          });
                                        });
                                      },
                                      title: Text(
                                        ratingQuestion.questions[questionIndex]
                                            .questionOption[index],
                                        style: kRatingTextStyle,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      ]
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void updateRate({customerName, customerEmail, customerPhone}) async {
    if (!isFinished()) {
      rating = 3;
      nextQuestion();
      print(ratedList);
    } else {
      Map<String, dynamic> data = {
        'name': customerName,
        "email": customerEmail,
        "phone": customerPhone,
        'collection': ratedList[0],
        'FavCollection': ratedList[1],
        'satisfy': ratedList[2],
        'staff': ratedList[3],
        'overall': ratedList[4],
        'createdAt': FieldValue.serverTimestamp()
      };
      FirebaseFirestore.instance.collection('rating').add(data);
      questionIndex = 0;
      ratedList = [];
      print('successful');
      Navigator.of(context).pushNamed(EndVideoApp.id);
    }
  }
}
