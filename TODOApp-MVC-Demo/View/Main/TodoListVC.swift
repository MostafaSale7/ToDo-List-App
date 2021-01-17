//
//  ViewController.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit
protocol MainStateDelegate:class {
    func showAuthenticationState()
}
protocol TodoListVCProtocol: class {
    func presentError(message: String, title:String) 
    func showLoader()
    func hideLoader()
    func reloadTableViewData()
    func setUpNotesTableViewValues()
}
class TodoListVC: UIViewController {
    
    @IBOutlet weak var notesTableView: UITableView!
    var newTaskTextFiled:UITextField?
    var allToDosArr:[String] = []
    var taskID:[String] = []
    var todoListViewModel:TodoListViewModel!
    var mainStateDelegate:MainStateDelegate?
    
   
    fileprivate let cellIdentifire = "TableViewCell"
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableViewController()
    }
    // MARK:- Public Methods
    class func create() -> TodoListVC {
        let todoListVC: TodoListVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.todoListVC)
        todoListVC.todoListViewModel = TodoListViewModel(mainVC: todoListVC)
        return todoListVC
    }
    
     // MARK:- Private Methods
    private func setUpTableViewController(){
        initTableView()
        setUpNavigationBar()
        createLeftButtonInNavigationBar()
        createRightButtonInNavigationBar()
        self.todoListViewModel.loadAllUserTasksFromApi()
    }
    private func initTableView(){
        notesTableView.register(UINib.init(nibName: ViewControllers.tableViewCell , bundle: nil), forCellReuseIdentifier: cellIdentifire)
        notesTableView.delegate = self
        notesTableView.dataSource = self
    }
    private func setUpNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationItem.hidesBackButton = true
    }
   private func createRightButtonInNavigationBar() {
        let addingButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddNewTaskTapped))
        self.navigationItem.rightBarButtonItem = addingButton
    }
   @objc func AddNewTaskTapped(_ sender:UIBarButtonItem){
        displayAlertAction()
    }
    private func createLeftButtonInNavigationBar() {
        let profileButton = UIButton(type: .custom)
        profileButton.setImage(#imageLiteral(resourceName: "profile").withRenderingMode(.alwaysOriginal), for: .normal)
        profileButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: profileButton), animated: true)
    }
    @objc func profileButtonTapped(_ sender:UIBarButtonItem){
        let profileVC = ProfileVC.createTableviewController()
        profileVC.profilenavigationDelegate = self
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    private func displayAlertAction() {
        let alertController = UIAlertController(title: "Add New Task", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: newTaskTextFiled)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: self.okHandler)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController,animated: true)
    }
    private func okHandler(alert:UIAlertAction) {
        self.todoListViewModel.AddNewUserTask(newTask: newTaskTextFiled?.text)
    }
    private func newTaskTextFiled(textFiled:UITextField) {
         newTaskTextFiled?.placeholder = "Add Your New To Do List"
         newTaskTextFiled = textFiled
    }
}
extension TodoListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allToDosArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
        guard let cell = notesTableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath) as? TableViewCell else{
             print("Can't put Results in TableView")
            return UITableViewCell()
        }
            cell.configureCell(description: allToDosArr[indexPath.row].description, taskID: taskID[indexPath.row])
        cell.isDeletedDelegate = self
         return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension TodoListVC:deleteCellFromTableView,TodoListVCProtocol{
    func setUpNotesTableViewValues() {
        let result = self.todoListViewModel.setUpTableViewValues()
        self.allToDosArr = result.0
        self.taskID = result.1
    }

    func reloadTableViewData() {
        self.notesTableView.reloadData()
    }
    func isFiledDeleted(isDeleted: Bool) {
          todoListViewModel.checkIsDeletedOrNot(isDeleted: isDeleted)
    }
    func showLoader() {
        self.view.showLoader()
    }
    func hideLoader() {
        self.view.hideLoader()
    }
    func presentError(message: String, title:String) {
        self.showAlert(title: title, message: message)
    }
}
extension TodoListVC:profileNavigationProtocol{
    func getMainStateDelegate() {
        self.mainStateDelegate?.showAuthenticationState()
    }
}
