//
//  MainVCPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by IDE Academy on 11/20/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
protocol ToodListViewModelProtocol {
    func loadAllUserTasksFromApi()
    func AddNewUserTask(newTask:String?)
    func checkIsDeletedOrNot(isDeleted:Bool)
    func setUpTableViewValues() -> ([String],[String])
}
class TodoListViewModel {
    var descriptionArr: [String] = []
    var idsArr: [String] = []
    weak var mainVC:TodoListVCProtocol!
    
    init(mainVC:TodoListVCProtocol) {
        self.mainVC = mainVC
    }
}
extension TodoListViewModel:ToodListViewModelProtocol{
    func checkIsDeletedOrNot(isDeleted:Bool) {
        self.mainVC.showLoader()
        if isDeleted{
            self.mainVC.presentError(message: "Selected Cell has been deleted Successfully", title: "Cell Deleted")
            loadAllUserTasksFromApi()
        }
        self.mainVC.hideLoader()
    }
    func setUpTableViewValues() -> ([String],[String]) {
        return  (self.descriptionArr,self.idsArr)
    }
    
    func loadAllUserTasksFromApi() {
        print("Trying to Call The API from load all tasks func ")
        self.mainVC.showLoader()
        
        APIManager.getAllToDosAPIRouter(){(response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                self.descriptionArr = []
                self.idsArr = []
                for todo in result.data{
                    self.descriptionArr.append(todo.description)
                    self.idsArr.append(todo._id)
                }
                self.mainVC.setUpNotesTableViewValues()
                print(self.descriptionArr.count)
               self.mainVC.reloadTableViewData()
            }
            self.mainVC.hideLoader()
        }
    }
    
    func AddNewUserTask(newTask:String?) {
        guard let newToDo = newTask?.trimmed, !newToDo.isEmpty  else {
            self.mainVC.presentError(message: "Please Enter New To Do", title: "Sorry")
            return }
        print("Trying to Call The API from add new task func ")
        self.mainVC.showLoader()
        APIManager.addNewToDoAPIRouter(description: newToDo){(response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                print(result.data.description)
                print(result.data._id)
                self.loadAllUserTasksFromApi()
            }
            self.mainVC.hideLoader()
        }
        
    }
}
