import '../../domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.id,
    required super.senderId,
    required super.text,
    required super.type,
    required super.createdAt,
    required super.isRead,
    required super.index,

    /// NEW
    super.fileUrl,
    super.fileName,
    super.fileSize,
    super.fileExtension,
    super.pageCount,
  });
  factory MessageModel.fromMap(
      Map<String, dynamic> map,
      String id,
      ) {
    return MessageModel(
      id: id,

      senderId: map["senderId"] ?? map["sender"] ?? "",

      text: map["text"] ?? "",
      type: map["type"] ?? "text",

      createdAt:
      map["timestamp"]?.toDate() ?? DateTime.now(),

      isRead: map["isRead"] ?? false,
      index: map["index"] ?? 0,

      fileUrl: map["fileUrl"] ?? map["text"] ?? "",
      fileName: map["fileName"] ?? "",
      fileSize: map["fileSize"] ?? 0,
      fileExtension: map["fileExtension"] ?? "",
      pageCount: map["pageCount"] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "sender": senderId,

      "text": text,

      "type": type,

      "timestamp": createdAt,

      "isRead": isRead,

      "index": index,

      /// NEW
      "fileUrl": fileUrl,
      "fileName": fileName,
      "fileSize": fileSize,
      "fileExtension": fileExtension,
      "pageCount": pageCount,
    };
  }
}