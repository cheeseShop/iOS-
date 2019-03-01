
import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    
    var usedWords = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //creating a new UIBarButtonItem to run promptForAnswer
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        
        //loading the array of words in 3 steps - finding the path to start.txt, loading the contents, and then splitting it into an array
        if let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt") {
            if let startWords = try? String(contentsOfFile: startWordsPath) {
                allWords = startWords.components(separatedBy: "/n")
            }
        } else {
            allWords = ["silkworm"]
        }
        
        startGame()
    }
    
    func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
        //reloadData
    }
    
    //methods to handle the table view data number of rows and cell for row at
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }

    //UIBarButtonItem actions require @objc mark
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        
        
        ac.addTextField()  //adds editable text input field to the UIAlertController
        
        
        //trailing closure syntax - anytime a method has a closure as its final parameter, can eliminate the final parameter name and pass it inside braces instead.  the code will run when the alert action is selected
        //everything before "in" describes the closure and everything after "in" IS the closure
        //self(the current view controller) and ac(Alert Controller) are captured as unowned references inside the closure meaning the closure can use them but wont create a strong reference cycle b/c the closure doesnt own either of them
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, ac] (action: UIAlertAction) in
            let answer = ac.textFields![0]
            self.submit(answer: answer.text!)
        }
        
        //addAction() is used to add UIAlertAction to UIAlertController
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func isPossible(word: String) -> Bool {
        
        //loop through every letter in player answer and see whether it exists in the start word.  If it does exist, remove the letter from the start word, then continue the loop
        var tempWord = title!.lowercased()
        
        
        for letter in word {
            if let pos = tempWord.range(of: String(letter)) {
                tempWord.remove(at: pos.lowerBound)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        
        //checking if the usedWords array contains the current word - using not operator so if word is new, it returns true
        return !usedWords.contains(word)
        
        
    }
    
    func isReal(word: String) -> Bool {
        if word.count <= 1 {
            return false
        }
        
    
        let checker = UITextChecker()  //iOS class designed to spot spelling errors
        let range = NSMakeRange(0, word.utf16.count) //NSMakeRange makes a string range(a start position and length)
        //utf16 is short for 16 bit Unicode Transformation Format
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        //calling rangeOfMisspelledWord method of UITextChecker
        
        
        return misspelledRange.location == NSNotFound
    }
    
    /*
    func showErrorMessage() {
        refactor all else statements in submit
    }
    */
    
    
    func submit(answer: String){
        //strings are case sensitve so making player's answer lowercase
        let lowerAnswer = answer.lowercased()
        
        
        let errorTitle: String
        let errorMessage: String
        
       
        
        if isPossible(word: lowerAnswer){
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    //code will execute only if all 3 if statements are true
                    usedWords.insert(answer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    
                    return
                } else {
                    errorTitle = "Word not recognized"
                    errorMessage = "You can't just make 'em up"
                }
            } else {
                errorTitle = "Word used already"
                errorMessage = "Be more original!"
            }
            
        } else {
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from '\(title!.lowercased())'!"
        }
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
        
    }
    

}

