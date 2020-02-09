//
//  ViewController2.swift
//  IC_Hack20_StudentApp
//
//  Created by Zoë Despature on 8/2/20.
//  Copyright © 2020 Zoë Despature. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textView: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
//    
//    @IBAction func SeekURL(_ sender: Any) {
//        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
//
//        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
//            guard let data = data else { return }
//            let json_data = String(data: data, encoding: .utf8)!
//            self.json_dealer(stringValue: json_data)
//        }
        
//        task.resume()
//        //        connectToLesson()
//    }
    
//    func json_dealer(stringValue: String) {
//        let stringValue = "{\"name\": \"test\",\"code\": \"abcd\",\"ip\": \"192.168.1.1\",\"port\": 2000}"
//                let stringValue = "{\"error\":\"invalid code\"}"
//
//
//        let data = stringValue.data(using: .utf8)!
//        do {
//            if let json = try JSONSerialization.jsonObject(with: data) as? [String:Any]
//            {
//                print("Good json", json)
//
//                let ip = json["ip"]
//                let port = json["port"]
//            }
//        }
//    }
    
    
    
    /*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destination.
         Pass the selected object to the new view controller.
    }
    */

}
