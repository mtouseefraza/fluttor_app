import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:fluttor_app/widget/commonAppBar.dart';
import 'package:fluttor_app/widget/commonDrawer.dart';
import 'package:fluttor_app/services/api_client.dart';


class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}
class _UsersScreenState extends State<UsersScreen> {
  int count  =0;
  final ApiClient _apiClient = ApiClient();
  final int _pageSize = 5;
  final PagingController<int, dynamic> _pagingController =
  PagingController(firstPageKey: 0);

  Future<void> _fetchPage(int pageKey) async {
    try {

      var data = {"pageNumber" : pageKey,"limit":_pageSize,"Sort":"_id","SortBy":"DESC"};
      final result = await _apiClient.postRequest('api/user/list', data);
      var newItems = result?['data']?['data'] ?? [];

      final isLastPage = newItems!.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    }
    // Handle error in catch
    catch (error) {
      print(_pagingController.error);
      // Sets the error in controller
      _pagingController.error = error;
    }
  }


  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    //_fetchPage(pageKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:  CommonAppBar(),
      drawer: CommonDrawer(),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
                () =>  _pagingController.refresh(),
        ),
        child:PagedListView<int, dynamic>.separated(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<dynamic>(
            //animateTransitions: true,
            itemBuilder: (_, item, index) => Container(
              height: size.height * .2,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: (index%2 == 0) ? Colors.lightBlue[50]: Colors.white,
              ),
              child: Column(
                children : [
                  Row(
                    children :[
                       Icon(Icons.people,color:Colors.blue),
                       SizedBox(width: 5),
                       Text("Name:" , style:TextStyle(color:Colors.blue)),
                       SizedBox(width: 10 ),
                       Text(item["Name"]),
                     ]
                  ),
                  Row(
                      children :[
                        Icon(Icons.people,color:Colors.blue),
                        SizedBox(width: 5),
                        Text("Mobile:" , style:TextStyle(color:Colors.blue)),
                        SizedBox(width: 10 ),
                        Text('${item["Mobile"]}'),
                      ]
                  ),
                  Row(
                      children :[
                        Icon(Icons.people,color:Colors.blue),
                        SizedBox(width: 5),
                        Text("Email:" , style:TextStyle(color:Colors.blue)),
                        SizedBox(width: 10 ),
                        Text('${item["Email"]}'),
                      ]
                  ),
                  Row(
                      children :[
                        Icon(Icons.people,color:Colors.blue),
                        SizedBox(width: 5),
                        Text("Create Date:" , style:TextStyle(color:Colors.blue)),
                        SizedBox(width: 10 ),
                        Text('${item["Create_Date"]}'),
                      ]
                  ),
                  Row(
                      children :[
                        Icon(Icons.people,color:Colors.blue),
                        SizedBox(width: 5),
                        Text("Update Date:" , style:TextStyle(color:Colors.blue)),
                        SizedBox(width: 10 ),
                        Text('${item["Update_Date"]}'),
                      ]
                  ),
                ]
              )
            ),

            /*Container(
              height: size.height * .2,
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (index%2 == 0) ? Colors.lightBlue[50]: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.book,color: Colors.blue,size: 20,),
                      Text(item["Name"],style: TextStyle(fontSize: 20),),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.book,color: Colors.blue,size: 20,),
                      Text(item["Name"],style: TextStyle(fontSize: 20),),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.book,color: Colors.blue,size: 20,),
                      Text(item["Name"],style: TextStyle(fontSize: 20),),
                    ],
                  )
                ],
              )
            )*/
          ),
          separatorBuilder: (_, index) => const Divider(
            //color: Colors.black,
            height:1
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}