// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_device_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SmartDevice _$SmartDeviceFromJson(Map<String, dynamic> json) => _SmartDevice(
      qrCode: json['qrCode'] as String? ?? '-',
      deviceType: json['deviceType'] as String? ?? '-',
      smartKey: json['smartKey'] as String? ?? '-',
      sgtin: json['sgtin'] as String? ?? '-',
      name: json['name'] as String? ?? '-',
      description: json['description'] as String? ?? '-',
      room: json['room'] as String? ?? '-',
      floor: json['floor'] as String? ?? '-',
      building: json['building'] as String? ?? '-',
      sembastKey: (json['sembastKey'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SmartDeviceToJson(_SmartDevice instance) =>
    <String, dynamic>{
      'qrCode': instance.qrCode,
      'deviceType': instance.deviceType,
      'smartKey': instance.smartKey,
      'sgtin': instance.sgtin,
      'name': instance.name,
      'description': instance.description,
      'room': instance.room,
      'floor': instance.floor,
      'building': instance.building,
      'sembastKey': instance.sembastKey,
    };
