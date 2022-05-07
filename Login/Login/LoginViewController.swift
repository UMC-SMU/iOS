//
//  LoginViewController.swift
//  Login
//
//  Created by 문정호 on 2022/03/29.
//

import UIKit

class LoginViewController: UIViewController {

    var email = String()
    var password = String()
    var userInfo: UserInfo?
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAttribute()
        // Do any additional setup after loading the view.
    }
    @IBAction func emailTextFieldEditingChanged(_ sender: UITextField) {
        //옵셔널
        //값이 있을수도 있고 없을수도 있고
        //본 실습에서는 강제로 빈 텍스트를 넘겨서 사용
        let text = sender.text ?? ""
        
        self.loginButton.backgroundColor = text.isValidEmail() ? UIColor(named: "facebookColor") : UIColor(named: "disabledButtonColor")
        
        self.email = text
        
    }
    @IBAction func pwTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        
        self.loginButton.backgroundColor = text.count > 2 ? UIColor(named: "facebookColor") : UIColor(named: "disabledButtonColor")
        
        self.password = text
    }
    @IBAction func loginButtonDidTap(_ sender: UIButton) {
        // 회원가입정보를 전달받아서, 그것과 textField와 데이터가 일치하면
        // 로그인 되어야한다.
        guard let userInfo = self.userInfo else {
            return
        }
        if self.email == userInfo.email && self.password == userInfo.password{
            let vc = storyboard?.instantiateViewController(withIdentifier: "TabBC")as! UITabBarController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        //화면전환
        //1.스토리보드 생성
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //2.뷰컨트롤러 생성
        let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewController
        //3. 화면전환 메소드를 사용하여 화면을 전환
//        self.present(registerViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(registerViewController, animated: true)
        
        //ARC -> 강한참조 / 약한참조
        registerViewController.userInfo = {[weak self](userInfo)in
            self?.userInfo = userInfo
        }
    }
    
    private func setupAttribute(){
        
        let text1 = "계정이 없으신가요?"
        let text2 = "가입하기"
        
        let font1 = UIFont.systemFont(ofSize: 13)
        let font2 = UIFont.boldSystemFont(ofSize: 13)
        
        let color1 = UIColor.darkGray
        let color2 = UIColor(named:"facebookColor")!
        
        let attributes = generateButtonAttribute(registerButton,
                                                 texts: text1,text2,
                                                 fonts: font1, font2,
                                                 colors: color1, color2)
        self.registerButton.setAttributedTitle(attributes, for: .normal)
    }
}
