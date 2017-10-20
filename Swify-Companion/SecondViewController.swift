//
//  SecondViewController.swift
//  Swify-Companion
//
//  Created by Julien MORI on 4/24/17.
//  Copyright © 2017 Julien MORI. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var token:String?
    var login:String?
    var api:APIController?
    var UserInfo:NSDictionary?
    
    var profile_pic:String?
    
    @IBOutlet weak var picture_profil: UIImageView!
    
    @IBOutlet weak var login_profil: UILabel!

    @IBOutlet weak var cursus_lvl: UIProgressView!

    @IBOutlet weak var lvl_text: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        api = APIController()
        print(self.token!)
        print(self.login!)
        self.UserInfo = [:]
        self.UserInfo = self.api?.getUserInfo(token: self.token!, login: self.login!)
        self.api?.recupInfo()
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
//                print(self.api?.cursus_lvl)
//                self.lvl_text.text = self.api?.cursus_lvl
            }
        }.resume()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
