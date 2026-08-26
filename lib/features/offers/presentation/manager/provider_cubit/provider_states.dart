import 'package:equatable/equatable.dart';
import '../../../domain/entities/offer_entity.dart';

class ProviderState extends Equatable {
  final bool isLoading;
  final List<OfferEntity> services;
  final String? error;

  /// 👇 الجديد
  final dynamic provider;

  const ProviderState({
    this.isLoading = false,
    this.services = const [],
    this.error,
    this.provider,
  });

  ProviderState copyWith({
    bool? isLoading,
    List<OfferEntity>? services,
    String? error,
    dynamic provider, // 👈 جديد
  }) {
    return ProviderState(
      isLoading: isLoading ?? this.isLoading,
      services: services ?? this.services,
      error: error,
      provider: provider ?? this.provider,
    );
  }

  @override
  List<Object?> get props => [isLoading, services, error, provider];
}