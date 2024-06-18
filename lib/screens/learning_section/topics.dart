import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project/screens/learning_section/yt_player.dart';
import 'package:project/utils/colors.dart';

class Topics extends StatefulWidget {
  final String category;

  const Topics({Key? key, required this.category}) : super(key: key);

  @override
  State<Topics> createState() => _TopicsState();
}

class _TopicsState extends State<Topics> {
  final int _progress = 0;

  final Map<String, List<Map<String, dynamic>>> _topicsByCategory = {
    'Arrays': [
      {
        'topic': 'Array Basics',
        'link': 'https://www.youtube.com/watch?v=NTHVTY6w2Co',
        'description': 'This video provides a comprehensive introduction to arrays. You will learn what arrays are, '
            'how they are structured, and why they are essential in programming. The tutorial covers the '
            'basic operations you can perform with arrays, such as creation, initialization, and accessing '
            'elements. By the end of this video, you will understand how to manipulate arrays effectively '
            'and will be prepared to use them in your programs. This foundational knowledge is crucial for '
            'delving deeper into more complex data structures and algorithms.'
      },
      {
        'topic': 'Multidimensional Arrays',
        'link': 'https://www.youtube.com/watch?v=18Zt5I4S45o',
        'description': 'Multidimensional arrays are arrays of arrays, providing a way to store data in a tabular '
            'form. This tutorial explains how to declare, initialize, and access elements in '
            'multidimensional arrays. You will learn about practical applications, such as representing '
            'matrices or tables, and how to perform operations like traversing through elements using loops. '
            'The video also discusses common pitfalls and best practices to avoid errors when working with '
            'multidimensional arrays.'
      },
      {
        'topic': 'Array Operations',
        'link': 'https://www.youtube.com/watch?v=Bnjbun-hiBk',
        'description': 'In this video, you will explore various operations that can be performed on arrays. Topics '
            'covered include inserting and deleting elements, searching for specific values, and sorting the '
            'array. The tutorial also delves into more advanced operations such as merging and splitting '
            'arrays, and the use of array algorithms to solve complex problems. Understanding these '
            'operations will enhance your ability to manipulate and utilize arrays effectively in your '
            'programs.'
      }
    ],
    'Strings': [
      {
        'topic': 'How to use strings in Python',
        'link': 'https://youtu.be/Ctqi5Y4X-jA?si=JDj5IqGH9UDnpBtf',
        'description': 'Strings are a fundamental data type in Python, used to represent text. This video tutorial '
            'covers the basics of working with strings in Python. You will learn how to create and manipulate '
            'strings, use various string methods, and perform operations such as concatenation, slicing, and '
            'formatting. The video also introduces common string functions and how to handle string encoding '
            'and decoding. By the end of this tutorial, you will be proficient in handling strings in Python.'
      },
      {
        'topic': 'Intro to Strings',
        'link': 'https://youtu.be/3A3TFVDrLCA?si=5d4xRzRGjudgIYe-',
        'description': 'This introductory video provides an overview of strings, a crucial data type in many programming '
            'languages. You will learn what strings are, how they are represented, and the various operations '
            'that can be performed on them. The tutorial explains concepts such as string immutability, string '
            'concatenation, and the use of escape characters. By understanding these basic concepts, you will '
            'be able to use strings effectively in your coding projects.'
      },
      {
        'topic': 'String Methods in Python',
        'link': 'https://youtu.be/0INvoK_T0cE?si=SvVm8PsriO91oavv',
        'description': 'This video delves into the various methods available for string manipulation in Python. You will '
            'learn about methods such as `upper()`, `lower()`, `replace()`, `find()`, and many others. The '
            'tutorial provides examples of how to use these methods to perform common tasks such as changing '
            'case, finding substrings, and modifying string content. Understanding these methods will greatly '
            'enhance your ability to work with strings and make your code more efficient and readable.'
      }
    ],
    'Stacks': [
      {
        'topic': 'Learn Stacks',
        'link': 'https://youtu.be/KInG04mAjO0?si=yUDj92oG2JOD3OFw',
        'description': 'Stacks are a fundamental data structure in computer science, following the Last In, First Out '
            '(LIFO) principle. This tutorial provides an in-depth look at stacks, including their structure, '
            'operations (push, pop, peek), and applications. You will learn about the implementation of stacks '
            'using arrays or linked lists, and see practical examples of how stacks are used in algorithms and '
            'problem-solving. Understanding stacks is essential for tackling more advanced data structures and '
            'algorithms.'
      },
      {
        'topic': 'Stack Data Structure for JAVA',
        'link': 'https://youtu.be/7m1DMYAbdiY?si=3zlXiAtqMln2R2cB',
        'description': 'This video focuses on the implementation and usage of the stack data structure in Java. It covers '
            'the basics of stack operations such as push, pop, and peek, and explains how to use the `Stack` '
            'class provided by the Java Collections Framework. The tutorial also discusses common use cases of '
            'stacks in Java programming, such as expression evaluation and backtracking algorithms. By the end '
            'of this video, you will be well-equipped to use stacks effectively in your Java applications.'
      },
      {
        'topic': 'Introduction to Stacks',
        'link': 'https://youtu.be/I37kGX-nZEI?si=BmSEbZZsdqPmMXqW',
        'description': 'This introductory video covers the basic concepts of stacks, a vital data structure in computer '
            'science. You will learn about the LIFO (Last In, First Out) principle, how stacks are implemented, '
            'and the core operations (push, pop, peek) that can be performed on stacks. The tutorial provides '
            'examples of stack usage in various applications, such as function call management in recursion and '
            'undo mechanisms in software. By understanding these concepts, you will be able to apply stacks to '
            'solve a wide range of problems.'
      }
    ],
    'Queues': [
      {
        'topic': 'Queues in Data Structure',
        'link': 'https://youtu.be/yzj0Ch01Exo?si=A-cXIRLijDdOAlQz',
        'description': 'Queues are a fundamental data structure that follows the First In, First Out (FIFO) principle. '
            'This video tutorial provides an in-depth introduction to queues, explaining their structure, '
            'operations (enqueue, dequeue, front, rear), and applications. You will learn about different types '
            'of queues such as circular queues, priority queues, and double-ended queues (deques). The tutorial '
            'also covers real-world examples where queues are used, such as task scheduling and buffering.'
      },
      {
        'topic': 'Introduction to Queue',
        'link': 'https://youtu.be/fbonDkYsKj0?si=7-YUV0MqPC2W3zvs',
        'description': 'This video introduces the basic concepts of queues, including their definition, structure, and '
            'core operations. You will learn how queues are used to manage data in a sequential manner, following '
            'the FIFO (First In, First Out) principle. The tutorial provides examples of queue implementation '
            'using arrays and linked lists, and discusses common applications such as managing tasks in a print '
            'queue or handling requests in a server. By understanding these fundamental concepts, you will be '
            'prepared to implement and use queues in your own programs.'
      },
      {
        'topic': 'Summary Queues',
        'link': 'https://youtu.be/D6gu-_tmEpQ?si=c_NO_0AVhUU-fHSB',
        'description': 'This summary video provides a comprehensive overview of queues, covering all essential aspects of '
            'this data structure. You will review the basic operations (enqueue, dequeue, front, rear), and learn '
            'about different types of queues such as circular queues, priority queues, and deques. The tutorial '
            'also highlights practical applications of queues and provides tips for implementing them efficiently. '
            'By consolidating your knowledge of queues, this video will help you understand how to apply this data '
            'structure to solve various programming problems.'
      }
    ],
    'Sets': [
      {
        'topic': 'Sets in Python',
        'link': 'https://youtu.be/l3kCO8cVA6o?si=JSNCrh_cHqsYV1mp',
        'description': 'Sets are an important data type in Python, used to store unique elements. This video tutorial '
            'introduces sets, explaining their properties and how they differ from other collection types like '
            'lists and tuples. You will learn how to create sets, add and remove elements, and perform common '
            'operations such as union, intersection, and difference. The tutorial also covers the use of set '
            'methods and how to iterate over sets efficiently. By understanding sets, you will be able to handle '
            'collections of unique elements effectively in your Python programs.'
      },
      {
        'topic': 'Set Methods',
        'link': 'https://youtu.be/r3R3h5ly_8g?si=IHe6fYY3zOfCg24O',
        'description': 'This video explores the various methods available for manipulating sets in Python. You will learn '
            'about methods such as `add()`, `remove()`, `discard()`, and `clear()`, as well as set operations '
            'like union, intersection, difference, and symmetric difference. The tutorial provides practical '
            'examples of how to use these methods to manage collections of unique elements, making your code '
            'more efficient and easier to read. Understanding these methods will enhance your ability to work '
            'with sets in Python.'
      },
      {
        'topic': 'Set Theory Explanation',
        'link': 'https://youtu.be/CTg_To0PwI8?si=uoWrd0IMozq8TaJm',
        'description': 'This video provides an in-depth explanation of set theory, a fundamental concept in mathematics '
            'that underpins many aspects of computer science. You will learn about the basic principles of set '
            'theory, including elements, subsets, and various set operations. The tutorial also discusses the '
            'application of set theory in programming and how it can be used to solve complex problems. By '
            'understanding set theory, you will gain a deeper insight into how sets are used in computer science '
            'and programming.'
      }
    ],
    'Maps': [
      {
        'topic': 'Maps Function Explained',
        'link': 'https://youtu.be/8q2vICb89ys?si=7sQL_8GWnV6iwxoA',
        'description': 'Maps, also known as dictionaries in Python, are a data structure used to store key-value pairs. '
            'This video explains how maps work, how to create them, and how to perform common operations such as '
            'adding, updating, and removing key-value pairs. The tutorial also covers the use of map methods like '
            '`get()`, `keys()`, `values()`, and `items()`, and discusses the advantages of using maps for '
            'efficient data retrieval. Understanding maps will help you manage and manipulate data effectively '
            'in your programs.'
      },
      {
        'topic': 'What are Maps?',
        'link': 'https://youtu.be/UPME8r3SuhA?si=gOWFxiOOqDHspBuw',
        'description': 'This introductory video provides an overview of maps, a vital data structure in many programming '
            'languages. You will learn what maps are, how they are structured, and the various operations that '
            'can be performed on them. The tutorial explains concepts such as key-value pairs, hash functions, '
            'and collision handling. By understanding these basic concepts, you will be able to use maps '
            'effectively in your coding projects.'
      },
      {
        'topic': 'Overview to Maps',
        'link': 'https://youtu.be/LWCN6I1vZoA?si=ojWBMMFqJyohL3XS',
        'description': 'This video provides a comprehensive overview of maps, also known as dictionaries or associative '
            'arrays. You will learn about the basic operations that can be performed on maps, such as adding, '
            'removing, and updating key-value pairs. The tutorial also covers advanced topics like iterating over '
            'maps, handling missing keys, and using maps for complex data structures. By understanding these '
            'concepts, you will be able to leverage maps to solve various programming challenges efficiently.'
      }
    ],
  };

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> topics = _topicsByCategory[widget.category] ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 18,
          ),
          onPressed: (){
            Get.back();
          },
        ),
        title: Text(
            widget.category,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Nunito'
            ),
        ),
      ),
      body: Column(
        children: [
          // LinearProgressIndicator(
          //   value: (_progress) / topics.length,
          //   backgroundColor: Colors.grey[300],
          //   valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: topics.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(topics[index]['topic']),
                  trailing: IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> YouTubePlayer(videoUrl: topics[index]['link'].toString(), videoTitle: topics[index]['topic'].toString(), videoDescription: topics[index]['description'].toString())));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
