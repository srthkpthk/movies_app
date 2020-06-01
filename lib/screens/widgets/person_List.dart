import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moviesapp/data/bloc/person/person_bloc.dart';
import 'package:moviesapp/data/model/PersonResponse/person.dart';
import 'package:moviesapp/data/model/PersonResponse/person_response.dart';
import 'package:moviesapp/screens/widgets/common/errorWidget.dart';
import 'package:moviesapp/screens/widgets/common/loadingWidget.dart';

class PersonsList extends StatefulWidget {
  @override
  _PersonsListState createState() => _PersonsListState();
}

class _PersonsListState extends State<PersonsList> {
  PersonBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = PersonBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      // ignore: missing_return
      builder: (_, PersonState state) {
        if (state is InitialPersonState) {
          _bloc.add(GetPersons());
          return loadingWidget();
        }
        if (state is PersonLoading) {
          return loadingWidget();
        }
        if (state is PersonLoadError) {
          return Column(
            children: <Widget>[
              errorWidget(),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () {
                  _bloc.add(GetPersons());
                },
                child: Text(
                  'Retry ?',
                ),
              )
            ],
          );
        }
        if (state is PersonLoaded) {
          return _showPersonWidget(state.response);
        }
      },
    );
  }

  Widget _showPersonWidget(PersonResponse data) {
    List<Person> persons = data.persons;
    if (persons.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No More Persons",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Container(
        height: 116.0,
        padding: EdgeInsets.only(left: 10.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: persons.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(top: 10.0, right: 8.0),
              width: 100.0,
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    persons[index].profileImg == null
                        ? Hero(
                            tag: persons[index].id,
                            child: Container(
                              width: 70.0,
                              height: 70.0,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                FontAwesomeIcons.userAlt,
                              ),
                            ),
                          )
                        : Hero(
                            tag: persons[index].id,
                            child: Container(
                                width: 70.0,
                                height: 70.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "https://image.tmdb.org/t/p/w300/" +
                                              persons[index].profileImg)),
                                )),
                          ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: Text(
                        persons[index].name,
                        maxLines: 2,
                        style: TextStyle(
                            height: 1.4,
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0),
                      ),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Expanded(
                      child: Text(
                        "Trending for " + persons[index].known,
                        maxLines: 2,
                        style: TextStyle(
                            height: 1.4,
                            fontWeight: FontWeight.bold,
                            fontSize: 7.0),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
  }
}
