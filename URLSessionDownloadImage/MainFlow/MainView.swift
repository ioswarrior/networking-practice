//
//  MainView.swift
//  URLSessionDownloadImage
//
//  Created by Muller Alexander on 22.05.2022.
//

import UIKit

class MainView: UIView {
    
    lazy var downloadImageButton: BigButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.configure(title: "Download image")
        $0.addTarget(self, action: #selector(downloadButtonDidTapped), for: .touchUpInside)
        return $0
    }(BigButton(frame: .zero))
    
    lazy var getButton: BigButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.configure(title: "Get")
        $0.addTarget(self, action: #selector(getRequestButtonDidTapped), for: .touchUpInside)
        return $0
    }(BigButton(frame: .zero))
    
    lazy var postButton: BigButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.configure(title: "Post")
        $0.addTarget(self, action: #selector(postRequestButtonDidTapped), for: .touchUpInside)
        return $0
    }(BigButton(frame: .zero))
    
    lazy var ourCourses: BigButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.configure(title: "Our Courses")
        $0.addTarget(self, action: #selector(ourCoursesRequestButtonDidTapped), for: .touchUpInside)
        return $0
    }(BigButton(frame: .zero))
    
    lazy var uploadImage: BigButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.configure(title: "Upload Image")
        
        return $0
    }(BigButton(frame: .zero))
    
    let buttonStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 20
        $0.distribution = .fillEqually
        
        return $0
    }(UIStackView(frame: .zero))
    
    weak var delegate: MainViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainView {
    private func setupConstraints() {
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(downloadImageButton)
        buttonStackView.addArrangedSubview(getButton)
        buttonStackView.addArrangedSubview(postButton)
        buttonStackView.addArrangedSubview(ourCourses)
        buttonStackView.addArrangedSubview(uploadImage)
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            buttonStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            layoutMarginsGuide.trailingAnchor.constraint(equalTo: buttonStackView.trailingAnchor),
            safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 40)
        ])
    }
}

protocol MainViewDelegate: AnyObject {
    func mainViewDownloadButton(_ mainView: MainView)
    func mainViewGetRequestButton(_ mainView: MainView)
    func mainViewPostRequestButton(_ mainView: MainView)
    func mainViewOurCoursesRequestButton(_ mainView: MainView)
}

extension MainView {
    @objc private func downloadButtonDidTapped(_ sender: UIButton) {
        delegate?.mainViewDownloadButton(self)
    }
    
    @objc private func getRequestButtonDidTapped(_ sender: UIButton) {
        delegate?.mainViewGetRequestButton(self)
    }
    
    @objc private func postRequestButtonDidTapped(_ sender: UIButton) {
        delegate?.mainViewPostRequestButton(self)
    }
    
    @objc private func ourCoursesRequestButtonDidTapped(_ sender: UIButton) {
        delegate?.mainViewOurCoursesRequestButton(self)
    }
}
