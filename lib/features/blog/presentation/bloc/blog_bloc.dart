// import 'package:bloc/bloc.dart';
// import 'dart:io';

import 'package:blog_ward/core/usecase/usecase_interface.dart';
import 'package:blog_ward/core/utils/pick_image.dart';
import 'package:blog_ward/features/authentication/domain/usecase/current_user.dart';
import 'package:blog_ward/features/blog/domain/entities/blog.dart';
import 'package:blog_ward/features/blog/domain/usecases/get_blogs.dart';
import 'package:blog_ward/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_ward/features/blog/domain/value_object/category_value_object.dart';
import 'package:blog_ward/features/blog/presentation/objects/upload.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final CurrentUser _currentUser;
  final UploadBlog _uploadBlog;
  final SelectBlogs _selectBlogs;
  BlogBloc(
      {required UploadBlog uploadBlog,
      required SelectBlogs selectBlogs,
      required CurrentUser currentUser})
      : _uploadBlog = uploadBlog,
        _selectBlogs = selectBlogs,
        _currentUser = currentUser,
        super(BlogInitial()) {
    on<PosterIdEvent>(_getPosterId);
    on<ImagePickEvent>(_imagePick);
    on<CategoryPickEvent>(_categoryPick);
    on<BlogFieldEvent>(_fieldSet);
    on<FormSubmitEvent>(_submitForm);
    on<ResetForm>(_resetForm);
    on<SelectAllBlogsEvent>(_selectAllBlogs);
  }

  void _selectAllBlogs(
      SelectAllBlogsEvent event, Emitter<BlogState> emit) async {
        
    final res = await _selectBlogs(NoParams());
    res.fold((error) => emit(BlogFailure(error: error.message)),
        (blogs) => emit(GetBlogsState(blogs: blogs)));
  }

  void _resetForm(ResetForm event, Emitter<BlogState> emit) async {
    final user = await _currentUser(NoParams());
    UploadBlogState newBLogEdit = const UploadBlogState();
    user.fold((l) => null,
        (r) => emit(BlogEdit(editBlog: newBLogEdit.copyWith(posterId: r.id))));
    // if (state is! BlogEdit) {
    // final state = this.state as BlogEdit;
    // final event = this._getPosterId(event, emit) as PosterIdEvent;
    // _getPosterId(event, emit);
    // UploadBlogState reset = state.editBlog.reset();

    // }
  }

  void _fieldSet(BlogFieldEvent event, Emitter<BlogState> emit) {
    final state = this.state as BlogEdit;
    emit(BlogEdit(
        editBlog: state.editBlog
            .copyWith(title: event.title, content: event.content)));
  }

  void _getPosterId(PosterIdEvent event, Emitter<BlogState> emit) {
    UploadBlogState uploadBlogState = const UploadBlogState();
    emit(BlogEdit(
        editBlog: uploadBlogState.copyWith(posterId: event.currentUserId)));
  }

  void _submitForm(FormSubmitEvent event, Emitter<BlogState> emit) async {
    final state = this.state as BlogEdit;
    if (state.editBlog.image == null) {
      emit(BlogEdit(
          editBlog: state.editBlog.copyWith(
        status: Status.error,
      )));
      return;
    }

    if (state.editBlog.image != null &&
        state.editBlog.category.value.isNotEmpty) {
      emit(BlogEdit(editBlog: state.editBlog.copyWith(status: Status.loading)));
      final res = await _uploadBlog(UploadBlogParams(
          title: state.editBlog.title!,
          content: state.editBlog.content!,
          image: state.editBlog.image!,
          posterId: state.editBlog.posterId!,
          category: state.editBlog.category.value));

      res.fold(
          (error) => emit(BlogFailure(error: error.message)),
          (success) => emit(BlogEdit(
              editBlog: state.editBlog.copyWith(status: Status.uploaded))));
    }
  }

  void _categoryPick(CategoryPickEvent event, Emitter<BlogState> emit) {
    final state = this.state as BlogEdit;
    // if (state is BlogEdit) {
    state.editBlog.category.value.contains(event.categoryItem)
        ? emit(BlogEdit(
            editBlog: state.editBlog.copyWith(
              category: Category.dirty(
                List.from(state.editBlog.category.value)
                  ..remove(event.categoryItem),
              ),
            ),
          ))
        : emit(BlogEdit(
            editBlog: state.editBlog.copyWith(
              category: Category.dirty(
                List.from(state.editBlog.category.value)
                  ..add(event.categoryItem),
              ),
            ),
          ));
    // }
  }

  void _imagePick(ImagePickEvent event, Emitter<BlogState> emit) async {
    final state = this.state;
    final pickedimage = await pickImage();
    if (state is BlogEdit) {
      emit(BlogEdit(
          editBlog: state.editBlog
              .copyWith(image: pickedimage, status: Status.initial)));
    }
  }

  @override
  void onEvent(BlogEvent event) {
    debugPrint(event.toString());
    super.onEvent(event);
  }

  @override
  void onChange(Change<BlogState> change) {
    debugPrint(change.currentState.toString());
    debugPrint(change.nextState.toString());
    super.onChange(change);
  }
}
