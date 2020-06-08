import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  int _currentPowerSource = 1;
  int _currentGeyserStatus = 0;
  double _currentWaterTemperature = 37.0;
  int _currentStepperMotorPosition = 0;
  String _selectedVehicle = "OFF";
  final List<String> _knobPositions = [
    "OFF",
    "PILOT",
    "WARM",
    "HOT",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
            stream: _database.reference().child("App").child("1").onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<dynamic, dynamic> object = {};
                snapshot.data.snapshot.value
                    .forEach((dynamic key, dynamic data) {
                  object[key] = data.toString();
                });

                _currentWaterTemperature =
                    double.parse(object["current_water_temperature"]);
                _currentStepperMotorPosition =
                    int.parse(object["current_knob_position"]);
                _currentPowerSource = int.parse(object["power_source"]);
                if (_currentStepperMotorPosition == 0) {
                  _currentGeyserStatus = 0;
                } else {
                  _currentGeyserStatus = 1;
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }

              return Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 40),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Welcome, ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                              TextSpan(
                                text: "Ali!",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          color: _currentGeyserStatus == 0
                              ? Colors.red
                              : Colors.green,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                "Geyser Status",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            _currentGeyserStatus == 0
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      "OFF",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      "ON",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          color: _currentPowerSource == 0
                              ? Theme.of(context).primaryColor
                              : Colors.cyan,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                "Power Source",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            _currentPowerSource == 0
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      "GAS",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      "ELECTRICITY",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: MediaQuery.of(context).size.height * 0.1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.width * 0.43,
                            width: MediaQuery.of(context).size.width * 0.43,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Current Water Temperature",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "$_currentWaterTemperature\xB0 C",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.width * 0.43,
                            width: MediaQuery.of(context).size.width * 0.43,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Knob Position of Geyser",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "${getKnobPositionName(_currentStepperMotorPosition)}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(14),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.07,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Change the knob to:",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                dropdownColor: Theme.of(context).primaryColor,
                                value: _selectedVehicle,
                                onChanged: (String val) {
                                  setState(() {
                                    _selectedVehicle = val;
                                  });
                                  _database
                                      .reference()
                                      .child("App")
                                      .child("1")
                                      .update({
                                    "instruction_for_motor":
                                        getKnobPosition(_selectedVehicle),
                                  });
                                  Navigator.pop(context);
                                },
                                items: _knobPositions.map((String veh) {
                                  return DropdownMenuItem(
                                    value: veh,
                                    child: Text(
                                      "$veh",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  int getKnobPosition(stringPos) {
    if (stringPos == "OFF") {
      return 0;
    } else if (stringPos == "PILOT") {
      return 1;
    } else if (stringPos == "WARM") {
      return 2;
    } else if (stringPos == "HOT") {
      return 3;
    } else {
      return -1;
    }
  }

  String getKnobPositionName(intPos) {
    if (intPos == 0) {
      return "OFF";
    } else if (intPos == 1) {
      return "PILOT";
    } else if (intPos == 2) {
      return "WARM";
    } else if (intPos == 3) {
      return "HOT";
    } else {
      return "N.A";
    }
  }
}
