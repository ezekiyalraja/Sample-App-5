//
//  ViewController.swift
//  Sample App 5
//
//  Created by TechUnity IOS Developer on 09/09/22.
//

import UIKit
import Alamofire
import Foundation
protocol Mydelegate {
    var PassString: String? { get set }
    func MyFunc()
   
    
}
struct Point {
    var x = 5, y = 0
    mutating func moveToX(x: Int, andY y:Int) { //Needs to be a mutating method in order to work
        self.x = x
        self.y = y
    }
}

struct name:Decodable
{
    var resultCount = Int()
    var results = [result]()
}
struct result:Decodable
{
    var artistId = Int()
}
class ViewController: UIViewController,Mydelegate {
    func MyFunc() {
        PassString = "Function called"
        self.view.backgroundColor = .green
    }
    
    var PassString: String?
    var delegate:Mydelegate?
    func toggle() {
        print("1")
    }
    @IBOutlet weak var Iv: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("jj")
        
        var a = Point(x: 25,y: 45)
        a.moveToX(x: 56, andY: 54)
        print(a)
        self.Iv.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300)
        let accessToken = "employee1"
        let data = Data(accessToken.utf8)
        KeychainHelper.standard.save(data, service: "name1", account: "employee")
//        let data1 = KeychainHelper.standard.read(service: "name", account: "employee")!
//        let accessToken1 = String(data: data1, encoding: .utf8)!
//        print(accessToken1)
        Iv.isUserInteractionEnabled = true
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(pinchImage(sender:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
//        self.view.addGestureRecognizer(swipeDown)
        Iv.addGestureRecognizer(swipeDown)
        
    }
    

    @objc func pinchImage(sender: UIPinchGestureRecognizer) {
//        guard case let sender.view != nil else { return }
        if Iv.frame.size.height < 301
        {
            
        print("pinched")
//        Iv.alpha = 0
//        Iv.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: 0.3) {
//            self.Iv.transform = .identity
//            self.Iv.alpha = 1
//
            self.Iv.frame = CGRect(x: 30, y: self.view.frame.size.height/2 - 175, width: self.view.frame.size.width - 60, height: 350)
            let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.pinchImageclose(sender:)))
            swipeDown.direction = UISwipeGestureRecognizer.Direction.up
    //        self.view.addGestureRecognizer(swipeDown)
            self.Iv.addGestureRecognizer(swipeDown)

        }
        }
        }
 
@objc func pinchImageclose(sender: UIPinchGestureRecognizer) {
    UIView.animate(withDuration: 0.3) {
//        self.Iv.transform = .identity
        self.Iv.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300)
    }
}
    override func viewWillAppear(_ animated: Bool) {
        var emp: Employee = Employee(firstname: "Robert",lastname: "Mugambo")
        let stringArray = ["Bob", "Dan", "Bryan"]
        let string = stringArray.joined(separator: ",")

        print(string) // prints: "BobDanBryan"
        emp.firstname = "Cosmic"
        emp.lastname  = "Dragon"
        emp.printDetails()
        
    }
    @IBAction func NavigateFunc(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func loadJsonData()
       {
           AF.request("https://itunes.apple.com/search?media=music&term=bollywood").responseDecodable(of:name.self){ (response) in
               print("Response.result.value \(response)")
           }
       }
    final class KeychainHelper {
        
        static let standard = KeychainHelper()
        private init() {}
        
        // Class implementation here...
        func save(_ data: Data, service: String, account: String) {
            
            // Create query
            let query = [
                kSecValueData: data,
                kSecClass: kSecClassGenericPassword,
                kSecAttrService: service,
                kSecAttrAccount: account,
            ] as CFDictionary
            
            // Add data in query to keychain
            let status = SecItemAdd(query, nil)
            
            if status != errSecSuccess {
                // Print out the error
                print("Error: \(status)")
            }
        }
        
        func read(service: String, account: String) -> Data? {
            
            let query = [
                kSecAttrService: service,
                kSecAttrAccount: account,
                kSecClass: kSecClassGenericPassword,
                kSecReturnData: true
            ] as CFDictionary
            
            var result: AnyObject?
            SecItemCopyMatching(query, &result)
            
            return (result as? Data)
        }
    }
    
}
