//
//  ViewController.swift
//  Swify-Companion
//
//  Created by Julien MORI on 4/18/17.
//  Copyright © 2017 Julien MORI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var api: APIController = APIController()
    var token:String?
    var login:String?
    let UID = "59deaf346e630b48a2c7c73829cf83378d2c69e5a5a1ab987dcf2849a525055b"
    let SECRET = "4e1b4058e8d677c013b2e7127ef06ab2cccb66457e944c61769c2816a31f21a5"
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var btn: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBAction func searchDataLoginAction(_ sender: UIButton) {
        if self.token != nil {
            print("in btn")
            self.login = loginTextField.text
            print(self.login!)
            self.api.getUserInfo(token: self.token!, login: self.login!) { user in
                if user != nil {
                    DispatchQueue.main.async {
                        self.errorLabel.text = ""
                        print("pac")
                        self.api.recupInfo()
                        self.performSegue(withIdentifier: "segueLoginInfo", sender: nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.errorLabel.text = "ERROR"
                    }
                }
            }
        }
    }
    
    func getToken() {
        let url = NSURL(string: "https://api.intra.42.fr/oauth/token")
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials&client_id=\(UID)&client_secret=\(SECRET)".data(using: String.Encoding.utf8)
        let task =  URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            print(response!)
            if error != nil {
                print(error!)
            }
            else if let d = data {
                do {
                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        print(dic)
                        if let t = dic["access_token"] as? String {
                            self.token = t
                        }
                        print("token = " + self.token!)
//                        completion(true)
                    }
                }
                catch (let err) {
                    print(err)
//                    completion(false)
                }
            }
        }
        task.resume()
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueLoginInfo" {
            if let tv = segue.destination as? SecondViewController {
                tv.token = self.token
                tv.login = loginTextField.text
                tv.api = self.api
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getToken()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//self.view.backgroundColor = UIColor(patternImage: getBackground())
//
//api42 = Api42()
//}
//
//private func getBackground() -> UIImage {
//    UIGraphicsBeginImageContext(self.view.frame.size)
//    
//    if UIDevice.current.orientation.isLandscape {
//        UIImage(named: "background_landscape")?.draw(in: self.view.bounds)
//    } else {
//        UIImage(named: "background_portrait")?.draw(in: self.view.bounds)
//    }
//    
//    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//    
//    UIGraphicsEndImageContext()
//    
//    return image
//}

