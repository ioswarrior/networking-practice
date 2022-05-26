//
//  CoursesViewController.swift
//  URLSessionDownloadImage
//
//  Created by Muller Alexander on 25.05.2022.
//

import UIKit

class CoursesViewController: UIViewController {
    
    private(set) lazy var coursesTableView = view as! CoursesTableView
    private var courses = [Course]()
    private var courseName: String?
    private var courseURL: String?
    
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
        let jsonUrlString =  "https://swiftbook.ru//wp-content/uploads/api/api_courses"
        //        let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_website_description"
        //        let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields"
        
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
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.courses = try decoder.decode([Course].self, from: data)
                
                // Для отображения данных в таблице необходимо эту таблицу перезагрузить
                // также в основной асинхронной очереди
#warning("Проверить reloadData()")
                DispatchQueue.main.async {
                    self.coursesTableView.reloadData()
                }
            } catch let error {
                print("Error serialization json:", error)
            }
        }.resume()
    }
    
    private func configureCell(cell: CoursesTableViewCell, for indexPath: IndexPath) {
        let course = courses[indexPath.row]
        cell.titleLabel.text = course.name
        
        if let numbersOfLessons = course.numberOfLessons {
            cell.numberOfLessonsLabel.text = "Number of lessons: \(numbersOfLessons)"
        }
        
        if let numberOfTests = course.numberOfTests {
            cell.numberOfTestsLabel.text = "Number of tests: \(numberOfTests)"
        }
        
        // Работа с данными, которую мы получаем из сети должна происходить асинхронно в глобальном потоке при этом обновление интерфейса должно происходить тоже асинхронно, но уже в основном потоке поэтому работу по получению данных мы переместим в глобальную очередь
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: course.imageUrl!) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            // Основная очередь (поток)
            DispatchQueue.main.async {
                cell.courseImageView.image = UIImage(data: imageData)
            }
        }
    }
}

extension CoursesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CoursesCell") as? CoursesTableViewCell else { preconditionFailure() }
        
        configureCell(cell: cell, for: indexPath)
        return cell
    }
}

extension CoursesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = courses[indexPath.row]
        courseURL = course.link
        courseName = course.name
        
        let webVC = WebViewController()
        webVC.selectedCourse = courseName
        
        if let url = courseURL {
            webVC.courseURL = url
        }
        
        navigationController?.pushViewController(webVC, animated: true)
    }
}
