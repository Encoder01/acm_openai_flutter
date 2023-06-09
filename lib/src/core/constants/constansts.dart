/// Base ChatGPT Url
const kURL = "https://api.openai.com/";
const apiBaseUrl = 'https://chat.openai.com/api';
const backendApiBaseUrl = 'https://chat.openai.com/backend-api';
const kdefaultUserAgent =
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36';
const kerrorMessages = [
  "{\"detail\":\"Hmm...something seems to have gone wrong. Maybe try me again in a little bit.\"}",
];
///model name
const kTextDavinci3 = 'text-davinci-003';
const kTextDavinci2 = 'text-davinci-002';
const kCodeDavinci2 = 'code-davinci-002';
const kTextCurie001 = 'text-curie-001';
const kTextBabbage001 = 'text-babbage-001';
const kTextAda001 = 'text-ada-001';

///chat complete 3.5 and gpt-4
const kChatGptTurboModel = 'gpt-3.5-turbo'; // gpt 3.5
const kChatGptTurbo0301Model = 'gpt-3.5-turbo-0301';
const kChatGpt4 = 'gpt-4';
const kChatGpt40314 = 'gpt-4-0314';
const kChatGpt432k = 'gpt-4-32k';
const kChatGpt432k0314 = 'gpt-4-32k-0314';

///edits
const kEditsTextModel = 'text-davinci-edit-001';
const kEditsCoedModel = 'code-davinci-edit-001';

///embeddings
const kEmbeddingAda002 = 'text-embedding-ada-002';
const kTextSearchAdaDoc001 = 'text-search-ada-doc-001';

///fine tune models
const kAdaModel = 'ada';
const kBabbageModel = 'babbage';
const kCurieModel = 'curie';
const kDavinciModel = 'davinci';

///moderation model
const kTextMStable = 'text-moderation-stable';
const kTextMLast = 'text-moderation-latest';

Map<String, String> kHeader(String token, {String orgId = ""}) =>
    {"Content-Type": 'application/json', "Authorization": "Bearer $token"};

Map<String, String> kHeaderOrg(String orgId) =>
    {"Content-Type": 'application/json', "Authorization": "Bearer $orgId"};

///key data
const kTokenKey = 'token';
const kOrgIdKey = 'orgId';

String translateEngToTur({required String word}) =>
    "Translate this into Turkish : $word";
String translateTurToEng({required String word}) =>
    "Translate this into English : $word";
String translateToRus({required String word}) =>
    "Translate this into Russian : $word";

///
const kOpenAI = 'ACMOpenAI';
