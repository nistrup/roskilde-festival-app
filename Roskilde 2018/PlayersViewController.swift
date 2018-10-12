import UIKit
import SafariServices

class PlayersViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addPlayerTextField: UITextField!
    
    var players: [String] = ["Peter", "Jena", "Patrick",
                             "Christian", "Nicolas", "Hc",
                             "Caroline", "Sixten", "Luisa",
                             "Flemming", "Nanna"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    
    @IBAction func addButtonTapped(_ sender: YTRoundedButton) {
        insertNewPlayerTitle()
    }
    
    
    func insertNewPlayerTitle() {
        
        if addPlayerTextField.text!.isEmpty {
            print("Du har ikke skrevet noget navn din pølse..")
            return
        }
        
        players.append(addPlayerTextField.text!)
        
        let indexPath = IndexPath(row: players.count - 1, section: 0)
        
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        
        addPlayerTextField.text = ""
        view.endEditing(true)
    }
    
    @IBAction func savePlayersOnPress(_ sender: UIButton) {
        
        let newPlayersList = players
        let defaults = UserDefaults.standard
        defaults.set(newPlayersList, forKey: "SavedPlayersList")
        
    }

}


extension PlayersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let playerTitle = players[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell") as! PlayerCell
        cell.playerTitle.text = playerTitle
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            players.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}
