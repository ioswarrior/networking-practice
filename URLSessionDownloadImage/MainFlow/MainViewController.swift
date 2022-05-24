//
//  MainVCViewController.swift
//  URLSessionDownloadImage
//
//  Created by Muller Alexander on 22.05.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private(set) lazy var settedView = view as! MainView
    
    override func loadView() {
        view = MainView(frame: .zero)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        settedView.delegate = self
    }
    
    
}

extension MainViewController: MainViewDelegate {
    func mainViewDownloadButton(_ mainView: MainView) {
        let imageVC = ImageViewController(nibName: nil, bundle: nil)
        navigationController?.pushViewController(imageVC, animated: true)
    }
    
    func mainViewGetRequestButton(_ mainView: MainView) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            guard
                let response = response,
                let data = data
            else { return }
            print(data)
            print(response)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func mainViewPostRequestButton(_ mainView: MainView) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let userData = ["Couse" : "Networking", "Lesson" : "GET and POST Requests"]
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData, options: []) else { return }
        
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { data, response, error in
            
            guard let response = response, let data = data else { return }
            print(response)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
}
