//
//  ViewController.swift
//  OpeninApp
//
//  Created by CodeInfoWay CodeInfoWay on 5/20/23.
//

import UIKit
import Alamofire
import Kingfisher


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblgreeting: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnToplink: UIButton!
    @IBOutlet weak var btnRecentlink: UIButton!

    var recentLinks: [[String: Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        let date = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: date)

        if currentHour < 12 {
            lblgreeting.text = "Good morning"
        } else if currentHour < 18 {
            lblgreeting.text = "Good afternoon"
        } else {
            lblgreeting.text = "Good evening"
        }

        fetchData()
    }
    func fetchData() {
        let url = "https://api.inopenapp.com/api/v1/dashboardNew"

        let headers: HTTPHeaders = [
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjU5MjcsImlhdCI6MTY3NDU1MDQ1MH0.dCkW0ox8tbjJA2GgUx2UEwNlbTZ7Rr38PVFJevYcXFI",
            "Content-Type": "application/json"
        ]
        AF.request(url,method: .get, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                DispatchQueue.main.async {
                if let json = value as? [String: Any],
                   let data = json["data"] as? [String: Any],
            
                   let recentLinks = data["recent_links"] as? [[String: Any]] {
                   
                       print("recentLinks ==  : \(recentLinks)")
                       self.recentLinks = recentLinks
                       self.tableView.reloadData()
                   
                }else{
                    print("value: \(value)")
                }
                }
            case .failure(let error):
                print("API request failed: \(error)")
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentLinks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
    
        let link = recentLinks[indexPath.row]

        cell.lblTital.text = link["title"] as? String ?? ""
        cell.lblDate.text = link["times_ago"] as? String
        cell.lblTotalClick.text = "\(link["total_clicks"] ?? 0)"
        cell.lblsempleLinkForCopyPast.text = link["web_link"] as? String
        if let imageUrlString = link["original_image"] as? String,
           let imageUrl = URL(string: imageUrlString) {
            cell.Userimage.kf.setImage(with: imageUrl)
       }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       }
    }
   

