//
//  RegisterViewController.swift
//  Login
//
//  Created by 문정호 on 2022/03/29.
//

import UIKit

class RegisterViewController: UIViewController {
//    MARK: - Properties
    var email: String = ""
    var name: String = ""
    var nickname: String = ""
    var password: String = ""
    
    var userInfo: ((UserInfo)->Void)?
    
    var isValidEmail = false{
        didSet{
            self.validateUserInfo()
        }
    }
    var isValidName = false{
        didSet{
            self.validateUserInfo()
        }
    }
    var isValidNickname = false{
        didSet{
            self.validateUserInfo()
        }
    }
    var isValidPassword = false{
        didSet{
            self.validateUserInfo()
        }
    }
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var popToLoginButton: UIButton!
    
    //TextField
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    
    var textField : [UITextField]{
        [emailTextField,nameTextField,passwordTextField,nicknameTextField]
    }
    
    //    MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupAttribute()
        registerButton.layer.cornerRadius = 5
        
        //bug fix
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        // Do any additional setup after loading the view.
    }
    
    
//    MARK: - Action
    @objc
    func textFieldEditingChanged(_sender:UITextField){
        let text = _sender.text ?? ""
        
        switch _sender{
        case emailTextField:
            self.isValidEmail = text.isValidEmail()
            self.email = text
        case nameTextField:
            self.isValidName = text.count>2
            self.name = text
        case nicknameTextField:
            self.isValidNickname = text.count>2
            self.nickname = text
        case passwordTextField:
            self.isValidPassword = text.isValidPassWord()
            self.password = text
        default:
            fatalError("Missing TextField")
        }
    }
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        let userInfo = UserInfo(email: self.email, name: self.name, nickname: self.nickname, password: self.password)
        
        self.userInfo?(userInfo)
    }
    
    @IBAction func backButtonDidTap(_ sender: UIBarButtonItem) {
        //뒤로가기
        self.navigationController?.popViewController(animated: true)
    }
    
//    MARK: - Helper
    private func setupTextField(){
        textField.forEach{ tf in
            tf.addTarget(self, action: #selector(textFieldEditingChanged(_sender:)), for: .editingChanged)
        }
    }
    
    private func validateUserInfo(){
        if isValidEmail&&isValidName&&isValidNickname&&isValidPassword{
            self.registerButton.isEnabled=true
            UIView.animate(withDuration: 0.33){
                self.registerButton.backgroundColor=UIColor(named: "facebookColor")
            }
            
            
        }
        else{
            self.registerButton.isEnabled=false
            UIView.animate(withDuration: 0.33){
                self.registerButton.backgroundColor=UIColor(named:"disabledButtonColor")
            }
            
            
        }
    }
    
    private func setupAttribute(){
        
        let text1 = "계정이 있으신가요?"
        let text2 = "로그인"
        
        let font1 = UIFont.systemFont(ofSize: 13)
        let font2 = UIFont.boldSystemFont(ofSize: 13)
        
        let color1 = UIColor.darkGray
        let color2 = UIColor(named:"facebookColor")!
        
        let attributes = generateButtonAttribute(popToLoginButton,
                                                 texts: text1,text2,
                                                 fonts: font1, font2,
                                                 colors: color1, color2)
        self.popToLoginButton.setAttributedTitle(attributes, for: .normal)
    }
}

//정규표현식
//확장은 클래스 외부에 위치시켜야 한다.
extension String{
        //소문자 한개, 대문자 한개, 특수문자 한개가 포함되어있는지 확인해서 맞으면 true 반환
        func isValidPassWord()->Bool{
            let regularExpression = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[\\d])(?=.*[~!@#\\$%\\^&\\*])[\\w~!@#\\$%\\^&\\*]{8,}$"
            let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
            
            return passwordValidation.evaluate(with: self)
        }
        
        //이메일 형식을 체크해서 맏으면 true 반환
        func isValidEmail() -> Bool{
            let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: self)
        }
    
    }
