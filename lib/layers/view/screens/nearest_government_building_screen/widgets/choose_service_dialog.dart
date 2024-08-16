import 'package:al_dalel/core/constants.dart';
import 'package:al_dalel/layers/view/widgets/custom_container.dart';
import 'package:flutter/material.dart';

import '../../../../../core/configuration/styles.dart';

class ChooseServiceDialog extends StatefulWidget {
  const ChooseServiceDialog({super.key});

  @override
  State<ChooseServiceDialog> createState() => _ChooseServiceDialogState();
}

class _ChooseServiceDialogState extends State<ChooseServiceDialog> {
  String? selectedService;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey.shade300,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "إختر الخدمة",
            style: TextStyle(
                color: Styles.colorPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
              height: 130,
              child: GridView.builder(
                itemCount: Constants.government_services.length,
                physics: const ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    mainAxisExtent: 50.0),
                itemBuilder: (context, index) {
                  final service = Constants.government_services[index];
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedService = service;
                          });
                        },
                        child: Card(
                          child: Center(
                            child: Text(
                              service,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Visibility(
                          visible: selectedService == service,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.green),
                            child: Center(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                child: Text(
                  "تأكيد",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: () => Navigator.of(context).pop(selectedService),
              ),
              TextButton(
                child: Text(
                  "إلغاء",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          )
        ],
      ),
    );
  }
}
