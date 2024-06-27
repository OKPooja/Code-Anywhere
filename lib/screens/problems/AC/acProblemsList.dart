import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../models/problems.dart';
import '../../../utils/colors.dart';
import 'acProblemDesc.dart';
import 'fetchProblems.dart';

class ACProblemsList extends StatefulWidget {
  final String category;
  final List<Problem> problemsList;
  const ACProblemsList({super.key, required this.category, required this.problemsList});

  @override
  State<ACProblemsList> createState() => _ACProblemsListState();
}

class _ACProblemsListState extends State<ACProblemsList> {
  List<Problem> problemsList = [];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    problemsList = widget.problemsList;
  }

  Future<void> _refreshProblemsList() async {
    problemsList = await fetchProblems(tag: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 18,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          widget.category,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Colors.black,
        key: _refreshIndicatorKey,
        onRefresh: _refreshProblemsList,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4.w),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: problemsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Problem problem = problemsList[index];

                    return GestureDetector(
                      onTap: (){
                        Get.to(() => ACProblemDescription(problemName: problem.name, problemId: problem.id));
                      },
                      child: Card(
                        color: const Color(0xFFECF7FD),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${index + 1}. ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22.sp,
                                  fontFamily: 'PragatiNarrow',
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 3.w,),
                              Expanded(
                                child: Text(
                                  problem.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 22.sp,
                                    fontFamily: 'PragatiNarrow',
                                    color: AppColors.darkPurple,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // Row(
                              //   children: [
                              //     Icon(
                              //       problemsList[index]['solved']
                              //           ? Icons.check_circle
                              //           : Icons.circle,
                              //       color: problemsList[index]['solved']
                              //           ? Colors.green
                              //           : Colors.transparent,
                              //     ),
                              //     GestureDetector(
                              //       onTap: () async {
                              //         var result = await api.markBookmarked(problemsList[index]['problem_name']);
                              //         if(result['status'] == 'success'){
                              //           showCustomToast(context: context, message: "Bookmarked status updated successfully");
                              //         }
                              //         setState(() {
                              //           problemsList[index]['bookmarked'] = !problemsList[index]['bookmarked'];
                              //         });
                              //       },
                              //       child: Icon(
                              //         problemsList[index]['bookmarked']
                              //             ? Icons.bookmark
                              //             : Icons.bookmark_border,
                              //         color: problemsList[index]['bookmarked']
                              //             ? Colors.black87
                              //             : Colors.black87,
                              //       ),
                              //     )
                              //   ],
                              // )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
