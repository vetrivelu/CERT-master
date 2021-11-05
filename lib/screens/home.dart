import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pert/constants/colors.dart';
import 'package:pert/screens/anouncement.dart';
import 'package:pert/screens/contacthistory.dart';
import 'package:pert/screens/covidstatus.dart';
import 'package:pert/screens/profile.dart';
import 'package:pert/screens/quarantine.dart';
import 'package:pert/screens/tabbar.dart';
import 'package:pert/screens/whistleblower.dart';
import 'package:pert/widgets/carouseltile.dart';



//


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> list = [1, 2, 3, 4, 5];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.exit_to_app,color: Color(0xFFEF4C43),),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.notifications,
              color: Color(0xFFED392D),
              size: 30,
            ),
          )
        ],
        title: Center(
          child: Container(
            // padding: EdgeInsets.only(left: 30),
            height: 50,
            child: Image.asset('assets/studentloginpage/iukl_logo.png',fit: BoxFit.fitHeight,),
          ),
        ),

      ),
      // backgroundColor: kprimaryColor,
      body:Padding(
        padding: const EdgeInsets.all(8),
        child:Column(

          children: [
            // Container(
            //   color: bgcolor,
            //   height: MediaQuery.of(context).size.height * 0.10,
            //   child: Row(
            //     children: [
            //       Image.asset(
            //         'assets/studentloginpage/iukl_logo.png',
            //         fit: BoxFit.cover,
            //       ),
            //       const Spacer(),
            //       IconButton(
            //         onPressed: () {},
            //         icon: Icon(
            //           Icons.notifications,
            //           color: kprimaryColor,
            //           size: 35,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            CarouselSlider(

              options: CarouselOptions(
                height: 150,
                autoPlay:true,
                aspectRatio: 2,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ),
              items: imageSliders

              // imgList
              //     .map((item) => Material(
              //       elevation: 5,
              //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              //       child: Container(
              //         color: kprimaryColor,
              //
              //         height:MediaQuery.of(context).size.height * 0.18 ,
              //         width: MediaQuery.of(context).size.width*0.956,
              //
              //         child: Center(child: Image.network(item, fit: BoxFit.cover, width: 1000)),
              //
              //
              //       ),
              //     ))
              //     .toList(),
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: 546,
              child: GridView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: [
                  InkWell(
                    onTap: () => Get.to(()=>MyStatefulWidget()),
                    child: Tile(
                      title: 'Covid Status',
                      image: 'assets/studenthomepage/covidstatus.png',
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Contacthistory(),
                      ),
                    ),
                    child: Tile(
                      title: 'Contact History',
                      image: 'assets/studenthomepage/covidhistory.png',
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuarantinePage(),
                      ),
                    ),
                    child: Tile(
                      title: 'Quarantine',
                      image: 'assets/studenthomepage/quarantine.png',
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(()=>AnnouncmentWidget());
    },

                    child: Tile(
                      title: 'Whistle Blower',
                      image: 'assets/studenthomepage/whistleblower.png',
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AnnouncementPage(),
                      ),
                    ),
                    child: Tile(
                      title: 'Announcement',
                      image: 'assets/studenthomepage/announcement.png',
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Profile(),
                      ),
                    ),
                    child: Tile(
                      title: 'Profile',
                      image: 'assets/studenthomepage/profile.png',
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  String? title;
  String? image;
  Tile({Key? key, this.title, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 5,
        child: Container(
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: Colors.grey.shade100, borderRadius: BorderRadius.circular(18)),
          child: GridTile(
            footer: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset(


                image!,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
