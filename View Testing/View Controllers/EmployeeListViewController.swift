//
//  EmployeeListViewController.swift
//  View Testing
//
//  Created by Stephen Anthony on 27/10/2022.
//

import UIKit

/// The view controller responsible for showing the list of employees.
final class EmployeeListViewController: UIViewController {
    
    /// The delegate of the receiver.
    weak var delegate: EmployeeListViewControllerDelegate?
    
    private let employees: [Employee] = {
        let employeeData = try! Data(contentsOf: Bundle.main.url(forResource: "Employees", withExtension: "json")!)
        return try! JSONDecoder().decode([Employee].self, from: employeeData)
    }()
    
    private lazy var collectionView: UICollectionView = { [weak self] in
        let collectionViewLayout = UICollectionViewCompositionalLayout { (_, layoutEnvironment) -> NSCollectionLayoutSection? in
            .list(using: UICollectionLayoutListConfiguration(appearance: .insetGrouped), layoutEnvironment: layoutEnvironment)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.accessibilityIdentifier = "collection_view"
        return collectionView
    }()
    
    private let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Employee> { cell, _, employee in
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = employee.name
        cell.contentConfiguration = contentConfiguration
        cell.accessories = [.disclosureIndicator()]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Employees"
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension EmployeeListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        employees.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: employees[indexPath.item])
    }
}

// MARK: - UICollectionViewDelegate
extension EmployeeListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        delegate?.employeeListViewController(self, didSelectEmployee: employees[indexPath.item])
    }
}

/// The protocol to conform to for delegates of `EmployeeListViewController`.
protocol EmployeeListViewControllerDelegate: AnyObject {
    
    /// The message sent when the user selects an employee from the list.
    /// - Parameters:
    ///   - employeeListViewController: The controller sending the message.
    ///   - employee: The employee selected by the user.
    func employeeListViewController(_ employeeListViewController: EmployeeListViewController, didSelectEmployee employee: Employee)
}
