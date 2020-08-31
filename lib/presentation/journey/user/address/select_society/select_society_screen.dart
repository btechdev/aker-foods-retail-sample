import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/domain/entities/society_entity.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/select_society/bloc/select_society_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/select_society/bloc/select_society_state.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

import 'add_new_society_dialog.dart';
import 'bloc/select_society_event.dart';

class SelectSocietyScreen extends StatefulWidget {
  SelectSocietyScreen({Key key}) : super(key: key);

  @override
  SelectSocietyScreenState createState() => SelectSocietyScreenState();
}

class SelectSocietyScreenState extends State<SelectSocietyScreen> {
  // ignore: close_sinks
  SelectSocietyBloc selectSocietyBloc;
  bool isSearching = false;

  List<SocietyEntity> _societies;
  List<SocietyEntity> _filteredSocieties;
  TextEditingController _searchFieldController;
  FocusNode _searchFieldFocusNode;

  @override
  void initState() {
    super.initState();
    selectSocietyBloc = Injector.resolve<SelectSocietyBloc>()
      ..add(FetchSocietiesFirstPageEvent());

    _searchFieldFocusNode = FocusNode();
    _searchFieldController = TextEditingController();
  }

  @override
  void dispose() {
    _searchFieldFocusNode.dispose();
    _searchFieldController.dispose();
    super.dispose();
  }

  void _inFocusSearchTextField() {
    _searchFieldFocusNode.requestFocus();
  }

  void _clearSearchTextField() {
    _searchFieldController.clear();
    setState(() {
      isSearching = false;
    });
  }

  void _searchTextChanged(String text) {
    if (_searchFieldController.text.isNotEmpty) {
      setState(() {
        _filteredSocieties = _societies
            .where((society) =>
                society.name.toLowerCase().contains(text.toLowerCase()))
            .toList();
        isSearching = true;
      });
    } else {
      setState(() {
        isSearching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) => BlocProvider<SelectSocietyBloc>(
        create: (context) => selectSocietyBloc,
        child: BlocBuilder<SelectSocietyBloc, SelectSocietyState>(
          builder: _buildBlocWidget,
        ),
      );

  Widget _buildBlocWidget(BuildContext context, SelectSocietyState state) {
    if (state is FetchingSocietiesState) {
      return _loaderWithScaffold();
    } else if (state is SocietiesLoadedState) {
      _societies = state.societies;
      return _buildSocietiesListWithScaffold(context);
    }
    return Container();
  }

  Widget _loaderWithScaffold() => Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ),
      );

  Widget _buildSocietiesListWithScaffold(BuildContext context) => Scaffold(
        appBar: _getAppBar(context),
        floatingActionButton: _getAddSocietyButton(),
        body: KeyboardAvoider(
          child: _getListOfSocietyWidget(),
        ),
      );

  Container _getListOfSocietyWidget() => Container(
        child: ListView.separated(
          itemBuilder: (_, index) => _getListTile(index),
          separatorBuilder: (_, __) => const Divider(),
          itemCount:
              isSearching ? _filteredSocieties.length : _societies.length,
        ),
      );

  ListTile _getListTile(int index) => ListTile(
        title: _getListItemText(index),
        onTap: () => Navigator.pop(
          context,
          isSearching ? _filteredSocieties[index] : _societies[index],
        ),
      );

  Text _getListItemText(int index) => Text(
        isSearching ? _filteredSocieties[index]?.name : _societies[index]?.name,
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w400,
            ),
      );

  FloatingActionButton _getAddSocietyButton() {
    return FloatingActionButton(
      onPressed: () => {
        showDialog(
          context: context,
          builder: (_) => AddNewSocietyDialog(
            onAdd: (value) => {debugPrint(value)},
          ),
        )
      },
      backgroundColor: AppColor.primaryColor,
      child: const Icon(
        Icons.add,
        color: AppColor.white,
      ),
    );
  }

  AppBar _getAppBar(context) => AppBar(
        elevation: 1,
        title: _getSearchTextField(context),
        centerTitle: false,
        titleSpacing: 0,
        actions: _getSearchActions(),
        backgroundColor: AppColor.white,
      );

  List<Widget> _getSearchActions() => [
        IconButton(
          icon: Icon(
            isSearching ? Icons.cancel : Icons.search,
            color: AppColor.primaryColor,
          ),
          onPressed:
              isSearching ? _clearSearchTextField : _inFocusSearchTextField,
        ),
      ];

  TextField _getSearchTextField(context) {
    return TextField(
      controller: _searchFieldController,
      focusNode: _searchFieldFocusNode,
      decoration: _getSearchBarInputDecoration(context),
      style: Theme.of(context).textTheme.bodyText1,
      onChanged: (value) => {_searchTextChanged(value)},
    );
  }

  InputDecoration _getSearchBarInputDecoration(context) {
    return InputDecoration(
      hintText: 'Search your society',
      hintStyle:
          Theme.of(context).textTheme.bodyText1.copyWith(color: AppColor.grey),
      border: InputBorder.none,
      disabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
    );
  }
}
