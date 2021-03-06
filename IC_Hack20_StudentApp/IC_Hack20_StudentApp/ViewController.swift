//
//  ViewController.swift
//  IC_Hack20_StudentApp
//
//  Created by Zoë Despature on 8/2/20.
//  Copyright © 2020 Zoë Despature. All rights reserved.
//

import UIKit
//import URLSession

class ViewController: UIViewController, UITextFieldDelegate {
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ClassIDNameLabel: UILabel!
      
    var ip: String = ""
    var port: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
    }
    
    
//    Editor placeholder in source file
    @IBAction func SeekURL(_ sender: Any) {
        print("HellO")
        let text: String = nameTextField.text!
        print(text) //this prints My text
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let json_data = String(data: data, encoding: .utf8)!
            self.json_dealer(stringValue: json_data)
        }
        
        task.resume()
//        connectToLesson()
    }
    
    func json_dealer(stringValue: String) {
        let stringValue = "{\"name\": \"test\",\"code\": \"abcd\",\"ip\": \"192.168.1.1\",\"port\": 2000}"
//        let stringValue = "{\"error\":\"invalid code\"}"
        

        let data = stringValue.data(using: .utf8)!
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String:Any]
            {
                print("Good json", json)
                if let name = json["name"] {
                    ip = json["ip"] as! String
                    port = json["port"] as! Int
                    // open socket with ip address and port
                    // print text from socket to screen
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "OpenSecondScreen", sender: nil)
                        
                    }
                    
                    print(name)
                } else {
                    // tell user the code is wrong
                    print("fail")
                }
            } else {
                print("Error parsing json","bad json")
            }
        } catch let error as NSError {
            print("ewtyewytyetwytewytewtewytew",error)
        }
        print(data)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is SecondViewController
        {
            let vc = segue.destination as? SecondViewController
            vc?.ip = ip
            vc?.port = port
        }
    }
}

