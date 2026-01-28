//
//  ViewController.swift
//  TestsPOC
//
//  Created by Uladzislau Makei on 14/01/2026.
//

import UIKit

class ViewController: UIViewController {
    private lazy var vcs: [UIViewController] = [
        ViewController1(),
        ViewController2(),
        ViewController3(),
        ViewController4(),
        ViewController5(),
        ViewController6(),
        ViewController7(),
        ViewController8(),
        ViewController9(),
        ViewController10(),
        ViewController11(),
    ]
    
    private lazy var stack: UIStackView = {
        var buttons: [UIButton] = []
        
        vcs.forEach { vc in
            let button = UIButton(type: .system)
            button.setTitle(vc.title ?? "Unknown", for: .normal)
            button.tag = Int(vc.title ?? "0") ?? 0
            button.addTarget(self, action: #selector(push(_:)), for: .touchUpInside)
            buttons.append(button)
        }
        
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vcs.forEach {
            $0.viewDidLoad()
        }
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    @objc private func push(_ sender: UIButton) {
        let vc = vcs[sender.tag - 1]
        present(vc, animated: true)
        
    }
}

class ViewController1: UIViewController {

    private var tappedIn: Bool = false
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitle("Button 1", for: .normal)
        button.addTarget(self, action: #selector(press), for: .touchUpInside)
        
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.systemOrange.cgColor
        button.layer.borderWidth = 1
        button.accessibilityIdentifier = "button1"
        button.backgroundColor = .systemBlue
        button.accessibilityTraits = [.button]
        
        
        return button
    }()
    
    @objc private func press() {
        !tappedIn ?
        button.setTitle("ButtonPressed 1", for: .normal) :
        button.setTitle("Button 1", for: .normal)
        tappedIn.toggle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "1"
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        button.frame = .init(origin: .zero, size: .init(width: 170, height: 70))
        button.center = view.center
    }
}

class ViewController2: UIViewController {

    private var tappedIn: Bool = false
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitle("Button 2", for: .normal)
        button.addTarget(self, action: #selector(press), for: .touchUpInside)
        
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.systemOrange.cgColor
        button.layer.borderWidth = 1
        button.accessibilityIdentifier = "button2"
        button.backgroundColor = .systemBlue
        button.accessibilityTraits = [.button]
        
        
        return button
    }()
    
    @objc private func press() {
        !tappedIn ?
        button.setTitle("ButtonPressed 2", for: .normal) :
        button.setTitle("Button 2", for: .normal)
        tappedIn.toggle()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "2"
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        button.frame = .init(origin: .zero, size: .init(width: 170, height: 70))
        button.center = view.center
    }
}

class ViewController3: UIViewController {

    private var tappedIn: Bool = false
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitle("Button 3", for: .normal)
        button.addTarget(self, action: #selector(press), for: .touchUpInside)
        
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.systemOrange.cgColor
        button.layer.borderWidth = 1
        button.accessibilityIdentifier = "button3"
        button.backgroundColor = .systemBlue
        button.accessibilityTraits = [.button]
        
        
        return button
    }()
    
    @objc private func press() {
        !tappedIn ?
        button.setTitle("ButtonPressed 3", for: .normal) :
        button.setTitle("Button 3", for: .normal)
        tappedIn.toggle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "3"
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        button.frame = .init(origin: .zero, size: .init(width: 170, height: 70))
        button.center = view.center
    }
}

class ViewController4: UIViewController {

    private var tappedIn: Bool = false
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitle("Button 4", for: .normal)
        button.addTarget(self, action: #selector(press), for: .touchUpInside)
        
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.systemOrange.cgColor
        button.layer.borderWidth = 1
        button.accessibilityIdentifier = "button4"
        button.backgroundColor = .systemBlue
        button.accessibilityTraits = [.button]
        
        
        return button
    }()
    
    @objc private func press() {
        !tappedIn ?
        button.setTitle("ButtonPressed 4", for: .normal) :
        button.setTitle("Button 4", for: .normal)
        tappedIn.toggle()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "4"
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        button.frame = .init(origin: .zero, size: .init(width: 170, height: 70))
        button.center = view.center
    }
}

class ViewController5: UIViewController {

    private var tappedIn: Bool = false
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitle("Button 5", for: .normal)
        button.addTarget(self, action: #selector(press), for: .touchUpInside)
        
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.systemOrange.cgColor
        button.layer.borderWidth = 1
        button.accessibilityIdentifier = "button5"
        button.backgroundColor = .systemBlue
        button.accessibilityTraits = [.button]
        
        
        return button
    }()
    
    @objc private func press() {
        !tappedIn ?
        button.setTitle("ButtonPressed 5", for: .normal) :
        button.setTitle("Button 5", for: .normal)
        tappedIn.toggle()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "5"
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        button.frame = .init(origin: .zero, size: .init(width: 170, height: 70))
        button.center = view.center
    }
}

class ViewController6: UIViewController {

    private var tappedIn: Bool = false
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitle("Button 6", for: .normal)
        button.addTarget(self, action: #selector(press), for: .touchUpInside)
        
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.systemOrange.cgColor
        button.layer.borderWidth = 1
        button.accessibilityIdentifier = "button6"
        button.backgroundColor = .systemBlue
        button.accessibilityTraits = [.button]
        
        
        return button
    }()
    
    @objc private func press() {
        !tappedIn ?
        button.setTitle("ButtonPressed 6", for: .normal) :
        button.setTitle("Button 6", for: .normal)
        tappedIn.toggle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "6"
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        button.frame = .init(origin: .zero, size: .init(width: 170, height: 70))
        button.center = view.center
    }
}

class ViewController7: UIViewController {

    private var tappedIn: Bool = false
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitle("Button 7", for: .normal)
        button.addTarget(self, action: #selector(press), for: .touchUpInside)
        
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.systemOrange.cgColor
        button.layer.borderWidth = 1
        button.accessibilityIdentifier = "button7"
        button.backgroundColor = .systemBlue
        button.accessibilityTraits = [.button]
        
        
        return button
    }()
    
    @objc private func press() {
        !tappedIn ?
        button.setTitle("ButtonPressed 7", for: .normal) :
        button.setTitle("Button 7", for: .normal)
        tappedIn.toggle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "7"
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        button.frame = .init(origin: .zero, size: .init(width: 170, height: 70))
        button.center = view.center
    }
}

class ViewController8: UIViewController {

    private var tappedIn: Bool = false
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitle("Button 8", for: .normal)
        button.addTarget(self, action: #selector(press), for: .touchUpInside)
        
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.systemOrange.cgColor
        button.layer.borderWidth = 1
        button.accessibilityIdentifier = "button8"
        button.backgroundColor = .systemBlue
        button.accessibilityTraits = [.button]
        
        
        return button
    }()
    
    @objc private func press() {
        !tappedIn ?
        button.setTitle("ButtonPressed 8", for: .normal) :
        button.setTitle("Button 8", for: .normal)
        tappedIn.toggle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "8"
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        button.frame = .init(origin: .zero, size: .init(width: 170, height: 70))
        button.center = view.center
    }
}

class ViewController9: UIViewController {

    private var tappedIn: Bool = false
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitle("Button 9", for: .normal)
        button.addTarget(self, action: #selector(press), for: .touchUpInside)
        
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.systemOrange.cgColor
        button.layer.borderWidth = 1
        button.accessibilityIdentifier = "button9"
        button.backgroundColor = .systemBlue
        button.accessibilityTraits = [.button]
        
        
        return button
    }()
    
    @objc private func press() {
        !tappedIn ?
        button.setTitle("ButtonPressed 9", for: .normal) :
        button.setTitle("Button 9", for: .normal)
        tappedIn.toggle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "9"
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        button.frame = .init(origin: .zero, size: .init(width: 170, height: 70))
        button.center = view.center
    }
}

class ViewController10: UIViewController {

    private var tappedIn: Bool = false
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitle("Button 10", for: .normal)
        button.addTarget(self, action: #selector(press), for: .touchUpInside)
        
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.systemOrange.cgColor
        button.layer.borderWidth = 1
        button.accessibilityIdentifier = "button10"
        button.backgroundColor = .systemBlue
        button.accessibilityTraits = [.button]
        
        
        return button
    }()
    
    @objc private func press() {
        !tappedIn ?
        button.setTitle("ButtonPressed 10", for: .normal) :
        button.setTitle("Button 10", for: .normal)
        tappedIn.toggle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "10"
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        button.frame = .init(origin: .zero, size: .init(width: 170, height: 70))
        button.center = view.center
    }
}

class ViewController11: UIViewController {

    private var tappedIn: Bool = false
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitle("Button 11", for: .normal)
        button.addTarget(self, action: #selector(press), for: .touchUpInside)
        
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.systemOrange.cgColor
        button.layer.borderWidth = 1
        button.accessibilityIdentifier = "button11"
        button.backgroundColor = .systemBlue
        button.accessibilityTraits = [.button]
        
        
        return button
    }()
    
    @objc private func press() {
        !tappedIn ?
        button.setTitle("ButtonPressed 11", for: .normal) :
        button.setTitle("Button 11", for: .normal)
        tappedIn.toggle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "11"
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        button.frame = .init(origin: .zero, size: .init(width: 170, height: 70))
        button.center = view.center
    }
}
