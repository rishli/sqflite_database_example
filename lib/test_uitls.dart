import 'dart:math';

import 'package:uuid/uuid.dart';

///@date:  2022/3/13 11:26
///@author:  lixu
///@description:

main() {
  int count = 1000000;

  Map<String, MsgBean> map = {};
  List<MsgBean> list = [];

  ///随机数
  int index = Random().nextInt(count);
  print('【count:$count,查找的index:$index】');

  String? findUuid;
  int s = DateTime.now().millisecondsSinceEpoch;
  for (int i = 0; i < count; i++) {
    String uuid = UuidUtils.uuid();
    MsgBean bean = MsgBean(uuid, '这是第$i条消息');
    list.add(bean);
    map.putIfAbsent(uuid, () => bean);

    if (index == i) {
      findUuid = uuid;
    }
  }
  if (findUuid == null) {
    findUuid = list.last.uuid;
  }
  int e = DateTime.now().millisecondsSinceEpoch;

  print('构造数据总时间：${e - s}ms，findUuid:$findUuid');

  for (int i = 0; i < list.length; i++) {
    if (list[i].uuid == findUuid) {
      int e2 = DateTime.now().millisecondsSinceEpoch;
      print('list查到uuid：${e2 - e}ms，查到的msgBean：${list[i].toString()}');
      break;
    }
  }

  int e3 = DateTime.now().millisecondsSinceEpoch;
  MsgBean? bean = map[findUuid];
  int e4 = DateTime.now().millisecondsSinceEpoch;
  print('map查到uuid：${e4 - e3}ms，查到的msgBean：${bean?.toString()}');
}

class MsgBean {
  String uuid;
  String content;

  MsgBean(this.uuid, this.content);

  @override
  String toString() {
    return 'MsgBean{uuid: $uuid, content: $content}';
  }
}

class UuidUtils {
  UuidUtils._();

  static const Uuid _uuid = Uuid();

  static String uuid() {
    return _uuid.v4().replaceAll('-', '');
  }
}
