import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/entities/e_commerce.dart';
import '../../domain/repository/e_commerce_repository.dart';

part 'e_commerce_event.dart';
part 'e_commerce_state.dart';

class ECommerceBloc extends Bloc<ECommerceEvent, ECommerceState> {
  final ECommerceRepository productRepository;

  ECommerceBloc(this.productRepository) : super(EmptyState()) {
    on<LoadAllProductEvent>(_onLoadAllProducts);
    on<GetSingleProductEvent>(_onGetSingleProduct);
    on<CreatProductEvent>(_onCreateProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
  }

  Future<void> _onLoadAllProducts(
      LoadAllProductEvent event, Emitter<ECommerceState> emit) async {
    emit(const LoadingState());
    final either = await productRepository.getAllProduct();
    emit(either.fold(
      (failure) => ErrorState(failure.message),
      (products) => LoadedAllProductState(products),
    ));
  }

  Future<void> _onGetSingleProduct(
      GetSingleProductEvent event, Emitter<ECommerceState> emit) async {
    emit(const LoadingState());
    final either =
        await productRepository.getProductById(int.parse(event.productId));
    emit(either.fold(
      (failure) => ErrorState(failure.message),
      (product) => LoadedSingleProductState(product),
    ));
  }

  Future<void> _onCreateProduct(
      CreatProductEvent event, Emitter<ECommerceState> emit) async {
    emit(const LoadingState());
    final either =
        await productRepository.insertProduct(event.newProductDetails);
    emit(either.fold(
      (failure) => ErrorState(failure.message),
      (createdProduct) => LoadedSingleProductState(createdProduct),
    ));
  }

  Future<void> _onUpdateProduct(
      UpdateProductEvent event, Emitter<ECommerceState> emit) async {
    emit(const LoadingState());
    final either =
        await productRepository.updateProduct(event.updateProductDetails);
    emit(either.fold(
      (failure) => ErrorState(failure.message),
      (updatedProduct) => LoadedSingleProductState(updatedProduct),
    ));
  }

  Future<void> _onDeleteProduct(
      DeleteProductEvent event, Emitter<ECommerceState> emit) async {
    emit(const LoadingState());
    final either =
        await productRepository.deleteProduct(int.parse(event.productId));
    emit(either.fold(
        (fialure) => ErrorState(fialure.message), (_) => EmptyState()));
  }
}
