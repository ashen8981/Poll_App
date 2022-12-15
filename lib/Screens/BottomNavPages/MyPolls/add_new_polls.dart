import 'package:flutter/material.dart';
import 'package:poll_2022/Providers/db_provider.dart';
import 'package:provider/provider.dart';
import '../../../Styles/Colors.dart';
import '../../../Utils/message.dart';

class AddPollPage extends StatefulWidget {
  const AddPollPage({Key? key}) : super(key: key);

  @override
  State<AddPollPage> createState() => _AddPollPageState();
}

class _AddPollPageState extends State<AddPollPage> {
  TextEditingController question = TextEditingController();
  TextEditingController option1 = TextEditingController();
  TextEditingController option2 = TextEditingController();
  TextEditingController duration = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Poll"),),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                  child: Column(
                    children: [
                      formWidget(question, label: "Question"),
                      formWidget(option1, label: "Option 1"),
                      formWidget(option2, label: "Option 2"),
                      formWidget(duration, label: "Duration",onTap: () {
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.utc(2027))
                            .then((value) {
                          if (value == null) {
                            duration.clear();
                          } else {
                            duration.text = value.toString();
                          }
                        });
                      }),

                       Consumer<DbProvider>(builder: (context, db, child) {
                         WidgetsBinding.instance.addPostFrameCallback(
                               (_){
                           if(db.message !=""){
                             if(db.message.contains("Poll Created")){
                               success(context, message: db.message);
                               db.clear();
                             }else{
                               error(context, message: db.message);
                               db.clear();
                             }
                           }
                           },
                         );
                           return GestureDetector(
                                 onTap:  db.status == true
                                     ? null
                                     :(){
                                  if(_formKey.currentState!.validate()){
                                    List<Map> options =[{
                                      "answer": option1.text.trim(),
                                      "percent": 0,
                                    },{
                                      "answer": option2.text.trim(),
                                      "percent": 0},
                                    ];
                                    db.addPoll(
                                        question: question.text.trim(),
                                        duration: duration.text.trim(),
                                        options: options);
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width-100,
                                  decoration: BoxDecoration(
                                      color: db.status == true
                                          ? AppColors.grey
                                          : AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  alignment: Alignment.center,
                                  child: Text(db.status == true ? "please wait..":"post poll"),
                                ),
                              );
                         }
                       ),
                ]
                  ),
              ),
            ),
          ),
        ],
    ),
    );
  }
  Widget formWidget (TextEditingController controller,
      {String? label, VoidCallback? onTap}){
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        onTap: onTap,
        readOnly: onTap == null ? false : true,
        controller: controller,
        validator: (value){
          if (value!.isEmpty) {
            return "input is required";
          }
          return null;
        },
        decoration: InputDecoration(
            errorBorder:const OutlineInputBorder(),
            labelText:label!,
            border:const OutlineInputBorder()
        ),
      ),
    );
  }
}
