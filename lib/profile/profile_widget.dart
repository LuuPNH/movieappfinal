import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieappfinal/profile/profile_bloc.dart';
import 'package:movieappfinal/style/theme.dart' as Style;

import '../local_data_manager/local_data_manager.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late final bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = ProfileBloc()..add((InitProfileEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => bloc,
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Container(
            color: Style.Colors.mainColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(
                    child: CircleAvatar(
                      radius: 80.0,
                      backgroundImage: NetworkImage(state.user?.photoUrl ??
                          'https://via.placeholder.com/150'),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(state.user?.displayName ?? '--',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 26.0, color: Colors.white)),
                    )),
                SizedBox(height: 8.0),
                Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(state.user?.email ?? '--',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 16.0, color: Colors.white)),
                    )),
                SizedBox(height: 34.0),
                InkWell(
                  onTap: () => bloc..add(RefreshProfileEvent()),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Favorite video',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 26.0,
                                      color: Style.Colors.mainColor)),
                        ],
                      )),
                ),
                state.movies?.isNotEmpty == true
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.movies!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(8.0)),
                            height: 100,
                            child: Row(
                              children: [
                                Image.network(
                                  "https://image.tmdb.org/t/p/w200/" +
                                      state.movies![index].poster!,
                                  height: 94,
                                  width: 70,
                                  fit: BoxFit.fill,
                                ),
                                const SizedBox(width: 4.0),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(state.movies![index].title ?? '--',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  fontSize: 16.0,
                                                  color: Colors.white)),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 4.0),
                                FloatingActionButton(
                                  backgroundColor: Style.Colors.secondColor,
                                  onPressed: () => bloc
                                    ..add(RemoveMovieProfileEvent(
                                        state.movies![index])),
                                  child: Icon(Icons.remove),
                                )
                              ],
                            ),
                          );
                        },
                      )
                    : Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text("Don't have movie here",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 16.0, color: Colors.white)),
                        )),
              ],
            ),
          );
        },
      ),
    );
  }
}
