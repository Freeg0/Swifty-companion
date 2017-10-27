//
//  SecondViewController.swift
//  Swify-Companion
//
//  Created by Julien MORI on 4/24/17.
//  Copyright © 2017 Julien MORI. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var token:String?
    var login:String?
    var api: APIController?
    var profile_pic:String?
    
    @IBOutlet weak var img_intra: UIImageView!

    @IBOutlet weak var picture_profil: UIImageView!
    
    @IBOutlet weak var login_profil: UILabel!

    @IBOutlet weak var cursus_lvl: UIProgressView!

    @IBOutlet weak var lvl_text: UILabel!
    
    @IBOutlet weak var Correction_point: UILabel!
    
    @IBOutlet weak var wallet: UILabel!
    
    @IBOutlet weak var tableViewSkills: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(api)
        guard let url = URL(string: (self.api?.profil_pic)!) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Failed fetching image:", error)
                return
            }
                
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Not a proper HTTPURLResponse or statusCode")
                return
            }
                
            DispatchQueue.main.async {
                self.picture_profil.image = UIImage(data: data!)
                self.login_profil.text = self.login
                self.cursus_lvl.transform = self.cursus_lvl.transform.scaledBy(x: 1, y: 10)
                self.lvl_text.text = self.api?.lvl
                let floatValue : Float = NSString(string: (self.api?.lvl)!).floatValue
                self.cursus_lvl.progress = floatValue - floatValue.rounded(.down)
                self.Correction_point.text = self.api?.correction_point
                self.wallet.text = self.api?.wallet
                //                print(self.api?.cursus_lvl)
                //                self.lvl_text.text = self.api?.cursus_lvl
            }
        }.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let skillsArray = self.api?.skills {
            return skillsArray.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewSkills.dequeueReusableCell(withIdentifier: "skillsCell") as? TableViewCellSkills
        print(self.api?.skills?[indexPath.row])
        cell?.skill = self.api?.skills?[indexPath.row] as? NSDictionary
        return cell!
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
