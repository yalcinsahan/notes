part of 'note_cubit.dart';

enum NoteStatus { loading, success, failure }

class NoteState extends Equatable {
  final NoteStatus status;
  final List<Note> notes;

  const NoteState._({
    this.status = NoteStatus.loading,
    this.notes = const <Note>[],
  });

  const NoteState.loading() : this._();

  const NoteState.success(List<Note> notes)
      : this._(status: NoteStatus.success, notes: notes);

  const NoteState.failure() : this._(status: NoteStatus.failure);

  @override
  List<Object> get props => [status, notes];
}
