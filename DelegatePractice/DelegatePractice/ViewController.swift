//
//  ViewController.swift
//  DelegatePractice
//
//  Created by 문정호 on 2022/04/04.
//

import UIKit

protocol ChangeLabelDelegate{
    func dochange()
}

class ViewController: UIViewController {

    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func buttonGoNextVC(_ sender: UIButton) {
        guard let nextVC = storyboard?.instantiateViewController(withIdentifier: "SecondViewController")as? SecondViewController else{
            return
        }
        nextVC.previousViewController = self
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true, completion: nil)
    }
    
    var delegate : ChangeLabelDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    

}

