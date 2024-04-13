import 'package:get/get.dart';
import 'package:wrg2/backend/network/executor/executor.auth.dart';
import 'package:wrg2/backend/network/executor/executor.post.dart';
import 'package:wrg2/backend/network/executor/executor.user.dart';

class GE extends GetxController with AuthExecutor, UserExecutor, PostExecutor {}
