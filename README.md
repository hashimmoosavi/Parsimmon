# Parsimmon

Parsimmon is a wee linguistics toolkit for iOS written in Swift written by Ayaka Nonaka (https://github.com/ayanonagon). This toolkit has been modified by Hashim Moosavi to improve text classification of Naive Bayes through stop word filtering, implementing TF IDF etc.

## Examples

To start using Parsimmon:
```swift
import Parsimmon
```


### Tokenizer

```swift
let tokenizer = Tokenizer()
let tokens = tokenizer.tokenize("The quick brown fox jumps over the lazy dog")
print(tokens)
```

```
(
The,
quick,
brown,
fox,
jumps,
over,
the,
lazy,
dog
)
```


### Tagger

```swift
let tagger = Tagger()
let taggedTokens = tagger.tagWordsInText("The quick brown fox jumps over the lazy dog")
print(taggedTokens)
```

```
(
"('The', Determiner)",
"('quick', Adjective)",
"('brown', Adjective)",
"('fox', Noun)",
"('jumps', Noun)",
"('over', Preposition)",
"('the', Determiner)",
"('lazy', Adjective)",
"('dog', Noun)"
)
```


### Lemmatizer

```swift
let lemmatizer = Lemmatizer()
let lemmatizedTokens = lemmatizer.lemmatizeWordsInText("Diane, I'm holding in my hand a small box of chocolate bunnies.")
print(lemmatizedTokens)
```

```
(
diane,
i,
hold,
in,
my,
hand,
a,
small,
box,
of,
chocolate,
bunny
)
```


### Naive Bayes Classifier

```swift
let classifier = NaiveBayesClassifier()

// Train the classifier with some ham examples.
classifier.trainWithText("nom nom ham", category: "ham")
classifier.trainWithText("make sure to get the ham", category: "ham")
classifier.trainWithText("please put the eggs in the fridge", category: "ham")

// Train the classifier with some spam examples.
classifier.trainWithText("spammy spam spam", category: "spam")
classifier.trainWithText("what does the fox say?", category: "spam")
classifier.trainWithText("and fish go blub", category: "spam")

// Classify some new text. Is it ham or spam?
// In practice, you'd want to train with more examples first.
let firstExample = "use the eggs in the fridge."
let secondExample = "what does the fish say?"

print("\(firstExample) => \(classifier.classify(firstExample))")
print("\(secondExample) => \(classifier.classify(secondExample))")
```

```
'use the eggs in the fridge.' => ham
'what does the fish say?' => spam
```

License
----

MIT
