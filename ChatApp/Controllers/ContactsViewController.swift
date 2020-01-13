//
//  Contacts.swift
//  ChatApp
//
//  Created by Eray on 12.01.2020.
//  Copyright © 2020 Eray Alparslan. All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD

class ContactsViewController: BaseViewController{
    @IBOutlet weak var tableView: UITableView!
    var allUsers: [FUser] = []
    var filteredUsers: [FUser] = []
    var allGroupedUsers: [String:[FUser]] = [:]
    var sectionTitleList: [String] = []
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        
        loadUsers(filter: kCITY)
    }
}

//MARK: UISearchResulstsUpdating
extension ContactsViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}


//MARK: UITableViewDelegate
extension ContactsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.String.TableViewCell.ContactTableViewCell) as? ContactTableViewCell{
            cell.updateCellWith(fUser: allUsers[indexPath.row], indexPath: indexPath)
            return cell
        }
        
        return UITableViewCell()
    }
}

//MARK: Helper Methods
extension ContactsViewController{
    private func setupViewController(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func filterContentForSearchText(searchText: String, scope: String = "All"){
        filteredUsers = allUsers.filter({ (user) -> Bool in
            return user.firstname.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    private func loadUsers(filter: String){
        ProgressHUD.show()
        var query: Query!
        
        switch filter {
        case kCITY:
            query = reference(.User).whereField(kCITY, isEqualTo: FUser.currentUser()!.city).order(by: kFIRSTNAME)
            
        case kCOUNTRY:
            query = reference(.User).whereField(kCOUNTRY, isEqualTo: FUser.currentUser()!.country).order(by: kCOUNTRY)
            
        default:
            query = reference(.User).order(by: kFIRSTNAME, descending: false)
        }
        
        query.getDocuments { (snapshot, error) in
            self.allUsers = []
            self.sectionTitleList = []
            self.allGroupedUsers = [:]
            
            ProgressHUD.dismiss()
            if error != nil {
                print(error!.localizedDescription)
                
                DispatchQueue.main.async {
                    ProgressHUD.showError(error!.localizedDescription)
                    self.tableView.reloadData()
                }
            }
            else{
                guard let snapshot = snapshot else { return }
                
                if !snapshot.isEmpty{
                    for userDictionary in snapshot.documents{
                        let userDictionary = userDictionary.data() as NSDictionary
                        let fUser = FUser.init(_dictionary: userDictionary)
                        
                        if fUser.objectId != FUser.currentId(){
                            self.allUsers.append(fUser)
                        }
                    }
                    
                    //split to groups
                }
                
                self.tableView.reloadData()
            }
        }
    }
}
