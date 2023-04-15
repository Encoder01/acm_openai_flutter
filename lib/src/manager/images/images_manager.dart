import 'package:acm_open_ai_flutter/src/client/client.dart';
import 'package:acm_open_ai_flutter/src/core/constants/constansts.dart';
import 'package:acm_open_ai_flutter/src/model/gen_image/request/edit_req.dart';
import 'package:acm_open_ai_flutter/src/model/gen_image/request/generate_req.dart';
import 'package:acm_open_ai_flutter/src/model/gen_image/request/variation.dart';
import 'package:acm_open_ai_flutter/src/model/gen_image/response/gen_img_res.dart';
import 'package:acm_open_ai_flutter/src/routes/Images/images_route.dart';
import 'package:dio/dio.dart';

class ACMOpenAIImagesManager {
  final ACMOpenAINetworkingClient _client;

  ACMOpenAIImagesManager(this._client);

  final _cancel = CancelToken();

  Future<ACMOpenAIGenImgResponse> create(ACMOpenAIGenerateImageRequest request) async {
    return _client.post(
      kURL + ImagesRoute.create,
      request.toJson(),
      onSuccess: (val) {
        return ACMOpenAIGenImgResponse.fromJson(val);
      },
    );
  }

  Future<ACMOpenAIGenImgResponse> editImage(ACMOpenAIEditImageRequest request) async {
    final mRequest = await request.convert();
    return _client.postFormData(kURL + ImagesRoute.createEdit, mRequest, complete: (it) {
      return ACMOpenAIGenImgResponse.fromJson(it);
    });
  }

  ///Creates a variation of a given image.[variation]
  Future<ACMOpenAIGenImgResponse> variation(ACMOpenAIVariationRequest request) async {
    final mRequest = await request.convert();
    return _client.postFormData(kURL + ImagesRoute.createVariation, mRequest, complete: (it) {
      return ACMOpenAIGenImgResponse.fromJson(it);
    });
  }

  void cancelEdit() {
    _client.log("stop openAI image");
    _cancel.cancel();
  }
}
