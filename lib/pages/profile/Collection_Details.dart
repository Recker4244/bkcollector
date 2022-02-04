import 'package:gold247/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gold247/models/collectionList.dart';
import 'package:gold247/models/referral.dart';
import 'package:gold247/models/subPlan.dart';
import 'package:gold247/models/subscription.dart';
import 'package:gold247/language/locale.dart';
import 'package:gold247/models/user.dart';
import 'package:gold247/pages/portfolio/Collections.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gold247/models/customSub.dart';
import 'package:gold247/models/standardSub.dart';
import 'package:sizer/sizer.dart';
import 'package:page_transition/page_transition.dart';

class Collectiondetails extends StatefulWidget {
  collectionList installment;
  String userid;
  Collectiondetails({this.installment, this.userid});
  @override
  CollectiondetailsState createState() => CollectiondetailsState();
}

class CollectiondetailsState extends State<Collectiondetails> {
  Future<bool> init;

  List<standardSub> temp = [];
  fetchsubscription(String user, String id) async {
    var request = http.Request(
        'GET', Uri.parse('${baseurl}/api/subscription/user/${user}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = json.decode(await response.stream.bytesToString());
      Map det = responseString;

      List dat = det['data'];
      Iterable l = det['data'];
      temp =
          List<standardSub>.from(l.map((model) => standardSub.fromJson(model)));
      for (int j = 0; j < dat.length; j++) {
        if (dat[j]['plan'] == null) {
          customSub sub = customSub.fromJson(dat[j]);
          if (sub.installments.map((item) => item.id).contains(id))
            return Custom(sub);
        } else {
          standardSub sub = standardSub.fromJson(dat[j]);
          if (sub.installments.map((item) => item.id).contains(id)) {
            return Standard(sub);
          }
        }
      }
      //print(subs);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<bool> initialise() async {
    await fetchsubscription(widget.userid, widget.installment.id);
    print("temp=$temp");
    return true;
  }

  @override
  void initState() {
    init = initialise();
    super.initState();
  }

  TextEditingController otp = TextEditingController();
  changeStatus(String id, String status) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://13.59.57.74:5000/api/installmentId/changeAppoinmentStatus'));
    request.bodyFields = {'transaction_id': id, 'transaction_status': 'Saved'};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      await changeSub(temp[0].id);
    } else {
      print(response.reasonPhrase);
    }
  }

  changeSub(String id) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://13.59.57.74:5000/api/installmentId/changeAppoinmentStatus'));
    request.bodyFields = {
      'subscription_id': id,
      'subscription_status': 'Running'
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.size,
              alignment: Alignment.bottomCenter,
              child: Collections()));
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                backgroundColor: scaffoldBgColor,
                title: Center(
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.check,
                      size: 30.0,
                      color: scaffoldBgColor,
                    ),
                  ),
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Center(
                          child: Text(
                        "Verified",
                        style: black18BoldTextStyle,
                      )),
                      // Center(
                      //     child: Text(
                      //   '${DateTime.now()}',
                      //   style: black14MediumTextStyle,
                      // )),
                      heightSpace,
                    ],
                  ),
                ),
              ));
    } else {
      print(response.reasonPhrase);
    }
  }

  void verify() {
    if (otp.text == widget.installment.otp) {
      changeStatus(widget.installment.id, "Saved");
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                backgroundColor: scaffoldBgColor,
                title: Center(
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.cancel,
                      size: 30.0,
                      color: scaffoldBgColor,
                    ),
                  ),
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Center(
                          child: Text(
                        "Failed to verify , check the OTP and try again",
                        style: black18BoldTextStyle,
                      )),
                      // Center(
                      //     child: Text(
                      //   '${DateTime.now()}',
                      //   style: black14MediumTextStyle,
                      // )),
                      heightSpace,
                    ],
                  ),
                ),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    MaterialStateProperty<Color> getColor(Color white, Color pressed) {
      final getColor = (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return pressed;
        } else
          return white;
      };
      return MaterialStateProperty.resolveWith(getColor);
    }

    var locale = AppLocalizations.of(context);
    box2() {
      return Container(
        decoration: BoxDecoration(
          color: scaffoldLightColor,
        ),
        // width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  locale.collectionDetails.toUpperCase(),
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Order ID:",
                      //locale.OrderID,
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "#${widget.installment.paymentId}",
                      //"#${widget.temp.id}",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Plan Enrolled on:",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${DateTime.parse(widget.installment.createdAt).toString()}",
                      //widget.temp.createdAt(),
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      locale.collectorPhoneNumber,
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${temp[0].user.mobile}",
                      //widget.temp.status().toUpperCase(),
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Collector:",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${temp[0].user.fname}",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      locale.ToCollect,
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "INR ${widget.installment.amount}",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              Wrap(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Landmark:",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${temp[0].user.addresses[0].landMark}",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Pincode:",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${temp[0].user.addresses[0].pin}",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(fixPadding * 2),
                    child: Theme(
                      data: ThemeData(
                        errorColor: primaryColor,
                        primaryColor: whiteColor,
                        textSelectionTheme: TextSelectionThemeData(
                          cursorColor: primaryColor,
                        ),
                      ),
                      child: TextFormField(
                        controller: otp,
                        onChanged: (value) {
                          print(value);
                        },
                        textAlign: TextAlign.center,
                        cursorColor: primaryColor,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        style: primaryColor18BoldTextStyle,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                            borderSide:
                                BorderSide(color: primaryColor, width: 1),
                          ),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                            borderSide:
                                BorderSide(color: primaryColor, width: 1),
                          ),
                          fillColor: whiteColor,
                          labelText: "Enter Verification OTP",
                          labelStyle: primaryColor16MediumTextStyle,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryColor, width: 0.7),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 2.h,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(fixPadding * 2),
                    child: ElevatedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text(
                                "verify to confirm",
                                style: TextStyle(
                                  fontFamily: 'Jost',
                                  fontSize: 18.0.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                            foregroundColor: getColor(whiteColor, primaryColor),
                            backgroundColor:
                                getColor(primaryColor, whiteColor)),
                        onPressed: () async {
                          String otpfromlist =
                              temp[0].installments[0].otp.toString();
                          if (otp.text == otpfromlist)
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("otp verified"),
                            ));
                          //await getUser("s", "s");
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Appointments()));
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }

    box3() {
      return Container(
        decoration: BoxDecoration(
          color: scaffoldLightColor,
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Mode of Payment",
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Collect from Your Location",
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return FutureBuilder(
      future: init,
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.connectionState == ConnectionState.waiting) {
          return SafeArea(
            child: Scaffold(
                backgroundColor: scaffoldBgColor,
                body: Center(
                    child: CircularProgressIndicator(
                  color: primaryColor,
                ))),
          );
        } else {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: scaffoldLightColor,
              appBar: AppBar(
                foregroundColor: primaryColor,
                backgroundColor: scaffoldLightColor,
                titleSpacing: 0.0,
                elevation: 0.0,
                title: Text(
                  locale.collectionDetails,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                  ),
                ),
              ),
              bottomNavigationBar: Visibility(
                visible: widget.installment.status == "Processing",
                child: InkWell(
                  child: Container(
                    height: 8.h,
                    // width: double.infinity,
                    padding: EdgeInsets.all(fixPadding * 1.7),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      color: primaryColor,
                    ),
                    child: Text(
                      "Verify to confirm",
                      style: white18MediumTextStyle,
                    ),
                  ),
                  onTap: () {
                    verify();
                  },
                ),
              ),
              body: ListView(
                children: [
                  box2(),
                  widget.installment.status == "Processing"
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Theme(
                            data: ThemeData(
                              primaryColor: whiteColor,
                              textSelectionTheme: TextSelectionThemeData(
                                cursorColor: primaryColor,
                              ),
                            ),
                            child: TextField(
                              controller: otp,
                              keyboardType: TextInputType.emailAddress,
                              style: primaryColor16BoldTextStyle,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 1),
                                ),
                                labelText: 'Enter Verification OTP details',
                                labelStyle: primaryColor16BoldTextStyle,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                  borderSide:
                                      BorderSide(color: primaryColor, width: 1),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            );
          } else {
            return errorScreen;
          }
        }
      },
    );
  }

  Widget box1() {
    return Container(
      decoration: BoxDecoration(
        color: scaffoldLightColor,
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/crypto_icon/gold_ingots.png'),
            Container(
              height: 20,
            ),
            Text(
              "",
              // widget.name.toUpperCase(),
              style: TextStyle(
                color: primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
