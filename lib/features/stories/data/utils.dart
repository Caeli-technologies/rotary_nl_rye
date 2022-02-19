// Future getDataStories(String url) async {
//   http.Response? response;
//   try {
//     response = await http.get(
//       Uri.parse(url),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//     );
//   } catch (e) {
//     print(e);
//     throw 'unable to fetch stories json';
//   }
//   if (response.statusCode != 200) {
//     return null;
//   }
//   var data = json.decode(response.body);
//   List<Story>? stories;
//   try {
//     stories = StoryResult.fromJson(data).stories;
//   } catch (e) {
//     print(e);
//     return null;
//   }
//
//   return stories;
// }
//
// Future getDataStudents(String url) async {
//   http.Response? response;
//   try {
//     response = await http.get(
//       Uri.parse(url),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//     );
//   } catch (e) {
//     print(e);
//     throw 'unable to fetch stories json';
//   }
//   var data = json.decode(response.body);
//   List<ExchangeStudent> students = ExchangeResult.fromJson(data).students;
//   return students;
// }
