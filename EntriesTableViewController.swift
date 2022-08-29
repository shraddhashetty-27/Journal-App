//
//  EntriesTableViewController.swift
//  JournalApp
//
//  Created by Shraddha Shetty on 8/10/22.
//  Copyright © 2022 Shraddha Shetty. All rights reserved.
//

import UIKit
import CoreData

class EntriesTableViewController: UITableViewController {
    
    var entries: [Entry] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            
            let request:NSFetchRequest<Entry>=Entry.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "date",ascending: false)]
            if let entriesFromCoreData = try? context.fetch(request) as? [Entry]{
                entries = entriesFromCoreData
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let  cell=tableView.dequeueReusableCell(withIdentifier: "EntryCell") as? EntryTableViewCell{
            let entry=entries[indexPath.row]
        
            cell.entryTextlael.text=entry.text
            cell.monthLabel.text=entry.month()
            cell.dayLabel.text=entry.day()
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry=entries[indexPath.row]
        performSegue(withIdentifier: "segueToEntry", sender: entry)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let entryVC = segue.destination as? EntryViewController{
            if let entryToBeSent=sender as? Entry{
            entryVC.entry=entryToBeSent
            }
        }
    }
}
