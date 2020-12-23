////
////  ChoosingLetter.swift
////  LMapp_for_VK
////
////  Created by Максим Лосев on 20.12.2020.
////
//
//import UIKit
//
//class ChoosingLetter: UIControl {
//    
////    var existingLetters:[String] = []
//
//    func collectLetters() -> [String] {
//        var letters:Set<Character> = []
//        for user in listOfUsers {
//            letters.insert(user.nickname.first!)
//        }
//        return letters.map({String($0)}).sorted()
//    }
//
//    var selectedLetter:String? = nil {
//        didSet {
//            self.updateSelectedLetter()
//            self.sendActions(for: .valueChanged)
//        }
//    }
//    
//    private var buttons:[UIButton] = []
//    private var stackView: UIStackView!
//    
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.setupView()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        self.setupView()
//    }
//
//    private func setupView() {
//        for letter in collectLetters() {
//            let button = UIButton(type: .system)
//            button.setTitle(letter, for: .normal)
//            button.setTitleColor(.lightGray, for: .normal)
//            button.setTitleColor(.darkGray, for: .selected)
//            button.addTarget(self, action: #selector(selectLetter(_:)), for: .allTouchEvents)
//            self.buttons.append(button)
//        }
//
//        stackView = UIStackView(arrangedSubviews: self.buttons)
//
//        self.addSubview(stackView)
//
//        stackView.spacing = 4
//        stackView.axis = .vertical
//        stackView.alignment = .center
//        stackView.distribution = .equalSpacing
//    }
//
//        private func updateSelectedLetter() {
//            for (index, button) in self.buttons.enumerated() {
//                let letter = collectLetters()[index]
//                button.isSelected = letter == self.selectedLetter
//            }
//        }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        stackView.frame = bounds
//    }
//
//    @objc private func selectLetter(_ sender: UIButton) {
//        guard let index = self.buttons.firstIndex(of: sender) else { return }
//        let letter = collectLetters()[index]
//        self.selectedLetter = letter
//
//    }
//
//    /*
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//    }
//    */
//
//}
