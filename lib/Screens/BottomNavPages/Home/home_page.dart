import 'package:flutter/material.dart';
import 'package:poll_2022/Styles/Colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:SafeArea(
       child: CustomScrollView(
         slivers: [
           SliverToBoxAdapter(
             child: Container(
               padding: const EdgeInsets.all(20),
               child: Column(
                 children: [
                   ...List.generate(3, (index) {
                     return Container(
                       margin: const EdgeInsets.only(bottom: 10),
                       padding: const EdgeInsets.all(8),
                       decoration: BoxDecoration(
                         border: Border.all(color: AppColors.grey),
                           borderRadius: BorderRadius.circular(10),
                       ),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           ListTile(
                             contentPadding: const EdgeInsets.all(0),
                             leading: const CircleAvatar(),
                             title: const Text("ashen malindu"),
                             trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.share)),
                           ),
                           const Text("my question"),
                           const SizedBox(height: 8),
                           ...List.generate(2, (index) {
                             return Container(
                               margin: const EdgeInsets.only(bottom: 5),
                               child: Row(
                                 children:  [
                                   Expanded(child: Stack(
                                     children: [
                                       const LinearProgressIndicator(
                                         minHeight: 30,
                                         value: 55/100,
                                         backgroundColor: Colors.red,
                                       ),
                                       Container(
                                         alignment: Alignment.centerLeft,
                                         padding: const EdgeInsets.symmetric(horizontal: 10),
                                         height: 30,
                                         child: const Text("options"),
                                       ),
                                     ],
                                   ),),
                                   const SizedBox(width: 20),
                                   const Text("5%"),
                                 ],
                               ),
                             );
                           }),
                           const Text("Total Votes:7"),
                         ],
                       ),
                     );
                   }
                   ),
                 ],
               ),
             ),
           ),
         ],
       ),
     ),
    );
  }
}
