import '../models/question_model.dart';

class QuestionsData {
  static const List<QuestionModel> scienceQuestions = [
    QuestionModel(
      question: 'What is the chemical symbol for Gold?',
      options: ['Go', 'Gd', 'Au', 'Ag'],
      correctIndex: 2,
      category: 'Science',
      explanation: 'Au comes from the Latin word "Aurum" meaning gold.',
    ),
    QuestionModel(
      question: 'How many bones are in the adult human body?',
      options: ['196', '206', '216', '226'],
      correctIndex: 1,
      category: 'Science',
      explanation: 'An adult human body has 206 bones.',
    ),
    QuestionModel(
      question: 'What planet is known as the Red Planet?',
      options: ['Jupiter', 'Venus', 'Saturn', 'Mars'],
      correctIndex: 3,
      category: 'Science',
      explanation: 'Mars is called the Red Planet due to iron oxide on its surface.',
    ),
    QuestionModel(
      question: 'What is the speed of light in a vacuum?',
      options: ['300,000 km/s', '150,000 km/s', '450,000 km/s', '600,000 km/s'],
      correctIndex: 0,
      category: 'Science',
      explanation: 'Light travels at approximately 300,000 km/s in a vacuum.',
    ),
    QuestionModel(
      question: 'What gas do plants absorb during photosynthesis?',
      options: ['Oxygen', 'Nitrogen', 'Carbon Dioxide', 'Hydrogen'],
      correctIndex: 2,
      category: 'Science',
      explanation: 'Plants absorb CO₂ and release oxygen during photosynthesis.',
    ),
    QuestionModel(
      question: 'What is the powerhouse of the cell?',
      options: ['Nucleus', 'Mitochondria', 'Ribosome', 'Golgi Body'],
      correctIndex: 1,
      category: 'Science',
      explanation: 'Mitochondria produce ATP, the energy currency of cells.',
    ),
    QuestionModel(
      question: 'Which element has the atomic number 1?',
      options: ['Helium', 'Oxygen', 'Hydrogen', 'Carbon'],
      correctIndex: 2,
      category: 'Science',
      explanation: 'Hydrogen is the lightest element with atomic number 1.',
    ),
    QuestionModel(
      question: 'What force keeps planets in orbit around the Sun?',
      options: ['Magnetic force', 'Nuclear force', 'Friction', 'Gravity'],
      correctIndex: 3,
      category: 'Science',
      explanation: 'Gravity is the attractive force between massive objects.',
    ),
  ];

  static const List<QuestionModel> mathQuestions = [
    QuestionModel(
      question: 'What is the value of π (Pi) to 2 decimal places?',
      options: ['3.12', '3.14', '3.16', '3.18'],
      correctIndex: 1,
      category: 'Math',
      explanation: 'Pi is approximately 3.14159...',
    ),
    QuestionModel(
      question: 'What is 12 × 13?',
      options: ['144', '148', '156', '169'],
      correctIndex: 2,
      category: 'Math',
      explanation: '12 × 13 = 156',
    ),
    QuestionModel(
      question: 'What is the square root of 144?',
      options: ['11', '12', '13', '14'],
      correctIndex: 1,
      category: 'Math',
      explanation: '12 × 12 = 144, so √144 = 12.',
    ),
    QuestionModel(
      question: 'What is 25% of 200?',
      options: ['40', '50', '60', '75'],
      correctIndex: 1,
      category: 'Math',
      explanation: '25% of 200 = 0.25 × 200 = 50.',
    ),
    QuestionModel(
      question: 'How many degrees are in a triangle?',
      options: ['90°', '180°', '270°', '360°'],
      correctIndex: 1,
      category: 'Math',
      explanation: 'The sum of angles in any triangle is always 180°.',
    ),
    QuestionModel(
      question: 'What is 2 to the power of 10?',
      options: ['512', '1024', '2048', '256'],
      correctIndex: 1,
      category: 'Math',
      explanation: '2^10 = 1024.',
    ),
    QuestionModel(
      question: 'What is the next prime number after 7?',
      options: ['8', '9', '10', '11'],
      correctIndex: 3,
      category: 'Math',
      explanation: '11 is the next prime number after 7.',
    ),
    QuestionModel(
      question: 'What is the area of a circle with radius 7? (use π ≈ 22/7)',
      options: ['144', '154', '164', '174'],
      correctIndex: 1,
      category: 'Math',
      explanation: 'Area = πr² = (22/7) × 7 × 7 = 154.',
    ),
  ];

  static const List<QuestionModel> historyQuestions = [
    QuestionModel(
      question: 'In which year did World War II end?',
      options: ['1943', '1944', '1945', '1946'],
      correctIndex: 2,
      category: 'History',
      explanation: 'World War II ended in 1945 with the surrender of Germany and Japan.',
    ),
    QuestionModel(
      question: 'Who was the first President of the United States?',
      options: ['Abraham Lincoln', 'John Adams', 'Thomas Jefferson', 'George Washington'],
      correctIndex: 3,
      category: 'History',
      explanation: 'George Washington served as the first U.S. President (1789–1797).',
    ),
    QuestionModel(
      question: 'Which ancient wonder was located in Alexandria?',
      options: ['Colosseum', 'Great Pyramid', 'Library of Alexandria', 'Lighthouse of Alexandria'],
      correctIndex: 3,
      category: 'History',
      explanation: 'The Lighthouse of Alexandria was one of the Seven Wonders.',
    ),
    QuestionModel(
      question: 'Who painted the Mona Lisa?',
      options: ['Michelangelo', 'Raphael', 'Leonardo da Vinci', 'Donatello'],
      correctIndex: 2,
      category: 'History',
      explanation: 'Leonardo da Vinci painted the Mona Lisa (c. 1503–1519).',
    ),
    QuestionModel(
      question: 'In which year did the Titanic sink?',
      options: ['1910', '1912', '1914', '1916'],
      correctIndex: 1,
      category: 'History',
      explanation: 'The RMS Titanic sank on April 15, 1912.',
    ),
    QuestionModel(
      question: 'Which country was the first to land humans on the Moon?',
      options: ['Russia', 'China', 'USA', 'UK'],
      correctIndex: 2,
      category: 'History',
      explanation: 'NASA\'s Apollo 11 landed on the Moon on July 20, 1969.',
    ),
    QuestionModel(
      question: 'Who invented the telephone?',
      options: ['Thomas Edison', 'Nikola Tesla', 'Alexander Graham Bell', 'Guglielmo Marconi'],
      correctIndex: 2,
      category: 'History',
      explanation: 'Alexander Graham Bell is credited with inventing the telephone in 1876.',
    ),
    QuestionModel(
      question: 'The Great Wall of China was primarily built to protect against whom?',
      options: ['Romans', 'Mongols', 'Japanese', 'Persians'],
      correctIndex: 1,
      category: 'History',
      explanation: 'The Great Wall was built to defend against Mongol invasions.',
    ),
  ];

  static const List<QuestionModel> generalKnowledge = [
    QuestionModel(
      question: 'What is the capital of Japan?',
      options: ['Osaka', 'Tokyo', 'Kyoto', 'Hiroshima'],
      correctIndex: 1,
      category: 'General',
      explanation: 'Tokyo is the capital and most populous city of Japan.',
    ),
    QuestionModel(
      question: 'How many continents are there on Earth?',
      options: ['5', '6', '7', '8'],
      correctIndex: 2,
      category: 'General',
      explanation: 'Earth has 7 continents: Africa, Antarctica, Asia, Australia, Europe, North America, South America.',
    ),
    QuestionModel(
      question: 'Which is the largest ocean on Earth?',
      options: ['Atlantic', 'Indian', 'Arctic', 'Pacific'],
      correctIndex: 3,
      category: 'General',
      explanation: 'The Pacific Ocean is the largest and deepest ocean.',
    ),
    QuestionModel(
      question: 'What language has the most native speakers in the world?',
      options: ['English', 'Spanish', 'Mandarin Chinese', 'Hindi'],
      correctIndex: 2,
      category: 'General',
      explanation: 'Mandarin Chinese has over 900 million native speakers.',
    ),
    QuestionModel(
      question: 'Which planet in our solar system has the most moons?',
      options: ['Jupiter', 'Saturn', 'Uranus', 'Neptune'],
      correctIndex: 1,
      category: 'General',
      explanation: 'Saturn has 146 confirmed moons, the most of any planet.',
    ),
    QuestionModel(
      question: 'What is the tallest mountain in the world?',
      options: ['K2', 'Kangchenjunga', 'Lhotse', 'Mount Everest'],
      correctIndex: 3,
      category: 'General',
      explanation: 'Mount Everest stands at 8,849 meters above sea level.',
    ),
    QuestionModel(
      question: 'Which country has the most natural lakes?',
      options: ['Russia', 'USA', 'Brazil', 'Canada'],
      correctIndex: 3,
      category: 'General',
      explanation: 'Canada has over 60% of the world\'s natural lakes.',
    ),
    QuestionModel(
      question: 'What is the smallest country in the world?',
      options: ['Monaco', 'San Marino', 'Vatican City', 'Nauru'],
      correctIndex: 2,
      category: 'General',
      explanation: 'Vatican City covers just 0.44 km², making it the smallest country.',
    ),
  ];

  static List<QuestionModel> getQuestions(String category) {
    switch (category) {
      case 'Science':
        return scienceQuestions;
      case 'Math':
        return mathQuestions;
      case 'History':
        return historyQuestions;
      case 'General':
        return generalKnowledge;
      default:
        return [...scienceQuestions, ...mathQuestions, ...historyQuestions, ...generalKnowledge];
    }
  }
}
