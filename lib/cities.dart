import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Models/weather_model.dart';
import 'imageres.dart';

class Cities extends StatefulWidget {
  const Cities({super.key});

  @override
  State<Cities> createState() => _CitiesState();
}

class _CitiesState extends State<Cities> {
  late TextEditingController controller;
  String previousCity ="No City Searched";
  List<String> cityList = [
    "Kolkata",
    "Delhi",
    "Lucknow",
    "New Delhi",
    "Chennai",
    "Indore"
  ];

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  Widget searchTextField() {
    return TextField(
      keyboardType: TextInputType.text,
      controller: controller,
      // this is for decorating the text field
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10.h, 3.h, 0, 3),
          hintText: "where do you want to check?",
          hintStyle: TextStyle(
            fontSize: 17,
            color: Colors.grey.shade800,
            fontFamily: "SFT",
          ),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),

          ///this is the default border active when not focused
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),

          /// this is the focused border
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),

          ///this will be used when a text field in disabled
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent))),
      maxLines: 1,
      autocorrect: false,
      obscureText: false,
      style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: "SFT",
          fontSize: 20,
          color: Colors.black),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(shared_pref.cityName!=null)
    {
      setState(() {
        previousCity = shared_pref.cityName??"No city searched";
      });
    }
    final ScreenHeight = MediaQuery.of(context).size.height;
    final ScreenWidth = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
        designSize: Size(ScreenWidth, ScreenHeight),
        builder: (context, child) => Scaffold(
            backgroundColor: const Color(0xfffdf0d5),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: const Color(0xfffdf0d5),
              title: searchTextField(),
              leading: IconButton(
                onPressed: () {
                  if(controller.text.isNotEmpty)
                    {
                      final city = controller.text;
                      shared_pref.cityName=city;
                      Navigator.pushNamed(context, "/weather_det",arguments: ScreenArguments(city, 1));
                    }
                  },
                icon: Image.asset(ImageRes.submitIcon,height: 27.h,),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      controller.text = "";
                    });
                  },
                  child: Image.asset(
                    ImageRes.cancelIcon,
                    height: 25.h,
                  ),
                ),
                SizedBox(width: 16.w),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5.w),
                      child: const Text(
                        "Previously Searched City",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "SF",
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, "/weather_det",arguments: ScreenArguments(controller.text, 2));
                        },
                        child: Container(
                            padding: EdgeInsets.all(15.h),
                            margin: EdgeInsets.only(bottom: 10.h),
                            height: 60.h,
                            width: 350.w,
                            decoration: BoxDecoration(
                              color: const Color(0xffdda15e),
                              borderRadius: BorderRadius.circular(10.h),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Text(
                                 previousCity,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "SF",
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                                Image.asset(
                                  ImageRes.countryIcon,
                                  height: 30.h,
                                ),
                              ],
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5.w),
                      child: const Text(
                        "Popular Cities",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "SF",
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.h),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          String cityName = cityList[index];
                          return GestureDetector(
                            onTap: (){
                              shared_pref.cityName=cityName;
                              Navigator.pushNamed(context, "/weather_det",arguments: ScreenArguments(cityName, 1));
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10.h),
                              decoration: BoxDecoration(
                                color: const Color(0xffdda15e),
                                borderRadius: BorderRadius.circular(10.h),
                              ),
                              child: ListTile(
                                leading: Text(
                                  cityName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "SF",
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                                trailing: Image.asset(
                                  ImageRes.countryIcon,
                                  height: 30.h,
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: cityList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
class ScreenArguments {
  final String city;
  final int serviceNo;

  ScreenArguments(this.city, this.serviceNo);
}