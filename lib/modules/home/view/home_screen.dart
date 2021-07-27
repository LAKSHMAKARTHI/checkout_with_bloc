import 'package:checkout/config/constants.dart';
import 'package:checkout/modules/details/view/home_route_argument.dart';
import 'package:checkout/modules/home/home.dart';
import 'package:checkout/modules/widgets/empty_list.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = new TextEditingController();
  var _homeBloc;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.clear();
  }

  Future<bool> _willPopCallBack() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(
          'Are you sure to exit?',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    _homeBloc = BlocProvider.of<HomeBloc>(context);

    return WillPopScope(
      onWillPop: _willPopCallBack,
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 8,
                  top: 8,
                  right: 8,
                  bottom: 8
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Constant.darkBlackColor,
                        borderRadius: BorderRadius.circular(12.2)
                    ),
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "Check Out",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Constant.bodyTextColor,
                                fontSize: 16
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<HomeBloc>(context).add(HomeRefreshEvent());
                            },
                            color: Constant.bodyTextColor,
                            icon: Icon(Icons.refresh, color: Constant.bodyTextColor)
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Expanded(
                    child: BlocConsumer<HomeBloc, HomeState>(
                      listener: (context, state){
                        if (state is HomeAddDeleteState) {
                          if (state.action != "none"){
                            final snackbar = SnackBar(content: Text(state.action));
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          }
                        }
                      },
                      builder: (context, state){
                        if (state is HomeAddDeleteState){
                          return (state.items.item.length > 0) ? ListView.builder(
                            padding: EdgeInsets.only(top: 5, bottom: 60),
                            itemCount: state.items.item.length,
                            itemBuilder: (context, index) {
                              return Card(
                                key: ValueKey(index),
                                margin: EdgeInsets.only(top: 5),
                                elevation: 2,
                                child: ListTile(
                                  onTap: (){
                                    Navigator.of(context).pushNamed('/details', arguments: HomeArgument(
                                         state.items.item[index].name,
                                         index
                                    ));
                                  },
                                  leading: IconButton(
                                    onPressed: null,
                                    icon: state.items.item[index].data.where((element) => element["status"] == false).length == 0 ? state.items.item[index].data.length != 0 ? Icon(Icons.done_all_sharp, color: Colors.green) : Icon(Icons.close, color: Colors.red) : Icon(Icons.close, color: Colors.red),
                                  ),
                                  trailing: IconButton(
                                    onPressed: (){
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) => AlertDialog(
                                          scrollable: false,
                                          title: const Text(
                                            'Are you sure to delete this?',
                                             style: TextStyle(
                                                 fontSize: 15
                                             )
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(context, 'Cancel'),
                                              child: const Text('No'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                _homeBloc.add(HomeDeleteEvent(index));
                                              },
                                              child: const Text('Yes'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.remove_circle_outline),
                                  ),
                                  title: Text(state.items.item[index].name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      )),
                                  subtitle: Text(
                                      (state.items.item[index].data.length != 0) ? "${state.items.item[index].data.where((element) => element["status"] == true).length} / ${state.items.item[index].data.length} Completed" : "No items added.",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ),
                              );
                            },
                          ) : EmptyList();
                        }
                        else if (state is HomeInitial){
                          return Center(
                            child: const CircularProgressIndicator(
                              strokeWidth: 5,
                            ),
                          );
                        } else {
                          return EmptyList();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 5,
          tooltip: "Yay, Want new one?",
          backgroundColor: Constant.darkBlackColor,
          onPressed: (){
            showModalBottomSheet(
                context: context,
                isDismissible: true,
                isScrollControlled: true,
                enableDrag: false,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                builder: (context){
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                                "Place Name",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                )
                            ),
                            IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(Icons.close))
                          ],
                        ),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                  Icons.place
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.grey
                              ),
                              hintText: "Enter a place name."
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom
                          ),
                          child: ElevatedButton(
                              onPressed: (){
                                if (nameController.text.isNotEmpty){
                                  Navigator.pop(context);
                                  _homeBloc.add(HomeAddEvent(nameController.text));
                                  //context.read<HomeBloc>().add(HomeAddEvent(nameController.text));
                                  //BlocProvider.of<HomeBloc>(context).add();
                                  nameController.clear();
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Please fill a name.",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1
                                  );
                                }
                              },
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
                              )
                          ),
                        )
                      ],
                    ),
                  );
                }
            );
          },
          label: Text("Add Place",
            style: TextStyle(
                color: Constant.bodyTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 15
            ),
          ),
          icon: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      ),
    );
  }
}
