//
//  OutputViewController.swift
//  Roskilde 2018
//
//  Created by Peter Nistrup on 28/06/2018.
//  Copyright © 2018 Peter Nistrup. All rights reserved.
//

import UIKit

extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

extension Array {
    mutating func shuffle() {
        for i in 0 ..< (count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swapAt(i, j)
        }
    }
}

class OutputViewController: UIViewController {

    @IBOutlet weak var gameSelected: UILabel!
    @IBOutlet weak var valueLable: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var teamLabel: UILabel!
    
    var teamSizeVar = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
        if sender.value > 1 {
            var tekstJohn = "  Holdstørrelse: "
            tekstJohn += Int(sender.value).description
            valueLable.text = tekstJohn
        } else {
            valueLable.text = "  Alle mod alle >:)"
        }
        
        teamSizeVar = Int(sender.value)
        
    }
    
    
    @IBAction func makeTeams(_ sender: UIButton) {
        
        let teamSize = teamSizeVar
        
        let defaults = UserDefaults.standard
        var myPlayers = defaults.stringArray(forKey: "SavedPlayersList") ?? [String]()
        
        myPlayers.shuffle()
        let numberOfTeams = Int(Double(myPlayers.count / teamSize).rounded(.down))
        
        var teams: [[String]] = []
        
        for hold in 1...numberOfTeams {
            let teamTemp = myPlayers[((hold-1)*teamSize)..<(((hold-1)*teamSize)+teamSize)]
            let newTeam = Array(teamTemp)
            teams.append(newTeam)
            
        }
        
        if myPlayers.count % teamSize != 0 {
            
            var i = 0
            
            let modCount = Int(myPlayers.count) - numberOfTeams * teamSize
            
            if  modCount > numberOfTeams {
                
                let addTeam = myPlayers[numberOfTeams * teamSize ..< myPlayers.count]
                let newTeam = Array(addTeam)
                teams.append(newTeam)
                
            } else {
            
            
            for x in (teamSize * numberOfTeams)..<myPlayers.count {
                
                teams[i].append(myPlayers[x])
                i += 1
                
                }
                
            }
            
        }
        
        var myTeams = ""
        for k in 0..<teams.count {
            myTeams.append("Hold " + String(k + 1) + ": ")
            for n in 0..<teams[k].count {
                myTeams.append(teams[k][n] + ", ")
            }
            myTeams.append("\n")
        }
        
        teamLabel.text = myTeams
        
    }
    
    @IBAction func generateOutput(_ sender: UIButton) {
        
        let defaults = UserDefaults.standard
        let myGames = defaults.stringArray(forKey: "SavedGamesList") ?? [String]()
        
        gameSelected.text = myGames.randomItem()
    }
    }

}
