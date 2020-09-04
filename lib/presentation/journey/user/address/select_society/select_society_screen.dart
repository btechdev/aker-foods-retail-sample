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
    selectSocietyBloc.add(SearchSocitiesCancelEvent());
  }

  void _searchTextChanged(String text) {
    if (_searchFieldController.text.trim().isNotEmpty &&
        _searchFieldController.text.trim().length > 3) {
      selectSocietyBloc.add(SearchSocitiesEvent(
          searchKeyword: _searchFieldController.text.trim()));
    } else if (_searchFieldController.text.trim().isEmpty) {
      selectSocietyBloc.add(FetchSocietiesFirstPageEvent());
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
      return _buildSocietiesListWithScaffold(context, state);
    } else if (state is SearchingSocietiesState ||
        state is SocitiesSearchFailedState) {
      _societies = [];
      return _buildSocietiesListWithScaffold(context, state);
    } else if (state is SocitiesSearchSuccessState) {
      _societies = state.societies;
      return _buildSocietiesListWithScaffold(context, state);
    }
    return Container();
  }

  Widget _loaderWithScaffold() => Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ),
      );

  Widget _buildSocietiesListWithScaffold(
          BuildContext context, SelectSocietyState state) =>
      Scaffold(
        appBar: _getAppBar(context, state),
        floatingActionButton: _getAddSocietyButton(),
        body: KeyboardAvoider(
          child: _getBody(context, state),
        ),
      );

  Container _getBody(BuildContext context, SelectSocietyState state) {
    if (state is SearchingSocietiesState) {
      return Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      );
    } else if (state is SocitiesSearchFailedState) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          'Society Not Found',
          style: Theme.of(context).textTheme.headline4,
        ),
      );
    } else {
      return _getListOfSocietyWidget(state);
    }
  }

  Container _getListOfSocietyWidget(SelectSocietyState state) => Container(
        child: ListView.separated(
          itemBuilder: (_, index) => _getListTile(index),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: _societies.length,
        ),
      );

  ListTile _getListTile(int index) => ListTile(
        title: _getListItemText(index),
        onTap: () => Navigator.pop(
          context,
          _societies[index],
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

  AppBar _getAppBar(context, SelectSocietyState state) => AppBar(
        elevation: 1,
        title: _getSearchTextField(context),
        centerTitle: false,
        titleSpacing: 0,
        actions: _getSearchActions(state),
        backgroundColor: AppColor.white,
      );

  List<Widget> _getSearchActions(SelectSocietyState state) {
    return [
      IconButton(
        icon: Icon(
          (state is SearchingSocietiesState ||
                  state is SocitiesSearchSuccessState ||
                  state is SocitiesSearchFailedState)
              ? Icons.cancel
              : Icons.search,
          color: AppColor.primaryColor,
        ),
        onPressed: (state is SearchingSocietiesState ||
                state is SocitiesSearchSuccessState ||
                state is SocitiesSearchFailedState)
            ? _clearSearchTextField
            : _inFocusSearchTextField,
      ),
    ];
  }

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
