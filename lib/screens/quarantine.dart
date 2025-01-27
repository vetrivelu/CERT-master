import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pert/constants/colors.dart';
import 'package:pert/models/usermodel.dart';

class QuarantinePage extends StatefulWidget {
  QuarantinePage({Key? key, required this.user}) : super(key: key);
  final UserModel user;
  @override
  _QuarantinePageState createState() => _QuarantinePageState();
}

class _QuarantinePageState extends State<QuarantinePage> {
  @override
  void initState() {
    daysLeft = widget.user.quarantine!=null?
    widget.user.quarantine!.endDate.difference(DateTime.now()).inDays:0;
    super.initState();
  }
  int daysLeft = 0;
  @override
  Widget build(BuildContext context) {
    final date =widget.user.quarantine!;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Quarantine History'),
          centerTitle: true,
        ),
        body:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Image.asset(
                    'assets/studenthomepage/quarantinehistroy.png',
                    height: MediaQuery.of(context).size.height * 0.35,
                    fit: BoxFit.contain,
                  ),
                ),


                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  child:widget.user.quarantine!=null?Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                      color: Color(0xFFEC4338),

                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("$daysLeft", style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text("days left", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
                      ],
                    ),
                  ):Container(

                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Your Recent Quarantine',
                  style: TextStyle(
                    color: kprimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: widget.user.quarantine == null ? const Center(child :Text("No records found. You are not in Quarantine")) :Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                  maxLines: 5,
                                  text: TextSpan(
                                      text: 'Address       :  ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600]),
                                      children: [
                                        TextSpan(
                                          text: widget.user.quarantine!.location.place,
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey[500]),
                                        )
                                      ]),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Block            :  ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600]),
                                      children: [
                                        TextSpan(
                                          text: widget.user.quarantine!.location.block,
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey[500]),
                                        )
                                      ]),
                                ),
                              ),

                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: RichText(
                              //     text: TextSpan(
                              //         text: "Floor             :  ",
                              //         style: TextStyle(
                              //             fontWeight: FontWeight.bold,
                              //             color: Colors.grey[600]),
                              //         children: [
                              //           TextSpan(
                              //             text: widget.user.quarantine!.location.floor.toString(),
                              //             style: TextStyle(
                              //                 fontWeight: FontWeight.normal,
                              //                 color: Colors.grey[500]),
                              //           )
                              //         ]),
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Room NO     :  ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600]),
                                      children: [
                                        TextSpan(
                                          text: widget.user.quarantine!.location.roomNumbmer.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey[500]),
                                        )
                                      ]),
                                ),
                              ),

                            ],
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Column(
                              children: [
                                const  Padding(
                                  padding: EdgeInsets.only(bottom: 16),
                                  child: Icon(
                                    Icons.calendar_today,
                                    size: 30,
                                  ),
                                ),
                                Text(
                                  "${date.startDate.day}/${date.startDate.month}/${date.startDate.year}",
                                  style: TextStyle(
                                      color: kprimaryColor, fontSize: 16),
                                ),
                                Text(
                                  "${date.endDate.day}/${date.endDate.month}/${date.endDate.year}",
                                  style: TextStyle(
                                      color: kprimaryColor, fontSize: 16),
                                ),
                                Text(
                                  'Duration : ${widget.user.quarantine!.endDate.difference(widget.user.quarantine!.startDate).inDays.toString()} days' ,
                                  style: TextStyle(
                                      color: kprimaryColor, fontSize: 16),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Text(
                //   'Quarantine History',
                //   style: TextStyle(
                //     color: Colors.grey[700],
                //     fontWeight: FontWeight.bold,
                //     fontSize: 18,
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // SizedBox(
                //   width: double.infinity,
                //   child: Card(
                //     color: kprimaryColor,
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Row(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                //         children: [
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               SizedBox(
                //                 height: 40,
                //                 child: RichText(
                //                   maxLines: 5,
                //                   text: const TextSpan(
                //                       text: 'Address : ',
                //                       style: TextStyle(
                //                           fontWeight: FontWeight.bold,
                //                           color: Colors.white),
                //                       children: [
                //                         TextSpan(
                //                           text: 'Sample Adddress',
                //                           style: TextStyle(
                //                               fontWeight: FontWeight.normal,
                //                               color: Colors.white),
                //                         )
                //                       ]),
                //                 ),
                //               ),
                //               RichText(
                //                 text: const TextSpan(
                //                     text: 'Block : ',
                //                     style: TextStyle(
                //                         fontWeight: FontWeight.bold,
                //                         color: Colors.white),
                //                     children: [
                //                       TextSpan(
                //                         text: '5A',
                //                         style: TextStyle(
                //                             fontWeight: FontWeight.normal,
                //                             color: Colors.white),
                //                       )
                //                     ]),
                //               ),
                //             ],
                //           ),
                //           const Spacer(),
                //           Column(
                //             children: const [
                //               Padding(
                //                 padding: EdgeInsets.all(8.0),
                //                 child: Icon(
                //                   Icons.calendar_today,
                //                   size: 30,
                //                   color: Colors.white,
                //                 ),
                //               ),
                //               Text(
                //                 '20/10/2021',
                //                 style: TextStyle(
                //                     color: Colors.white, fontSize: 16),
                //               ),
                //               Text(
                //                 '28/10/2021',
                //                 style: TextStyle(
                //                     color: Colors.white, fontSize: 16),
                //               ),
                //               Text(
                //                 'Duration : 5 days',
                //                 style: TextStyle(
                //                     color: Colors.white, fontSize: 16),
                //               ),
                //             ],
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
