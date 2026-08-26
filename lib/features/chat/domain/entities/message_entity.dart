/// domain/entities/message_entity.dart
/// النسخة الاحترافية لدعم:
/// text + image + document preview مثل WhatsApp
library;

class MessageEntity {
  final String id;

  /// sender uid
  final String senderId;

  /// للنص العادي فقط
  final String text;

  /// text | image | document
  final String type;

  final DateTime createdAt;
  final bool isRead;
  final int index;

  /// =========================
  /// Document / Image Support
  /// =========================

  /// image/document url
  final String fileUrl;

  /// example:
  /// contract.pdf
  /// photo.png
  final String fileName;

  /// bytes
  final int fileSize;

  /// pdf / docx / jpg / png
  final String fileExtension;

  /// optional for pdf preview
  final int pageCount;

  const MessageEntity({
    required this.id,
    required this.senderId,
    required this.text,
    required this.type,
    required this.createdAt,
    required this.isRead,
    required this.index,

    /// new fields
    this.fileUrl = '',
    this.fileName = '',
    this.fileSize = 0,
    this.fileExtension = '',
    this.pageCount = 0,
  });
}