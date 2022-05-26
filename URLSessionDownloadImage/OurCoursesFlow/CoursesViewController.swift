//
//  CoursesViewController.swift
//  URLSessionDownloadImage
//
//  Created by Muller Alexander on 25.05.2022.
//

import UIKit

class CoursesViewController: UIViewController {
    
    private(set) lazy var coursesTableView = view as! CoursesTableView
    
    override func loadView() {
        view = CoursesTableView(frame: .zero, style: .plain)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coursesTableView.dataSource = self
        coursesTableView.delegate = self
        fetchData()
    }
    
    func fetchData() {
        //        let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_course"
        //        let jsonUrlString =  "https://swiftbook.ru//wp-content/uploads/api/api_courses"
        //        let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_website_description"
        let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields"
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            //            do {
            //                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
            //                print("Описание курса: \(websiteDescription.courses)")
            //            } catch let error {
            //                 print("Error serialization json:", error)
            //            }
            
            do {
                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                print("\(websiteDescription.courses)")
            } catch let error {
                print("Error serialization json:", error)
            }
        }.resume()
    }
}

extension CoursesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CoursesCell") as? CoursesTableViewCell else { preconditionFailure() }
        
        return cell
    }
}

extension CoursesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
