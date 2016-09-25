// ClassifierViewController.swift
//
// Original Author: Ayaka Nonaka
// Modified by: Syed Ali Hashim Moosavi
//

import Foundation
import UIKit
import Parsimmon

class ClassifierViewController: UIViewController {
    @IBOutlet fileprivate weak var messageTextField: UITextField!
    @IBOutlet fileprivate weak var resultLabel: UILabel!
    
    let stopwords = ["a", "about", "above", "across", "after", "afterwards", "again", "against", "all", "almost", "alone", "along", "already", "also","although","always","am","among", "amongst", "amoungst", "amount", "an", "and", "another", "any","anyhow","anyone","anything","anyway", "anywhere", "are", "around", "as", "at", "back","be","became", "because","become","becomes", "becoming", "been", "before", "beforehand", "behind", "being", "below", "beside", "besides", "between", "beyond", "bill", "both", "bottom","but", "by", //"call",
        "can", "cannot", "cant", "co", "con", "could", "couldnt", "cry", "de", "describe", "detail", "do", "done", "down", "due", "during", "each", "eg", "eight", "either", "eleven","else", "elsewhere", "empty", "enough", "etc", "even", "ever", "every", "everyone", "everything", "everywhere", "except", "few", "fifteen", "fify", "fill", "find", "fire", "first", "five", "for", "former", "formerly", "forty", "found", "four", "from", "front", "full", "further", "get", "give", "go", "had", "has", "hasnt", "have", "he", "hence", "her", "here", "hereafter", "hereby", "herein", "hereupon", "hers", "herself", "him", "himself", "his", "how", "however", "hundred", "ie", "if", "in", "inc", "indeed", "interest", "into", "is", "it", "its", "itself", "keep", "last", "latter", "latterly", "least", "less", "ltd", "made", "many", "may", "me", "meanwhile", "might", "mill", "mine", "more", "moreover", "most", "mostly", "move", "much", "must", "my", "myself", "name", "namely", "neither", "never", "nevertheless", //"next",
        "nine", "no", "nobody", "none", "noone", "nor", "not", "nothing", "now", "nowhere", "of", "off", "often", "on", "once", "one", "only", "onto", "or", "other", "others", "otherwise", "our", "ours", "ourselves", "out", "over", "own","part", "per", "perhaps", "please", "put", "rather", "re", "same", "see", "seem", "seemed", "seeming", "seems", "serious", "several", "she", "should", "show", "side", "since", "sincere", "six", "sixty", "so", "some", "somehow", "someone", "something", "sometime", "sometimes", "somewhere", "still", "such", "system", "take", "ten", "than", "that", "the", "their", "them", "themselves", "then", "thence", "there", "thereafter", "thereby", "therefore", "therein", "thereupon", "these", "they", "thick", "thin", "third", "this", "those", "though", "three", "through", "throughout", "thru", "thus", "to", "together", "too", "top", "toward", "towards", "twelve", "twenty", "two", "un", "under", "until", "up", "upon", "us", "very", "via", "was", "we", "well", "were", "what", "whatever", "when", "whence", "whenever", "where", "whereafter", "whereas", "whereby", "wherein", "whereupon", "wherever", "whether", "which", "while", "whither", "who", "whoever", "whole", "whom", "whose", "why", "will", "with", "within", "without", "would", "yet", "you", "your", "yours", "yourself", "yourselves"];
    
    fileprivate var classifier = NaiveBayesClassifier.init()

    @IBAction fileprivate func spamOrHamAction(_ sender: UIButton) {
        guard let inputtext = messageTextField.text else { return }
        
        let textToClassify = filteredSentence(sentence: inputtext)
        
        let category = classifier.classify(textToClassify)
        
        resultLabel.text = category
    }

    fileprivate func train() {
        
        // WORK DETAIL
        
        let workdetail = ["Show me the next work order", "What is my next job", "Show me my next job", "What is my closest work order", "Show me the job closest to me"]
        
        for sentence in workdetail {
            
            let trainingsentence = filteredSentence(sentence: sentence)
            
            print(trainingsentence + " for work detail ")

            classifier.trainWithText(trainingsentence, category: "workdetail")
        }
        
        // START JOB
        
        let startjob = ["Start job", "Open job", "Please start job for me", "Can you start the job right now", "Please begin job"]
        
        for sentence in startjob {
            
            let trainingsentence = filteredSentence(sentence: sentence)

            print(trainingsentence + " for start jobs ")

            classifier.trainWithText(trainingsentence, category: "startjobs")
        }
        
        // GREETING
        
        let greeting =  ["Hello hello", "Hi hi", "Howdy", "Yo yo", "Good morning"]
        
        for sentence in greeting {
            let trainingsentence = filteredSentence(sentence: sentence)
            
            print(trainingsentence + " for greeting ")
            
            classifier.trainWithText(trainingsentence, category: "greeting")
        }
        
        // START TRAVEL
        
        let starttravel = ["Start traveling",
                           "Start travelling",
                           "Start travel",
                           "Begin travel",
                           "Let us travel"]
        
        for sentence in starttravel {

            let trainingsentence = filteredSentence(sentence: sentence)
            
            print(trainingsentence + " for start travel ")

            classifier.trainWithText(trainingsentence, category: "starttravel")
        }
        
        // CALL
        
        let call = ["Call for help", "Call someone for help", "Help! Call someone", "Call Joe", "Call Friend"]
        
        for sentence in call {
            
            let trainingsentence = filteredSentence(sentence: sentence)
            
            print(trainingsentence + " for call ")

            classifier.trainWithText(trainingsentence, category: "call")
        }
    }
    
    func filteredSentence(sentence: String) -> String
    {
        var trainingsentence = sentence
        
        for stopword in stopwords {
            
            var regex = try! NSRegularExpression(pattern: " \\b" + stopword +  "\\b ", options: .caseInsensitive)
            trainingsentence = regex.stringByReplacingMatches(in: trainingsentence, options: [], range: NSRange(0..<trainingsentence.utf16.count), withTemplate: " ")
            
            regex = try! NSRegularExpression(pattern: "\\b" + stopword +  "\\b ", options: .caseInsensitive)
            trainingsentence = regex.stringByReplacingMatches(in: trainingsentence, options: [], range: NSRange(0..<trainingsentence.utf16.count), withTemplate: "")
            
            regex = try! NSRegularExpression(pattern: " \\b" + stopword +  "\\b", options: .caseInsensitive)
            trainingsentence = regex.stringByReplacingMatches(in: trainingsentence, options: [], range: NSRange(0..<trainingsentence.utf16.count), withTemplate: "")
        }
        
        return trainingsentence
    }
}

extension ClassifierViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        train()
    }
}
