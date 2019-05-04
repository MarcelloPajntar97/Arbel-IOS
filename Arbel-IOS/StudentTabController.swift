//
//  StudentTabController.swift
//  Arbel-IOS
//
//  Created by Simone on 23/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import XLPagerTabStrip

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

class StudentTabController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchStudent: UISearchBar!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var studentsList: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    
//    var students = ["Piero Chiambretti", "Scemo Pagliaccio", "Marcello Pajntar", "Simone Ghisu", "Davide Coscino", "Salvatore Aranzulla", "Riccardo Mores", "Mauro Paffi", "Fabrizio Infante", "Eugenio De Medici"]
    
    var tableViewData = [cellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        elementStyle()
        
        tableViewData = [cellData(opened: false, title: "Nome Cognome", sectionData: ["Prova nota1"]),
                         cellData(opened: false, title: "Nome Cognome", sectionData: ["Prova nota2"]),
                         cellData(opened: false, title: "Nome Cognome", sectionData: ["Prova nota3"])]
    
        studentsList.dataSource = self
        studentsList.delegate = self
    }
    
    func elementStyle() {
        searchStudent.layer.masksToBounds = true
        searchStudent.backgroundColor = .white
        searchStudent.backgroundImage = nil
        searchStudent.layer.cornerRadius = 20
        
        searchView.layer.cornerRadius = 20
        searchView.layer.shadowColor = UIColor (red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4).cgColor
        searchView.layer.shadowOffset = CGSize (width: 0, height: 1.2)
        searchView.layer.shadowRadius = 1.4
        searchView.layer.shadowOpacity = 0.3
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        self.studentsList.contentInset = insets
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return (students.count)
        
        if tableViewData[section].opened == true {
            return tableViewData[section].sectionData.count + 1
        }
        else {
            return 1
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
        
        return (tableViewData.count)
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataIndex = indexPath.row - 1
        let numberRow = tableViewData.count
//        if indexPath.row == 0 {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "student") else {return StudentCell()}
////            cell.textLabel?.text = tableViewData[indexPath.section].title
//            cell.textLabel?.text = tableViewData[indexPath.section].title
////            cell.studentName?.text = students[indexPath.row]
//            return cell
//        }
//        else {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
//            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[dataIndex]
//            return cell
//        }
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "student") as! StudentCell
            cell.studentName?.text = tableViewData[indexPath.section].title
            return cell
        }
            
        else if indexPath.row == dataIndex {
            let cell = tableView.dequeueReusableCell(withIdentifier: "save") as! StudentCell
            return cell
        }
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StudentCell
            cell.noteUser?.text = tableViewData[indexPath.section].sectionData[dataIndex]
            return cell
        }
        
        
        
        
//        if indexPath.row == 9 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "save") as! StudentCell
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "student") as! StudentCell
//            cell.studentName?.text = students[indexPath.row]
//            return cell
//        }
        

        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            if tableViewData[indexPath.section].opened == true {
                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
            else{
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
            
//            performSegue(withIdentifier: "showDetail", sender: self)
        }
    }

    @IBAction func checkBoxTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1, delay: 0.01, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
            
        }) { (success) in
            sender.isSelected = !sender.isSelected
            UIView.animate(withDuration: 0.1, delay: 0.01, options: .curveLinear, animations: {
                sender.transform = .identity
            }, completion: nil)
        }
//        if sender.isSelected {
//            sender.isSelected = false
//        }
//        else {
//            sender.isSelected = true
//        }
    }
}

extension StudentTabController : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Studenti")
    }
}
