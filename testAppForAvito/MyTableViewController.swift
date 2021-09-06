//
//  MyTableViewController.swift
//  testAppForAvito
//
//  Created by Роман on 03.09.2021.
//

import UIKit

class MyTableViewController: UITableViewController {

    var data: CurrentDataData?
    let network = NetworkDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        network.fetchCurrentData()
        network.delegate = self

        self.tableView.rowHeight = UITableView.automaticDimension
//        tableView.rowHeight = 150
        self.title = "Team of Developer"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data?.company.employees.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        
        guard let employees = data?.company.employees else {return cell}
        let employee = employees[indexPath.row]
        
        cell.nameLable.text = employee.name
        cell.numbeLable.text = employee.phone_number
        cell.skilsLable.text = employee.skills.joined(separator: ", ")
        cell.companyLable.text = data?.company.name
        return cell
    }
    
}


extension MyTableViewController: NetworkDataManagerDelegate{
    func updateInterface(_: NetworkDataManager, with currenData: CurrentData) {
        data = currenData.currentDataData
        tableView.reloadData()
    }
}
