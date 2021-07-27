import 'package:checkout/config/constants.dart';
import 'package:checkout/modules/details/view/home_route_argument.dart';
import 'package:checkout/modules/widgets/empty_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:checkout/modules/details/details.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  TextEditingController nameController = new TextEditingController();
  var detailBloc;

  Future<bool> _willPopCallBack() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(
         'Are you sure to exit?',
          style: TextStyle(
              fontSize: 15
          )
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pushReplacementNamed('/home'),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }


  Future<void> _Reset(context, index) async {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(
            'Are you sure to reset this?',
            style: TextStyle(
                fontSize: 15
            )
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
              detailBloc.add(DetailsResetEvent(index));
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final place = ModalRoute.of(context)!.settings.arguments as HomeArgument;
    detailBloc = BlocProvider.of<DetailsBloc>(context);
    detailBloc.add(DetailsTriggerEvent(place.index));

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
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed('/home');
                              },
                              color: Constant.bodyTextColor,
                              icon: Icon(Icons.arrow_back)
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              place.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Constant.bodyTextColor,
                                  fontSize: 16
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                _Reset(context, place.index);
                              },
                              color: Constant.bodyTextColor,
                              icon: Icon(Icons.cleaning_services_rounded)
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Expanded(
                      child: BlocConsumer<DetailsBloc, DetailsState>(
                        listener: (context, state){
                          if (state is DetailsActionState){
                            if (state.action != "none"){
                              final snackbar = SnackBar(content: Text(state.action));
                              ScaffoldMessenger.of(context).showSnackBar(snackbar);
                            }
                          }
                        },
                        builder: (context, state){
                          if (state is DetailsActionState){
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
                                      BlocProvider.of<DetailsBloc>(context).add(DetailsStatusEvent(index, place.index));
                                    },
                                    leading: IconButton(
                                      onPressed: null,
                                      icon: (state.items.item[index].status) ? Icon(Icons.done_all_sharp, color: Colors.green) : Icon(Icons.close, color: Colors.red),
                                    ),
                                    trailing: IconButton(
                                      onPressed: (){
                                        showDialog<String>(
                                            context: context,
                                            builder: (context){
                                              return AlertDialog(
                                                title: Text(
                                                  "Are you sure to delete this?",
                                                  style: TextStyle(
                                                      fontSize: 15
                                                  )
                                                ),
                                                actions: [
                                                  TextButton(onPressed: () => Navigator.pop(context), child: Text("No")),
                                                  TextButton(onPressed: () {
                                                    Navigator.of(context).pop();
                                                    detailBloc.add(DetailsDeleteEvent(index, place.index));
                                                  }, child: Text("Yes"))
                                                ],
                                              );
                                            }
                                        );
                                      },
                                      icon: Icon(Icons.remove_circle_outline),
                                    ),
                                    title: Text(state.items.item[index].title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )),
                                    subtitle: Text(
                                      "${(state.items.item[index].status) ? "Checked" : "Not yet"}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ) : EmptyList();
                          } else if (state is DetailsInitial){
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
                                  "Things Name",
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
                                    Icons.room_preferences
                                ),
                                hintStyle: TextStyle(
                                    color: Colors.grey
                                ),
                                hintText: "Enter a things name."
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
                                    detailBloc.add(DetailsAddEvent(nameController.text, place.index));
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
            label: Text("Add Things"),
            icon: Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
        ),
    );
  }
}
