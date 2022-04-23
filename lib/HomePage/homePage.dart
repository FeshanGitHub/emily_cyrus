import 'package:emily_cyrus/Controllers/homeController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils/Colors/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var selectedBox = 'Home';

  double x = 0.0;
  double y = 0.0;

  var scaling = 1.0;

  bool isDragging = false;
  @override
  Widget build(BuildContext context) {

    Get.find<HomeController>().getitemList();

    var height =  MediaQuery.of(context).size.height;

    var width =  MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            builDrawer(),
            AnimatedContainer(
              height: Get.height,
              color: Colors.grey,
              transform: Matrix4.translationValues(x ,y, 0)..scale(scaling),
              duration: Duration(milliseconds: 400),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    x = 0.0;
                    y = 0.0;
                    scaling = 1.0;
                  });
                },

                onHorizontalDragStart: (detail)=>
                isDragging = true
                ,
                onHorizontalDragUpdate: (details){
                  const delta = 1;

                  if(details.delta.dx > delta){
                    setState(() {
                      x = 180;
                      y = 50.0;

                      scaling = 0.8;
                    });
                  }else if(details.delta.dx < -delta){
                    setState(() {
                      x = 0.0;
                      y = -.0;

                      scaling = 1.0;
                    });

                  }
                },

                child: Scaffold(
                  bottomNavigationBar:
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildInkWell('Home','asset/home.png'),
                        buildInkWell('Packages','asset/packages.png'),
                        buildInkWell('Booking','asset/booking.png'),
                        buildInkWell('Profile','asset/profile.png'),

                      ],
                    ),
                  ),
                  appBar: AppBar(
                    elevation: 0,

                    actions: [
                      InkWell(
                          onTap: (){

                            setState(() {
                              x = 180;
                              y = 50;

                              scaling = 0.8;
                            });

                          },
                          child: Image.asset("asset/menuicon.png")
                      )
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 25.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: emwhite,
                                  radius:30,
                                  backgroundImage: AssetImage('asset/homegirl.png'),
                                ),

                                SizedBox(width: 10,),

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Welcome',style: TextStyle(
                                        color: emgrey,fontWeight: FontWeight.w700,
                                        fontSize: 16
                                    ),),

                                    Text('Emily Cyrus',style: TextStyle(
                                        color: empink,fontWeight: FontWeight.w700,
                                        fontSize: 20
                                    ),)

                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 300,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 25.0),
                                    child: Container(
                                      width: width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: emlpink,
                                      ),
                                      height: 200,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 100,
                                  left: 50,
                                  child: Container(
                                    width: 150,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Nanny and Babysitting Services',
                                          style: TextStyle(
                                              color: empurple,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: empurple,
                                              borderRadius: BorderRadius.circular(30)
                                          ),
                                          child: Padding(
                                            padding:  EdgeInsets.symmetric(vertical: 5.0,horizontal: 15),
                                            child: Text('Book Now',style: TextStyle(fontSize: 12,color: emwhite),),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  right: -5,
                                  child: ClipRRect(
                                      child: Container(
                                        // height: height*0.4,
                                        //   width: width*0.55,
                                          width: 180,
                                          height: 300,
                                          child: Image.asset('asset/girl.png',fit: BoxFit.fill,))
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text('Your Current Booking',style: TextStyle(
                                color: empurple,fontSize: 20,fontWeight: FontWeight.w700
                            ),),
                          ),

                          GetBuilder<HomeController>(builder: (allPackages){

                            return  allPackages.loading ? Center(child: CircularProgressIndicator(
                              color: empink,
                            ),) :buildBookingCard(width,allPackages.Booking);
                          }),



                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text('Packages',style: TextStyle(
                                color: empurple,fontSize: 20,fontWeight: FontWeight.w700
                            ),),
                          ),

                          SizedBox(height: 10,),

                          GetBuilder<HomeController>(builder: (allPackages){
                            print(allPackages.itemList);
                            return  ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: allPackages.itemList.length,
                                itemBuilder: (context, index) {
                                  return allPackages.loading ? Center(child: CircularProgressIndicator(
                                    color: empink,
                                  ),) :buildPackagesCard(index,allPackages.itemList);
                                }
                            );
                          }),



                          SizedBox(height: 50,),
                        ]
                    ),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  InkWell buildInkWell(title,icon) {
    return InkWell(
        onTap: (){
          setState(() {
            selectedBox = title;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(icon,color: selectedBox == title ? empink :Colors.grey,),
            Text(title,style: TextStyle(color:  selectedBox == title ? empink :Colors.grey),),
            Visibility(
                visible: selectedBox == title ? true : false,
                child: Image.asset('asset/circle.png'))
          ],
        ));
  }

  Container buildBookingCard(double width,booking) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(booking['package_label'],style: TextStyle(
                  color: empink,fontSize: 20,fontWeight: FontWeight.w700
              ),),
              Container(
                decoration: BoxDecoration(
                    color: empink,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(vertical: 6.0,horizontal: 35),
                  child: Text('Start',style: TextStyle(fontSize: 14,color: emwhite),),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildDateColunm('From',booking['from_date'],booking['from_time']),
              SizedBox(width: width*0.15,),
              buildDateColunm('To',booking['to_date'],booking['to_time']),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildRatingButtons('Rate Us',CupertinoIcons.star,),
              buildRatingButtons('Geolocation',CupertinoIcons.placemark,),
              buildRatingButtons('Survillence',CupertinoIcons.mic,),

            ],
          )

        ],
      ),
    );
  }

  Container buildPackagesCard(index,packageList) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 25,vertical: 18),

      decoration: BoxDecoration(
          color: emlpink,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: 30,height: 30,
                  child: ClipRRect(child: Image.asset('asset/calender.png',fit: BoxFit.fill,))),
              Container(
                decoration: BoxDecoration(
                    color: empink,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal: 25),
                  child: Text('Book Now',style: TextStyle(fontSize: 14,color: emwhite),),
                ),
              )
            ],
          ),

          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(packageList[index]['package_name'],style: TextStyle(
                  color: empurple,fontSize: 20,fontWeight: FontWeight.w700
              ),),
              Text('₹ ${packageList[index]['price']}',style: TextStyle(
                  color: empurple,fontSize: 20,fontWeight: FontWeight.w700
              ),),
            ],
          ),
          SizedBox(height: 10,),
          Text(
            packageList[index]['description']
            ,style: TextStyle(
            fontSize: 12,
          ),),

        ],
      ),
    );
  }

  Container buildRatingButtons(String name, IconData icon) {
    return Container(
      decoration: BoxDecoration(
          color: empurple,
          borderRadius: BorderRadius.circular(30)
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 7.0,horizontal: 15),
        child: Row(
          children: [
            Icon(icon,color: emwhite,size: 11,),
            SizedBox(width: 5,),
            Text(name,style: TextStyle(fontSize: 11,color: emwhite,fontWeight: FontWeight.w500),),

          ],
        ),
      ),
    );
  }

  Row buildDateColunm(String type,String date,String time) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15,),
            Text(type),
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(CupertinoIcons.calendar,color: empink,),
                SizedBox(width: 8,),
                Text(date,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500))
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(CupertinoIcons.clock,color: empink,),
                SizedBox(width: 8,),
                Text(time,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)
              ],
            ),

          ],
        )
      ],
    );
  }

  SingleChildScrollView builDrawer() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 30),
        width: Get.width,
        color: emwhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                CircleAvatar(

                  radius:30,
                  backgroundImage: AssetImage('asset/homegirl.png'),
                ),
                Text('Emily Cyrus',style: TextStyle(
                    color: empink,fontWeight: FontWeight.w700,
                    fontSize: 20
                ),)

              ],
            ),
            SizedBox(height: 30,),
            Text('Home',style: TextStyle(
                color: empurple,fontWeight: FontWeight.w500,
                fontSize: 18
            ),),
            Divider(color: empink,height: 20,),
            Text('Book A Nanny',style: TextStyle(
                color: empurple,fontWeight: FontWeight.w500,
                fontSize: 18
            ),),
            Divider(color: empink,height: 20,),
            Text('How It Works',style: TextStyle(
                color: empurple,fontWeight: FontWeight.w500,
                fontSize: 18
            ),),
            Divider(color: empink,height: 20,),
            Text('Why Nanny Vanny',style: TextStyle(
                color: empurple,fontWeight: FontWeight.w500,
                fontSize: 18
            ),),
            Divider(color: empink,height: 20,),
            Text('My Bookings',style: TextStyle(
                color: empurple,fontWeight: FontWeight.w500,
                fontSize: 18
            ),),
            Divider(color: empink,height: 20,),
            Text('My Profile',style: TextStyle(
                color: empurple,fontWeight: FontWeight.w500,
                fontSize: 18
            ),),
            Divider(color: empink,height: 20,),
            Text('My Support',style: TextStyle(
                color: empurple,fontWeight: FontWeight.w500,
                fontSize: 18
            ),),
            Divider(color: empink,height: 20,),
          ],
        ),
      ),
    );
  }
}
