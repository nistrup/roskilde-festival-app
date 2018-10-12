import UIKit
import SafariServices

class GamesViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addGameTextField: UITextField!
    
    var games: [String] = ["Ølbowling 🎳", "Træmand 🃏", "Meyer 🎲", "Ølstafet 🏃‍♂️", "Kongespil 👑", "Wizard 🧙‍♂️", "Kewle 🍻", "Beer pong 🏓"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    
    @IBAction func addButtonTapped(_ sender: YTRoundedButton) {
        insertNewGameTitle()
    }
    
    
    func insertNewGameTitle() {
        
        if addGameTextField.text!.isEmpty {
            print("Du har ikke skrevet noget navn din pølse..")
            return
        }
        
        games.append(addGameTextField.text!)
        
        let indexPath = IndexPath(row: games.count - 1, section: 0)
        
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        
        addGameTextField.text = ""
        view.endEditing(true)
    }
    
    @IBAction func saveGamesOnPress(_ sender: UIButton) {
        
        let newGamesList = games
        let defaults = UserDefaults.standard
        defaults.set(newGamesList, forKey: "SavedGamesList")
        
    }
    
}


extension GamesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let gameTitle = games[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell") as! PlayerCell
        cell.playerTitle.text = gameTitle
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            games.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}
