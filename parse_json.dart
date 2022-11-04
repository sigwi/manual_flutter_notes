import 'package:http/http.dart' as http;

main() async {
  var res = await http.get(Uri.parse('url api'));
  Task task = Task.fromJson(jsonDecode(res.body));
  print(task.title);
  print(task.body);
  
}

class Task {
  late String title;
  late String body;
  
  Task(this.title, this.body);
  
  Task.fromJson(Map<String, dynamic> json){
    title = json['title'];
    body = json['body'];    
  }
}
