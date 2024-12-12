import 'package:freezed_annotation/freezed_annotation.dart';

part 'routes_response_dto.freezed.dart';
part 'routes_response_dto.g.dart';

@freezed
class RoutesResponseDTO with _$RoutesResponseDTO {
  factory RoutesResponseDTO(
      {required int duration,
      required int distance,
      @Default([]) List<StepsDTO> steps}) = _RoutesResponseDTO;

  factory RoutesResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$RoutesResponseDTOFromJson(json);
}

@freezed
class LocationDTO with _$LocationDTO {
  factory LocationDTO({required double lat, required double lng}) =
      _LocationDTO;

  factory LocationDTO.fromJson(Map<String, dynamic> json) =>
      _$LocationDTOFromJson(json);
}

@freezed
class StepsDTO with _$StepsDTO {
  factory StepsDTO({String? direction, required LocationDTO location}) =
      _StepsDTO;

  factory StepsDTO.fromJson(Map<String, dynamic> json) =>
      _$StepsDTOFromJson(json);
}
