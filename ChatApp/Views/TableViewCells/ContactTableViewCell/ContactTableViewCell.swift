//
//  ContactTableViewCell.swift
//  ChatApp
//
//  Created by Eray on 12.01.2020.
//  Copyright © 2020 Eray Alparslan. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullnameLabel: UILabel!
    var indexPath: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCellWith(fUser: FUser, indexPath: IndexPath){
        self.indexPath = indexPath
        imageFromData(pictureData: fUser.avatar) { (image) in
            if let profileImage = image{
                DispatchQueue.main.async {
                    self.fullnameLabel.text = fUser.fullname
                    self.profileImageView.image = profileImage
                }
            }
        }
    }
    
    private func addGestureToAvatar(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        tapGesture.numberOfTapsRequired = 1
        profileImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func avatarTapped(){
        
    }
}
