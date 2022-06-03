//
//  ViewController.swift
//  Pomodoro Timer v.3.0 final release
//
//  Created by Anatoliy on 03.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Pomodoro timer"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .red
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var timerLable: UILabel = {
        let lable = UILabel()
        var countSecond: Int = 0
        var countMinutes: Int = 0
        lable.text = "0\(countMinutes) : 0\(countSecond)"
        lable.font = UIFont.boldSystemFont(ofSize: 60)
        lable.textColor = .systemPink
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        
        return lable
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("WORK", for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 25
        button.tintColor = .systemPink
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var relaxButton: UIButton = {
        let button = UIButton()
        button.setTitle("RELAX", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 25
        button.tintColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var timer = Timer()
    var durationTimer = 1500
    var runningTimer = true
    var testTimer = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        targetButton()
    }
    
    private func setTimerLabel() {
        let countMinutes = Int(Double(durationTimer) / 60)
        let countSecond = durationTimer - (countMinutes * 60)
        var minuteString = String(countMinutes)
        var secondString = String(countSecond)
        
        if (countMinutes < 10) {
            minuteString = "0" + minuteString
        }
        
        if (countSecond < 10) {
            secondString = "0" + secondString
        }
        
        timerLable.text = minuteString + ":" + secondString
        
    }
    
    private func setTimerLabelRelax() {
        let countMinutes = Int(Double(testTimer) / 60)
        let countSecond = testTimer - (countMinutes * 60)
        var minuteString = String(countMinutes)
        var secondString = String(countSecond)
        
        if (countMinutes < 10) {
            minuteString = "0" + minuteString
        }
        
        if (countSecond < 10) {
            secondString = "0" + secondString
        }
        
        timerLable.text = minuteString + ":" + secondString
    }
    @objc private
    func timerAction() {
        setTimerLabel()
        durationTimer = durationTimer - 1
        if durationTimer == 0 - 1 {
            timer.invalidate()
            startButton.setTitle("WORK", for: .normal)
        }
        
    }
    
    @objc func timerActionRelax() {
        setTimerLabelRelax()
        testTimer = testTimer - 1
        if testTimer == 0 - 1 {
            timer.invalidate()
            relaxButton.setTitle("RELAX", for: .normal)
        }
    }
    
    @objc private func pauseStartButton() {
        timerLable.textColor = .systemPink
        if runningTimer == true {
            timer = Timer.scheduledTimer(timeInterval: 1 , target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            runningTimer = false
            startButton.setTitle("PAUSE", for: .normal)
        } else {
            timer.invalidate()
            runningTimer = true
            startButton.setTitle("WORK", for: .normal)
        }
    }
    
    @objc private func pauseStartButtonRelax() {
        timerLable.textColor = .systemGreen
        if runningTimer == true {
            timer = Timer.scheduledTimer(timeInterval: 1 , target: self, selector: #selector(timerActionRelax), userInfo: nil, repeats: true)
            runningTimer = false
            relaxButton.setTitle("PAUSE", for: .normal)
        } else {
            timer.invalidate()
            runningTimer = true
            relaxButton.setTitle("RELAX", for: .normal)
        }
    }
    
    private func targetButton() {
        relaxButton.addTarget(self, action: #selector(pauseStartButtonRelax), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(pauseStartButton), for: .touchUpInside)
    }
    
    private func setConstraints() {
        view.addSubview(timerLable)
        NSLayoutConstraint.activate([
            timerLable.topAnchor.constraint(equalTo: view.topAnchor, constant: 350),
            timerLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timerLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
        ])
        
        view.addSubview(startButton)
        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 70),
            startButton.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        view.addSubview(relaxButton)
        NSLayoutConstraint.activate([
            relaxButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            relaxButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            relaxButton.heightAnchor.constraint(equalToConstant: 70),
            relaxButton.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
