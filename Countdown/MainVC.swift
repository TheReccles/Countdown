//
//  MainVC.swift
//  Countdown
//
//  Created by Richard Eccles on 12/30/16.
//  Copyright © 2016 Richard Eccles. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    //you have to tell the fetched results controller what kind of data we are going to be working with
    var controller: NSFetchedResultsController<Entry>!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //get entries from context
        //generateTestData()
        attemptFetch()
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //make sure to set identifier in storyboard for cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        
        return UITableViewCell()
    }
    
    func configureCell(cell: ItemCell, indexPath: NSIndexPath) {
        
        //update cell
        let entry = controller.object(at: indexPath as IndexPath)
        cell.configureCell(entry: entry)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = controller.sections {
            //get number of rows in section response
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller?.sections {
            
            return sections.count
        }
        
        return 0
    }
    
    func attemptFetch() {
        
        //fetch data
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        //sort data by dateEnd
        let dateSort = NSSortDescriptor(key: "dateEnd", ascending: true)
        
        fetchRequest.sortDescriptors = [dateSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        //add this to know what these methods know what to do
        controller.delegate = self
        
        //set the global controller to local contorller
        self.controller = controller
        
        //perform the fetch
        do{
            try controller.performFetch()
        }
        catch{
            let error = error as NSError
            print("\(error)")
        }
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "EntryDetailVC", sender: nil)
    }

    //whenever the table view is about to update, this will listen for changes and will handle it, need every time using core data
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    //whenever the table view has changed, need every time using core data
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    //listens for when we make a change (insert, delete, update), need this every time using core data
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type){
            
        case.insert:
            if let indexPath = newIndexPath{
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            }
            break
        case.update:
            
            if let indexPath = indexPath {
                print(indexPath)
                
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell
                // update the cell data
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
    }
    
    //generate some test core data
    func generateTestData(){
        //the context comes from appdelegate shortcut function we created
        let item = Entry(context: context)
        
        item.details = "Ricky Birthday"
        item.created = NSDate()
        item.dateEnd = NSDate()
        item.isRepeated = true
        
        let item2 = Entry(context: context)
        
        item2.details = "Bose Headphones"
        item2.created = NSDate()
        item2.dateEnd = NSDate()
        item2.isRepeated = false
        
        let item3 = Entry(context: context)
        
        item3.details = "Tesla Model S"
        item3.created = NSDate()
        item3.dateEnd = NSDate()
        item3.isRepeated = true
        
        //this is from appdelegate shortcut function and will save the core data to memory
        ad.saveContext()
        
    }
}

