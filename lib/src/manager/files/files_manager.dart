import 'package:acm_open_ai_flutter/src/client/client.dart';
import 'package:acm_open_ai_flutter/src/core/constants/constansts.dart';
import 'package:acm_open_ai_flutter/src/model/file/request/upload_file.dart';
import 'package:acm_open_ai_flutter/src/model/file/response/delete_file_res.dart';
import 'package:acm_open_ai_flutter/src/model/file/response/upload_file_res.dart';
import 'package:acm_open_ai_flutter/src/routes/Files/files_route.dart';
import 'package:dio/dio.dart';

class ACMOpenAIFilesManager {

  final ACMOpenAINetworkingClient _client;
  final _cancel = CancelToken();

  ACMOpenAIFilesManager(this._client);

  Future<ACMOpenAIUploadResponse> uploadFile(ACMOpenAIUploadFileRequest request) async {
    final mRequest = await request.getForm();
    return _client.postFormData(kURL + FilesRoute.upload, mRequest,
        complete: (it) => ACMOpenAIUploadResponse.fromJson(it), cancelToken: _cancel);
  }

  Future<ACMOpenAIDeleteFileResponse> delete(String fileId) async {
    return _client.delete(
      "$kURL${FilesRoute.delete}/{$fileId}",
      onSuccess: (it) => ACMOpenAIDeleteFileResponse.fromJson(it),
      cancelToken: _cancel,
    );
  }

  Future<ACMOpenAIUploadResponse> retrieve(String fileId) async {
    return _client.get(
      "$kURL${FilesRoute.retrieve}/$fileId",
      onSuccess: (it) => ACMOpenAIUploadResponse.fromJson(it),
      cancelToken: _cancel,
    );
  }

  Future<dynamic> retrieveContent(String fileId) async {
    return _client.get(
      '$kURL${FilesRoute.retrieveContent}/$fileId/content',
      onSuccess: (it) => it as dynamic,
      cancelToken: _cancel,
    );
  }

  void cancelFile() {
    _client.log("stop openAI");
    _cancel.cancel();
  }
}
