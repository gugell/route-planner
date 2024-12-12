import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_response_dto.freezed.dart';
part 'weather_response_dto.g.dart';

@freezed
class WeatherResponseDTO with _$WeatherResponseDTO {
  factory WeatherResponseDTO(
      {required String description,
      required double temperature}) = _WeatherResponseDTO;

  factory WeatherResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseDTOFromJson(json);
}
