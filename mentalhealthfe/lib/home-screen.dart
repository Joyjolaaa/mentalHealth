// ignore_for_file: file_names, unnecessary_null_comparison

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController complexProjectController = TextEditingController();
  TextEditingController projectWithRiskController = TextEditingController();
  TextEditingController associatedCostController = TextEditingController();
  TextEditingController projectDurationController = TextEditingController();
  TextEditingController customerInvolvementController = TextEditingController();
  TextEditingController implementationStageController = TextEditingController();
  TextEditingController requirementGatheringController =
      TextEditingController();
  TextEditingController maintainabilityController = TextEditingController();
  TextEditingController errorDiscoveryController = TextEditingController();
  TextEditingController flexibilityController = TextEditingController();

  List<String> predictionResults = [];
  List<double> ratingValues = [
    3.0,
    3.0,
    3.0,
    3.0,
    3.0,
    3.0,
    3.0,
    3.0,
    3.0,
    3.0
  ];

  final Map<double, String> ratingTextMap = {
    1.0: 'Very Poor',
    2.0: 'Poor',
    3.0: 'Average',
    4.0: 'Good',
    5.0: 'Excellent',
  };

  Future<void> submitForm() async {
    const apiUrl = 'http://127.0.0.1:8000/rnnprediction/predict/';

    // final inputMap = {
    //   'ComplexProject': double.parse(complexProjectController.text),
    //   'ProjectwithRisk': double.parse(projectWithRiskController.text),
    //   'AssociatedCostController': double.parse(associatedCostController.text),
    //   'ProjectDurationController': double.parse(projectDurationController.text),
    //   'CustomerInvolvementController':
    //       double.parse(customerInvolvementController.text),
    //   'ImplementationStageController':
    //       double.parse(implementationStageController.text),
    //   'RequirementGatheringController':
    //       double.parse(requirementGatheringController.text),
    //   'MaintainabilityController': double.parse(maintainabilityController.text),
    //   'ErrorDiscoveryController': double.parse(errorDiscoveryController.text),
    //   'FlexibilityController': double.parse(flexibilityController.text),
    //   // ... add other input fields
    // };

    final inputMap = {
      'ComplexProject': ratingValues[0],
      'ProjectwithRisk': ratingValues[1],
      'AssociatedCostController': ratingValues[2],
      'ProjectDurationController': ratingValues[3],
      'CustomerInvolvementController': ratingValues[4],
      'ImplementationStageController': ratingValues[5],
      'RequirementGatheringController': ratingValues[6],
      'MaintainabilityController': ratingValues[7],
      'ErrorDiscoveryController': ratingValues[8],
      'FlexibilityController': ratingValues[9],
      // ... add other input fields
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'input_data': [inputMap]
      }),
    );

    if (response.statusCode == 200) {
      // Process response and show predictions
      final responseJson = jsonDecode(response.body);
      print('Response JSON: $responseJson'); // Print the response JSON

      final predictions = responseJson['predictions'];
      print('Predictions: $predictions'); // Print the predictions

      // Update the state to display predictions
      setState(() {
        predictionResults =
            predictions.cast<String>(); // Explicitly cast to List<String>
      });
    } else {
      // Handle error
      print('API request failed with status ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SDLC HOME',
          style: TextStyle(
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.bold,
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const Text(
                  'Please rate the following aspects of your project (1-5, 1 = Very Poor, 5 = Excellent):',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                SliderFormField(
                  label: 'Complex Project',
                  onChanged: (value) {
                    setState(() {
                      ratingValues[0] = value;
                    });
                  },
                  value: ratingValues[0],
                ),
                Text(
                  ratingTextMap[ratingValues[0]] ?? 'Unknown',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                SliderFormField(
                  label: 'Project with Risk',
                  onChanged: (value) {
                    setState(() {
                      ratingValues[1] = value;
                    });
                  },
                  value: ratingValues[1],
                ),
                Text(
                  ratingTextMap[ratingValues[1]] ?? 'Unknown',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                SliderFormField(
                  label: 'Associated Cost',
                  onChanged: (value) {
                    setState(() {
                      ratingValues[2] = value;
                    });
                  },
                  value: ratingValues[2],
                ),
                Text(
                  ratingTextMap[ratingValues[2]] ?? 'Unknown',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                SliderFormField(
                  label: 'Project Duration',
                  onChanged: (value) {
                    setState(() {
                      ratingValues[3] = value;
                    });
                  },
                  value: ratingValues[3],
                ),
                Text(
                  ratingTextMap[ratingValues[3]] ?? 'Unknown',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                SliderFormField(
                  label: 'Customer Involvement',
                  onChanged: (value) {
                    setState(() {
                      ratingValues[4] = value;
                    });
                  },
                  value: ratingValues[4],
                ),
                Text(
                  ratingTextMap[ratingValues[4]] ?? 'Unknown',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                SliderFormField(
                  label: 'Implementation Stage',
                  onChanged: (value) {
                    setState(() {
                      ratingValues[5] = value;
                    });
                  },
                  value: ratingValues[5],
                ),
                Text(
                  ratingTextMap[ratingValues[5]] ?? 'Unknown',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                SliderFormField(
                  label: 'Requirement Gathering',
                  onChanged: (value) {
                    setState(() {
                      ratingValues[6] = value;
                    });
                  },
                  value: ratingValues[6],
                ),
                Text(
                  ratingTextMap[ratingValues[6]] ?? 'Unknown',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                SliderFormField(
                  label: 'Maintainability',
                  onChanged: (value) {
                    setState(() {
                      ratingValues[7] = value;
                    });
                  },
                  value: ratingValues[7],
                ),
                Text(
                  ratingTextMap[ratingValues[7]] ?? 'Unknown',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                SliderFormField(
                  label: 'Error Discovery',
                  onChanged: (value) {
                    setState(() {
                      ratingValues[8] = value;
                    });
                  },
                  value: ratingValues[8],
                ),
                Text(
                  ratingTextMap[ratingValues[8]] ?? 'Unknown',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                SliderFormField(
                  label: 'Flexibility',
                  onChanged: (value) {
                    setState(() {
                      ratingValues[9] = value;
                    });
                  },
                  value: ratingValues[9],
                ),
                Text(
                  ratingTextMap[ratingValues[9]] ?? 'Unknown',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: submitForm,
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(200, 50), // Adjust the width and height as needed
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                        fontSize: 20), // Adjust the font size as needed
                  ),
                ),
                if (predictionResults != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Prediction Results:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      for (final result in predictionResults)
                        Text(
                          result,
                          style: const TextStyle(
                              fontSize: 36, fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SliderFormField extends StatelessWidget {
  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  SliderFormField({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Slider(
          value: value,
          onChanged: onChanged,
          min: 1.0,
          max: 5.0,
          divisions: 4, // You can adjust this for more or fewer steps
          label: value.toString(),
        ),
      ],
    );
  }
}
