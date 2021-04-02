//
//  ViewController.swift
//  cryptoTracker
//
//  Created by Riddhi Patel on 3/9/21.
//

import UIKit

class ViewController: UIViewController {

    
    
    
    
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var outputField: UILabel!
    
   
    @IBAction func buttonPressed(_ sender: Any) {
        
        if let symbol = textField.text {
            getData(symbol: symbol)
    }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }





    var url = "https://min-api.cryptocompare.com/data/price?tsyms=USD"

    func getData(symbol: String) {
        
        url = "\(url)&fsym=\(symbol)"
        
        guard let url = URL(string : url) else { return }

       

        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
    
            guard let data = data, error == nil else {return}
    
            print("Data Received")

            do {
                let Result = try JSONDecoder().decode(APIResponse.self, from:  data)
                print(Result.USD)
        
        DispatchQueue.main.async {
                self.outputField.text = "\(Result.USD)"
            }

        }
        
        catch {
            print(error.localizedDescription)
        }
        
        
    }
    
    task.resume()

}

    struct APIResponse : Codable {
        let USD : Float
}
    



}
