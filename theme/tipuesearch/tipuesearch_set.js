/*
Tipue Search 7.1
Copyright (c) 2019 Tipue
Tipue Search is released under the MIT License
http://www.tipue.com/search
*/

/*
Stop words
Stop words list from http://www.ranks.nl/stopwords
*/

var tipuesearch_stop_words = ["a", "about", "above", "after", "again", "against", "all", "am", "an", "and", "any", "are", "aren't", "as", "at", "be", "because", "been", "before", "being", "below", "between", "both", "but", "by", "can't", "cannot", "could", "couldn't", "did", "didn't", "do", "does", "doesn't", "doing", "don't", "down", "during", "each", "few", "for", "from", "further", "had", "hadn't", "has", "hasn't", "have", "haven't", "having", "he", "he'd", "he'll", "he's", "her", "here", "here's", "hers", "herself", "him", "himself", "his", "how", "how's", "i", "i'd", "i'll", "i'm", "i've", "if", "in", "into", "is", "isn't", "it", "it's", "its", "itself", "let's", "me", "more", "most", "mustn't", "my", "myself", "no", "nor", "not", "of", "off", "on", "once", "only", "or", "other", "ought", "our", "ours", "ourselves", "out", "over", "own", "same", "shan't", "she", "she'd", "she'll", "she's", "should", "shouldn't", "so", "some", "such", "than", "that", "that's", "the", "their", "theirs", "them", "themselves", "then", "there", "there's", "these", "they", "they'd", "they'll", "they're", "they've", "this", "those", "through", "to", "too", "under", "until", "up", "very", "was", "wasn't", "we", "we'd", "we'll", "we're", "we've", "were", "weren't", "what", "what's", "when", "when's", "where", "where's", "which", "while", "who", "who's", "whom", "why", "why's", "with", "won't", "would", "wouldn't", "you", "you'd", "you'll", "you're", "you've", "your", "yours", "yourself", "yourselves"];

/*
Stemming
Copyright (c) 2014 Dmitry Kuragin
Snowball stemmer algorithm
*/

var tipuesearch_stem = {"words": {"e":1,"ё":1,"и":1,"о":1,"а":1,"у":1,"ы":1,"э":1,"ю":1,"я":1}};

var tipuesearch_replace = {'words': [
     {'word': 'tip', 'replace_with': 'tipue'},
     {'word': 'javscript', 'replace_with': 'javascript'},
     {'word': 'jqeury', 'replace_with': 'jquery'}
]};

/*
Weight
set weight to false to disable weight
*/

var tipuesearch_weight = {'weight': true, 'weight_v': {'title': 20, 'text': 10, 'tags': 30}};

/*
Illogical stemming
*/

var tipuesearch_stem_exclude = {'words': [
     'light',
     'pole',
     'hollow'
     ]};

/*
Related
*/

var tipuesearch_related = {'Related': [
     {'search': 'tipue', 'related': ['Tipue Search', 'Tipue Drop', 'TipueMenu'], 'before': 'Tipue Search', 'after': 'Tipue Drop'},
     {'search': 'taming', 'related': ['handling', 'training'], 'before': 'handling', 'after': 'training'},
     {'search': 'matrix', 'related': ['matrix multiplication', 'matrix addition', 'matrix inverse', 'matrix transpose'], 'before': 'Matrix', 'after': 'Matrix inverse'}
]};

/*
Internals
*/

// timer for showTime
var startTimer = new Date().getTime();
