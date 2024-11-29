import 'package:brain_train_app/attention/long_term_concentration_video.dart';
import 'package:brain_train_app/attention/strong_concentration_desc.dart';
import 'package:brain_train_app/investing/menu.dart';
import 'package:brain_train_app/linguistic/correct_a_word.dart';
import 'package:brain_train_app/linguistic/hangman.dart';
import 'package:brain_train_app/linguistic/listening_comprehension_video.dart';
import 'package:brain_train_app/linguistic/wordly.dart';
import 'package:brain_train_app/memory/faces.dart';
import 'package:brain_train_app/memory/memory_game1.dart';
import 'package:brain_train_app/memory/working_memory.dart';
import 'package:brain_train_app/attention/reading/reading.dart';
import 'package:brain_train_app/linguistic/scrabble.dart';
import 'package:brain_train_app/logical_thinking/sudoku.dart';
import 'package:brain_train_app/logical_thinking/2048/game_2048.dart';
import 'package:brain_train_app/well_being/memes.dart';
import 'package:brain_train_app/well_being/meditation/meditation.dart';
import 'package:brain_train_app/well_being/sport.dart';
import 'package:brain_train_app/well_being/yoga.dart';
import 'package:brain_train_app/attention/short_term_concentration.dart';
import 'package:brain_train_app/attention/find_the_number.dart';
import 'package:brain_train_app/linguistic/poems_reading/poems_info.dart';
import 'package:brain_train_app/linguistic/reading_comprehension.dart';
import 'package:brain_train_app/linguistic/spelling_mistakes.dart';
import 'package:brain_train_app/linguistic/grammar_mcq_test.dart';
import 'package:brain_train_app/linguistic/choose_best_word.dart';
import 'package:brain_train_app/linguistic/idioms.dart';
import 'package:brain_train_app/logical_thinking/riddles_info.dart';
import 'package:brain_train_app/memory/learning_words/memory.dart';

var memoryBaseList = [
  [Memory, "Memory", 10],
  [WorkingMemory, "WorkingMemory", 5],
  [MemoryGame1, "MemoryGame1", 5],
  [Faces, "Faces", 5],
  [LongTermConcentrationVideo, "LongTermConcentrationVideo", 10],
];

var memoryRestList = [
  const InvestingMenu(),
  const Reading(),
  const Scrabble(iteration: 1, allPoints: 0),
  const Hangman(),
  const SudokuGame(),
  const Wordly(),
  const Game2048(),
  const Meditation(),
  const Meme(),
  const Sport(),
  const Yoga(),
  const FindTheNumber(),
];

var memoryAllList = [
  'Memory',
  'WorkingMemory',
  'MemoryGame1',
  'Faces',
  'LongTermConcentrationVideo',
  'InvestingMenu',
  'Reading',
  'Scrabble',
  'Hangman',
  'SudokuGame',
  'Wordly',
  'Game2048',
  'Meditation',
  'Sport',
  'Yoga',
  'FindTheNumber',
];

var attentionBaseList = [
  [StrongConcentrationDesc, "StrongConcentrationDesc", 5],
  [ShortTermConcentration, "ShortTermConcentration", 5],
  [LongTermConcentrationVideo, "LongTermConcentrationVideo", 10],
  [Memory, "Memory", 10],
  [MemoryGame1, "MemoryGame1", 5],
  [FindTheNumber, "FindTheNumber", 5],
];

var attentionRestList = [
  const Reading(),
  const Scrabble(iteration: 1, allPoints: 0),
  const Hangman(),
  const SudokuGame(),
  const Wordly(),
  const Game2048(),
  const InvestingMenu(),
  const Meditation(),
  const Meme(),
  const Sport(),
  const Yoga(),
];

var attentionAllList = [
  'StrongConcentrationDesc',
  'ShortTermConcentration',
  'LongTermConcentrationVideo',
  'Memory',
  'MemoryGame1',
  'FindTheNumber',
  'Reading',
  'Scrabble',
  'Hangman',
  'SudokuGame',
  'Wordly',
  'Game2048',
  'InvestingMenu',
  'Meditation',
  'Sport',
  'Yoga',
];

var linguisticBaseList = [
  [Memory, "Memory", 10],
  [PoemsInfo, "PoemsInfo", 5],
  [ReadingComprehension, "ReadingComprehension", 10],
  [ListeningComprehensionVideo, "ListeningComprehensionVideo", 10],
  [const SpellingMistakes(exerciseId: 0), "SpellingMistakes", 5],
  [const CorrectAWord(), "CorrectAWord", 5],
  [const Grammar(exerciseId: 0), "Grammar", 5],
  [const SpellingMistakes(exerciseId: 0), "SpellingMistakes", 5],
  [const ChooseBestWord(), "ChooseBestWord", 5],
  [const Idioms(), "Idioms", 5],
  [const Scrabble(iteration: 1, allPoints: 0), "Scrabble", 5],
  [const Hangman(), "Hangman", 5],
  [const Wordly(), "Wordly", 5],
];

var linguisticRestList = [
  const Reading(),
  const SudokuGame(),
  const Game2048(),
  const InvestingMenu(),
  const Meditation(),
  const Meme(),
  const Sport(),
  const Yoga(),
  const FindTheNumber(),
];

var linguisticAllList = [
  'Memory',
  'PoemsInfo',
  'ReadingComprehension',
  'ListeningComprehensionVideo',
  'SpellingMistakes',
  'CorrectAWord',
  'Grammar',
  'SpellingMistakes',
  'ChooseBestWord',
  'Idioms',
  'Scrabble',
  'Hangman',
  'Wordly',
  'Reading',
  'SudokuGame',
  'Game2048',
  'InvestingMenu',
  'Meditation',
  'Sport',
  'Yoga',
  'InvestingMenu',
  'FindTheNumber',
];

var logicalBaseList = [
  [const StrongConcentrationDesc(), "StrongConcentrationDesc", 5],
  [const Riddles(), "Riddles", 10],
  [const Game2048(), "Game2048", 5],
  [const SudokuGame(), "SudokuGame", 10],
  [const InvestingMenu(), "InvestingMenu", 15],
];
var logicalRestList = [
  const Scrabble(iteration: 1, allPoints: 0),
  const Hangman(),
  const Wordly(),
  const MemoryGame1(),
  const Reading(),
  const Meditation(),
  const Meme(),
  const Sport(),
  const Yoga(),
  const FindTheNumber(),
];
var logicalAllList = [
  'StrongConcentrationDesc',
  'Riddles',
  'Game2048',
  'SudokuGame',
  'Scrabble',
  'Hangman',
  'Wordly',
  'MemoryGame1',
  'Reading',
  'Meditation',
  'Sport',
  'Yoga',
  'InvestingMenu',
  'FindTheNumber',
];

var gamesBaseList = [
  [const Scrabble(iteration: 1, allPoints: 0), "Scrabble", 5],
  [const Hangman(), "Hangman", 5],
  [const Wordly(), "Wordly", 5],
  [const Game2048(), "Game2048", 5],
  [const SudokuGame(), "SudokuGame", 5],
  [const FindTheNumber(), "FindTheNumber", 5],
  [const MemoryGame1(), "MemoryGame1", 5],
];
var gamesRestList = [
  const Reading(),
  const PoemsInfo(),
  const Meditation(),
  const Meme(),
  const Sport(),
  const Yoga(),
  const InvestingMenu(),
];
var gamesAllList = [
  'Scrabble',
  'Hangman',
  'Wordly',
  'Game2048',
  'SudokuGame',
  'FindTheNumber',
  'MemoryGame1',
  'Reading',
  'PoemsInfo',
  'Meditation',
  'Sport',
  'Yoga',
];

var skillBaseLists = {
  'memory': memoryBaseList,
  'attention': attentionBaseList,
  'linguistic': linguisticBaseList,
  'logical': logicalBaseList,
  'games': gamesBaseList,
};

var skillRestLists = {
  'memory': memoryRestList,
  'attention': attentionRestList,
  'linguistic': linguisticRestList,
  'logical': logicalRestList,
  'games': gamesRestList,
};

var skillAllLists = {
  'memory': memoryAllList,
  'attention': attentionAllList,
  'linguistic': linguisticAllList,
  'logical': logicalAllList,
  'games': gamesAllList,
};

var sectionTimes = {
  'Memory': 10,
  'WorkingMemory': 5,
  'MemoryGame1': 5,
  'Faces': 5,
  'LongTermConcentrationVideo': 10,
  'StrongConcentrationDesc': 5,
  'ShortTermConcentration': 5,
  'FindTheNumber': 5,
  'PoemsInfo': 5,
  'ReadingComprehension': 10,
  'ListeningComprehensionVideo': 10,
  'SpellingMistakes': 5,
  'CorrectAWord': 5,
  'Grammar': 5,
  'ChooseBestWord': 5,
  'Idioms': 5,
  'Scrabble': 5,
  'Hangman': 5,
  'Wordly': 5,
  'Riddles': 10,
  'Game2048': 5,
  'SudokuGame': 10,
  'InvestingMenu': 15,
};

var sectionNames = {
  'Memory': 'Learning words',
  'Faces': 'Faces Memory',
  'LongTermConcentrationVideo': 'Long Term Concentration',
  'StrongConcentrationDesc': 'Strong Concentration',
  'ShortTermConcentration': 'Short Term Concentration',
  'FindTheNumber': 'Find The Number',
  'PoemsInfo': 'Poem reading',
  'ReadingComprehension': 'Reading Comprehension',
  'ListeningComprehensionVideo': 'Listening Comprehension',
  'SpellingMistakes': 'Spelling Mistakes',
  'CorrectAWord': 'Correct a Word',
  'Grammar': 'Grammar',
  'ChooseBestWord': 'Choose Best Word',
  'Idioms': 'Idioms, expressions and phrasal verbs',
  'Scrabble': 'Like Scrabble',
  'Hangman': 'Hangman',
  'Wordly': 'Wordly',
  'Riddles': 'Riddles',
  'Game2048': '2048',
  'SudokuGame': 'Sudoku',
  'WorkingMemory': 'Working memory',
  'MemoryGame1': 'Memory Game',
  'InvestingMenu': 'Short Learning Course',
};

var wellbeing = [
  'Sport / Yoga',
  'Self reflection',
  'Outdoor time',
  'Mediation',
];

var wellbeingTimes = {
  'Sport / Yoga': 4,
  'Self reflection': 2,
  'Outdoor time': 2,
  'Mediation': 2,
};
