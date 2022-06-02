//
//  SecondViewController.swift
//  DelegatePractice
//
//  Created by 문정호 on 2022/04/04.
//

import UIKit

class SecondViewController: UIViewController, ChangeLabelDelegate {
    func dochange() {
        previousViewController?.label.text = self.TextField.text
    }
    

    @IBOutlet weak var TextField: UITextField!
    var previousViewController : ViewController?
    
    @IBAction func buttonDismiss(_ sender: UIButton) {
        dochange()
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        previousViewController?.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
