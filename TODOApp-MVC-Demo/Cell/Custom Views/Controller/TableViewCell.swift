//
//  TableViewCell.swift
//  TODOApp-MVC-Demo
//
//  Created by IDE Academy on 11/1/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit
protocol deleteCellFromTableView {
    func isFiledDeleted(isDeleted:Bool)
}
class TableViewCell: UITableViewCell {

  
    @IBOutlet weak var noteLable: UILabel!
    var taskID:String = "5"
    var flag = false
    var isDeletedDelegate:deleteCellFromTableView?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
   
    func deleteTodoFromApi(taskID:String) {
        print("Trying to Call Delete API")
        APIManager.deleteToDoAPIRouter(taskID: taskID){(response) in
            
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                if result .success{
                    print(result.success)
                    print("Selected Item has been Deleted Successfully")
                    self.flag = true
                    self.isDeletedDelegate?.isFiledDeleted(isDeleted: self.flag)
                    self.flag = false
                }
                else {
                        self.flag = false
                        self.isDeletedDelegate?.isFiledDeleted(isDeleted: self.flag)
                        self.flag = true
                        print(result.success)
                     }
            }
        }
    }
    @IBAction func deleteToDo(_ sender: Any) {
       self.deleteTodoFromApi(taskID: taskID)
    }
    public func configureCell(description:String, taskID:String){
        self.noteLable.text = description
        self.taskID = taskID
    }
    
}
