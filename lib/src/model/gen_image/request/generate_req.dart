///The size of the generated images.
enum ImageSize {
  size1024("1024x1024"),
  size512("512x512"),
  size256("256x256");

  const ImageSize(this.size);
  final String size;
}

///The format in which the generated images are returned. Must be one of url or b64_json.
enum Format {
  url,
  b64Json;
}

extension FormatExtension on Format {
  String getName() {
    switch (this) {
      case Format.url:
        return 'url';
      case Format.b64Json:
        return 'b64_json';
      default:
        return '';
    }
  }
}

class ACMOpenAIGenerateImageRequest {
  /// prompt string Required A text description of the desired image(s). The maximum length is 1000 characters.
  final String prompt;

  ///The number of images to generate. Must be between 1 and 10.
  final int n;

  ///The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024.
  final ImageSize? size;

  ///The format in which the generated images are returned. Must be one of url or b64_json.
  final Format? responseFormat;

  ///A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
  final String user;

  ACMOpenAIGenerateImageRequest(
      this.prompt,
      this.n, {
        this.size = ImageSize.size1024,
        this.responseFormat = Format.url,
        this.user = "",
      }) : assert(1 <= n && n <= 10, 'n must be between 1 and 10.');

  Map<String, dynamic> toJson() => Map.of({
    "prompt": prompt,
    "n": n,
    "size": size?.size,
    "response_format": responseFormat?.getName(),
    "user": user
  });
}
