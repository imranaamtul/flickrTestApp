//
//  ViewController.swift
//  flickrTestAPP
//
//  Created by amtul imrana on 20/11/22.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var jsonResult: [Item] = []
    
    //MARK: TableView
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MainVCCustomCell.self,forCellReuseIdentifier: MainVCCustomCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 110
        return tableView
    }()
    private var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter text to search.."
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.font = UIFont .italicSystemFont(ofSize: 17)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.becomeFirstResponder()
        textField.returnKeyType = .done
        return textField
    }()
    
    private var searchButton: UIButton = {
        let button = UIButton ()
        button.backgroundColor = .blue
        button.setTitle("Search", for: .normal)
        button.titleLabel?.font = UIFont .boldSystemFont (ofSize: 18)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 5
        button.addTarget (self, action: #selector(searchButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: configureViewa
    func configViews() {
        view.addSubview(searchTextField)
        view.addSubview (searchButton)
        view.addSubview (tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            searchTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),
            
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchButton.rightAnchor.constraint(equalTo: view.rightAnchor , constant: -20),
            searchButton.leftAnchor.constraint(equalTo: searchTextField.rightAnchor, constant: -10),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo:searchTextField.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc func searchButtonTapped() {
        let searchText = searchTextField.text ?? ""
        API.shared.fetchResults(searchText: searchText, completion: { (data) in
            DispatchQueue.main.async {
                self.jsonResult = data
                self.tableView.reloadData ()
            }
        })
    }
    // presents DetailsViewController
    func presentDetailsViewController (imageText: UIImage, descriptionText: String) {
        let newVC = DetailsViewController(imageText: imageText, descriptionText: descriptionText)
        navigationController?.pushViewController(newVC, animated: true)
    }
    // TableView Meathods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainVCCustomCell.identifier, for: indexPath) as! MainVCCustomCell
        let data = jsonResult[indexPath.row].title ?? "No title"
        guard let imageString = jsonResult[indexPath.row].media?.m else { return cell }
        let image = UIImage.init(url: imageString)
        guard let image = image else { return cell }
        cell.configureCellData(image: image, label: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let data = jsonResult[indexPath.row].tags ?? "No tags found"
        guard let imageString = jsonResult[indexPath.row].media?.m else { return }
        let image = UIImage.init(url: imageString)
        guard let image = image else { return }
        presentDetailsViewController(imageText: image, descriptionText: data)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad ()
        // Do any additional setup after loading the view.
        configViews ()
        self.title = "Photos"
        view.backgroundColor = .white
    }
}
extension UIImage {
    convenience init?(url: String) {
        guard let url = URL(string: url) else { return nil }
        do {
            self.init(data: try Data(contentsOf: url))
        } catch {
            print("Cannot load image from url: \(url) with error: \(error)")
            return nil
        }
    }
}






























