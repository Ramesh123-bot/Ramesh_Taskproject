import 'package:flutter/material.dart';

void main() => runApp(const Completed());

class Completed extends StatelessWidget {
  const Completed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
      ),
      body: const EmailScreen(),
    );
  }
}

class EmailScreen extends StatelessWidget {
  const EmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: emails.length,
      itemBuilder: (context, index) {
        final email = emails[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              email.sender.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            email.subject,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '${email.sender} - ${email.date}',
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          trailing: const Icon(Icons.star_border),
          onTap: () {},
        );
      },
    );
  }
}

class Email {
  final String sender;
  final String subject;
  final String date;

  Email({
    required this.sender,
    required this.subject,
    required this.date,
  });
}

final List<Email> emails = [
  Email(
    sender: 'Ramesh',
    subject: 'Meeting Reminder',
    date: '2 hours ago',
  ),
  Email(
    sender: 'Sathish',
    subject: 'Project Update',
    date: '3 hours ago',
  ),
];
