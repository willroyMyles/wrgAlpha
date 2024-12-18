import 'package:get/get.dart';
import 'package:wrg2/backend/network/executor/executor.auth.dart';
import 'package:wrg2/backend/network/executor/executor.cars.dart';
import 'package:wrg2/backend/network/executor/executor.chat.dart';
import 'package:wrg2/backend/network/executor/executor.comments.dart';
import 'package:wrg2/backend/network/executor/executor.feedback.dart';
import 'package:wrg2/backend/network/executor/executor.messages.dart';
import 'package:wrg2/backend/network/executor/executor.offer.dart';
import 'package:wrg2/backend/network/executor/executor.post.dart';
import 'package:wrg2/backend/network/executor/executor.storage.dart';
import 'package:wrg2/backend/network/executor/executor.user.dart';

class GE extends GetxController
    with
        FeedbackExecutor,
        AuthExecutor,
        UserExecutor,
        PostExecutor,
        CommentsExecutor,
        offersExecutor,
        MessagesExecutor,
        ChatExecutor,
        CarsExecutor,
        StorageExecutor {}

GE _ge = GE();
GE get ge => _ge;
