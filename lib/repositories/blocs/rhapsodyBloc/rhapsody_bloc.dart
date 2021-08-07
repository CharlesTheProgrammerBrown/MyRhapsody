import 'dart:async';

import 'package:MyRhapsody/repositories/models/RhapsodyModel/rhapsodyModel.dart';
import 'package:MyRhapsody/repositories/models/RhapsodyModel/rhapsodyRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'rhapsody_event.dart';
part 'rhapsody_state.dart';




class RhapsodyBloc extends Bloc<RhapsodyEvent, RhapsodyState> {
  final RhapsodyRepository _rhapsodyRepository;
  StreamSubscription _rhapsodySubscription;

  RhapsodyBloc({@required RhapsodyRepository rhapsodyRepository})
      : assert(rhapsodyRepository != null),
       _rhapsodyRepository = rhapsodyRepository,
        super(RhapsodyState.initial());

  @override
  Stream<RhapsodyState> mapEventToState(
    RhapsodyEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is InitiateRhapsodyByLanguage) {
      yield RhapsodyState.initial();
      try {
       _rhapsodySubscription?.cancel();
        _rhapsodySubscription = _rhapsodyRepository
            .getRhapsodyList()
            .listen(
          (rhapsodies) {
            add(
              LoadRhapsodiesByLanguage(
                language: event.language,
                rhapsodiesByLanguage: rhapsodies
                
              
              ),
            );
          },
        );
      } catch (e) {
        yield RhapsodyState.rhapsodiesLoadFailure();
      }
    }

    if (event is LoadRhapsodiesByLanguage) {
      yield* _mapLoadNgoCampaignsByCategoryIdToState(event);
    }
  }

  Stream<RhapsodyState> _mapLoadNgoCampaignsByCategoryIdToState(
      LoadRhapsodiesByLanguage event) async* {
   if (event.language != []) {
      yield RhapsodyState.rhapsodiesLoadSuccess(
       language: event.language,
       rhapsodies: event.rhapsodiesByLanguage,
       
        
      );
    } else {
      yield RhapsodyState.rhapsodiesLoadFailure();
    }
  }
}
