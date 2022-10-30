//
//  MainSceneRootViewController.swift
//  View Testing
//
//  Created by Stephen Anthony on 27/10/2022.
//

import UIKit

/// The view controller used to manage the main scene's UI.
final class MainSceneRootViewController: UIViewController {
    private let childNavigationController: UINavigationController
    
    init(childNavigationController: UINavigationController = UINavigationController()) {
        self.childNavigationController = childNavigationController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let employeeListViewController = EmployeeListViewController()
        employeeListViewController.delegate = self
        
        childNavigationController.viewControllers = [employeeListViewController]
        addChild(childNavigationController)
        view.addSubview(childNavigationController.view)
        childNavigationController.view.frame = view.bounds
        childNavigationController.didMove(toParent: self)
    }
}

// MARK: - EmployeeListViewControllerDelegate
extension MainSceneRootViewController: EmployeeListViewControllerDelegate {
    func employeeListViewController(_ employeeListViewController: EmployeeListViewController, didSelectEmployee employee: Employee) {
        childNavigationController.pushViewController(EmployeeDetailsViewController(employee: employee), animated: true)
    }
}
