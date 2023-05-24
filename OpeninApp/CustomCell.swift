//
//  CustomCell.swift
//  OpeninApp
//
//  Created by CodeInfoWay CodeInfoWay on 5/23/23.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var lblTital: UILabel!
    @IBOutlet weak var Userimage: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTotalClick: UILabel!

    @IBOutlet weak var lblsempleLinkForCopyPast: UILabel!
    @IBOutlet weak var iblClick: UILabel!
    @IBOutlet weak var copyOnClick: UIImageView!
    
    @objc func copyOnClickTapped() {
        guard let textToCopy = lblsempleLinkForCopyPast.text else {
            return
        }
        UIPasteboard.general.string = textToCopy
    }
    override func awakeFromNib() {
        super.awakeFromNib()

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(copyOnClickTapped))
            copyOnClick.addGestureRecognizer(tapGesture)
            copyOnClick.isUserInteractionEnabled = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
}
