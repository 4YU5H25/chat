import 'dart:math';
import 'package:flutter/material.dart';

class MentalHealthQuizPage extends StatefulWidget {
  @override
  _MentalHealthQuizPageState createState() => _MentalHealthQuizPageState();
}

class _MentalHealthQuizPageState extends State<MentalHealthQuizPage> {
  int _questionIndex = 0;
  int _score = 0;

  final List<Map<String, dynamic>> _questions = [
    {
      'questionText':
          'How often does your child express feelings of sadness or tearfulness?',
      'answers': [
        'Rarely or never',
        'Occasionally',
        'Frequently',
        'Almost all the time',
      ],
    },
    {
      'questionText':
          'Does your child often feel overwhelmed by their emotions?',
      'answers': [
        'Rarely or never',
        'Occasionally',
        'Frequently',
        'Almost all the time',
      ],
    },
    {
      'questionText': 'How does your child handle peer pressure?',
      'answers': [
        'Stands firm in their values and decisions',
        'Occasionally gives in to peer pressure but learns from it',
        'Often succumbs to peer pressure',
        'Experiences extreme anxiety or distress from peer pressure',
      ],
    },
    {
      'questionText':
          'Does your child engage in behaviors that harm themselves or others?',
      'answers': [
        'No',
        'Occasionally',
        'Frequently',
        'Almost all the time',
      ],
    },
    {
      'questionText':
          'How does your child express their emotions and communicate their needs?',
      'answers': [
        'Communicates openly and effectively',
        'Sometimes struggles to express emotions but tries their best',
        'Often suppresses emotions or has difficulty expressing them',
        'Experiences extreme mood swings or emotional dysregulation',
      ],
    },
    {
      'questionText':
          'Does your child have difficulty trusting others or forming close relationships?',
      'answers': [
        'Trusts others easily and forms strong relationships',
        'Occasionally struggles with trust but opens up over time',
        'Often has trust issues or difficulty forming close bonds',
        'Experiences paranoia or extreme fear of others',
      ],
    },
    {
      'questionText':
          'How does your child handle conflicts or disagreements with family members?',
      'answers': [
        'Resolves conflicts calmly and constructively',
        'Sometimes struggles but eventually resolves conflicts',
        'Frequently becomes argumentative or confrontational',
        'Experiences intense family conflicts or estrangement',
      ],
    },
    {
      'questionText':
          'Does your child engage in behaviors that disrupt their daily functioning or responsibilities?',
      'answers': [
        'No',
        'Occasionally',
        'Frequently',
        'Almost all the time',
      ],
    },
    {
      'questionText':
          'How does your child handle setbacks or failures in school or other activities?',
      'answers': [
        'Takes setbacks in stride and learns from them',
        'Feels disappointed but remains resilient',
        'Becomes discouraged or demotivated by failures',
        'Experiences extreme despair or avoidance behaviors',
      ],
    },
    {
      'questionText':
          'Does your child engage in excessive worry or rumination about future events?',
      'answers': [
        'Rarely or never',
        'Occasionally',
        'Frequently',
        'Almost all the time',
      ],
    },
    {
      'questionText':
          'How does your child cope with major life changes or transitions?',
      'answers': [
        'Adapts easily and remains flexible',
        'Adjusts over time with support',
        'Struggles to cope with major changes',
        'Experiences extreme distress or inability to cope with change',
      ],
    },
    {
      'questionText':
          'Does your child have difficulty expressing themselves verbally or emotionally?',
      'answers': [
        'Communicates effectively and openly',
        'Sometimes struggles but expresses themselves in other ways',
        'Often has difficulty expressing thoughts or emotions',
        'Experiences selective mutism or complete emotional shutdown',
      ],
    },
    {
      'questionText':
          'How does your child handle feelings of loneliness or isolation?',
      'answers': [
        'Engages in social activities and seeks out connections',
        'Occasionally feels lonely but copes with support',
        'Frequently experiences loneliness or social withdrawal',
        'Experiences extreme isolation or social avoidance',
      ],
    },
    {
      'questionText':
          'Does your child engage in behaviors that indicate a lack of self-care or neglect?',
      'answers': [
        'No',
        'Occasionally',
        'Frequently',
        'Almost all the time',
      ],
    },
    {
      'questionText':
          'How does your child respond to stressful situations at home or in their environment?',
      'answers': [
        'Remains calm and composed under stress',
        'Feels stressed but copes with support',
        'Becomes overwhelmed or anxious during stressful situations',
        'Experiences extreme panic or dissociation during stress',
      ],
    },
    {
      'questionText':
          'Does your child engage in behaviors that indicate a lack of impulse control or risk awareness?',
      'answers': [
        'No',
        'Occasionally',
        'Frequently',
        'Almost all the time',
      ],
    },
    {
      'questionText':
          'Does your child struggle to make friends or maintain relationships with peers?',
      'answers': [
        'No, they have healthy relationships',
        'Occasionally, but they have some friends',
        'Yes, they find it difficult to make or keep friends',
        'They have no friends or social interactions',
      ],
    },
    {
      'questionText':
          'How does your child respond to changes in routine or unexpected events?',
      'answers': [
        'Adapts easily and without difficulty',
        'May show initial resistance but adjusts over time',
        'Becomes anxious or upset by changes',
        'Becomes extremely distressed or unmanageable',
      ],
    },
    {
      'questionText':
          'Does your child frequently complain of physical symptoms like stomachaches or headaches, especially during school days?',
      'answers': [
        'Rarely or never',
        'Occasionally',
        'Frequently',
        'Almost every day',
      ],
    },
    {
      'questionText':
          'How does your child cope with academic pressure or performance expectations?',
      'answers': [
        'Handles pressure well and maintains a healthy balance',
        'Occasionally feels stressed but copes with support',
        'Often feels overwhelmed or anxious about academic demands',
        'Experiences extreme anxiety or avoidance behaviors related to schoolwork',
      ],
    },
    {
      'questionText':
          'Have you noticed any changes in your child\'s eating habits, such as loss of appetite or overeating?',
      'answers': [
        'No',
        'Occasionally',
        'Frequently',
        'Almost all the time',
      ],
    },
    {
      'questionText':
          'Does your child exhibit frequent mood swings or emotional outbursts?',
      'answers': [
        'Rarely or never',
        'Occasionally',
        'Frequently',
        'Almost all the time',
      ],
    },
    {
      'questionText': 'How does your child react to criticism or failure?',
      'answers': [
        'Takes it in stride and learns from it',
        'May feel disappointed initially but bounces back',
        'Becomes upset or discouraged',
        'Experiences extreme distress or self-loathing',
      ],
    },
    {
      'questionText':
          'Does your child exhibit symptoms of hyperactivity or impulsivity?',
      'answers': [
        'No',
        'Occasionally',
        'Frequently',
        'Almost all the time',
      ],
    },
    {
      'questionText':
          'Have you observed any changes in your child\'s sleep patterns, such as difficulty falling asleep or frequent nightmares?',
      'answers': [
        'No',
        'Occasionally',
        'Frequently',
        'Almost every night',
      ],
    },
  ];

  List<Map<String, dynamic>> _selectedQuestions = [];

  @override
  void initState() {
    super.initState();
    _selectedQuestions = _selectRandomQuestions(10);
  }

  List<Map<String, dynamic>> _selectRandomQuestions(int count) {
    // Use Random class to shuffle the questions and select the first 'count' questions
    List<Map<String, dynamic>> shuffledQuestions = List.from(_questions);
    shuffledQuestions.shuffle();
    return shuffledQuestions.take(count).toList();
  }

  void _answerQuestion(String answer) {
    int scoreForAnswer = 0;
    // Assigning scores based on the selected answer
    if (answer == _selectedQuestions[_questionIndex]['answers'][0]) {
      scoreForAnswer += 5;
    } else if (answer == _selectedQuestions[_questionIndex]['answers'][1]) {
      scoreForAnswer += 10;
    } else if (answer == _selectedQuestions[_questionIndex]['answers'][2]) {
      scoreForAnswer += 15;
    } else if (answer == _selectedQuestions[_questionIndex]['answers'][3]) {
      scoreForAnswer += 20;
    }

    // Updating the total score
    setState(() {
      _score += scoreForAnswer;
      _questionIndex++;
    });
  }

  String getMood() {
    if (_score <= 80) {
      return '😊'; // Happy emoji
    } else if (_score <= 100) {
      return '😐'; // Neutral emoji
    } else if (_score <= 150) {
      return '😟'; // Sad emoji
    } else {
      return '😭'; // Crying emoji
    }
  }

  String opext() {
    if (_score <= 80) {
      return 'Your child\'s mental health seems to be in a good state.'; // Happy emoji
    } else if (_score <= 100) {
      return 'Your child\'s mental health may need some attention. Consider seeking professional help if necessary.'; // Neutral emoji
    } else if (_score <= 150) {
      return 'Your child is showing signs of struggling with mental health. It is important to address these issues promptly.'; // Sad emoji
    } else {
      return 'Your child\'s mental health is concerning. Immediate intervention and professional help are recommended.'; // Crying emoji
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mental Health Trivia',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(255, 181, 218, 1),
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(149, 59, 238, 1),
      ),
      body: _questionIndex < _selectedQuestions.length
          ? Container(
              color: const Color.fromRGBO(149, 59, 238, 1),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(20.0), // Adjust the radius as needed
                child: Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(100, 32, 170, 1),
                    borderRadius: BorderRadius.circular(
                        20.0), // Same radius as ClipRRect for consistency
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            _selectedQuestions[_questionIndex]['questionText'],
                            style: const TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(225, 175, 209, 1),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        ...(_selectedQuestions[_questionIndex]['answers']
                                as List<String>)
                            .map(
                              (answer) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: ElevatedButton(
                                    onPressed: () => _answerQuestion(answer),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.all(16.0),
                                    ),
                                    child: Text(
                                      answer,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : Container(
              color: const Color.fromRGBO(149, 59, 238, 1),
              child: Center(
                // Centering the final score part
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Quiz Completed!',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      'Your score: $_score/${_selectedQuestions.length * 20}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      getMood(),
                      style: const TextStyle(
                        fontSize: 64.0,
                      ),
                    ),
                    Text(
                      opext(),
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
