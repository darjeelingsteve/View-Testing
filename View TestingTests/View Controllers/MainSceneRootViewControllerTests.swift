//
//  MainSceneRootViewControllerTests.swift
//  View TestingTests
//
//  Created by Stephen Anthony on 30/10/2022.
//

import XCTest
import DJATesting
@testable import View_Testing

final class MainSceneRootViewControllerTests: XCTestCase {
    private var mainSceneRootViewController: MainSceneRootViewController!
    private var mockNavigationController: MockNavigationController!
    private var testEmployee: Employee!
    
    override func setUp() {
        super.setUp()
        mockNavigationController = MockNavigationController()
        let employeeData = try! Data(contentsOf: Bundle(for: EmployeeOverviewView.self).url(forResource: "Employees", withExtension: "json")!)
        testEmployee = try! JSONDecoder().decode([Employee].self, from: employeeData).first
    }
    
    override func tearDown() {
        mainSceneRootViewController = nil
        mockNavigationController = nil
        testEmployee = nil
        super.tearDown()
    }
    
    private func givenAMainSceneRootViewController() {
        mainSceneRootViewController = MainSceneRootViewController(childNavigationController: mockNavigationController)
    }
    
    private func whenTheViewLoads() {
        mainSceneRootViewController.loadViewIfNeeded()
    }
    
    private func whenTheUserSelects(employee: Employee) {
        mainSceneRootViewController.employeeListViewController(EmployeeListViewController(), didSelectEmployee: testEmployee)
    }
}

// MARK: - Child View Controller Population
extension MainSceneRootViewControllerTests {
    func testItDisplaysAnEmployeeListViewControllerAsTheRootOfItsChildNavigationController() {
        givenAMainSceneRootViewController()
        whenTheViewLoads()
        XCTAssertEqual(mockNavigationController.receivedViewControllers?.count, 1)
        let childEmployeeListViewController = mockNavigationController.receivedViewControllers?[0] as! EmployeeListViewController
        XCTAssertIdentical(childEmployeeListViewController.delegate, mainSceneRootViewController)
    }
}

// MARK: - EmployeeListViewControllerDelegate
extension MainSceneRootViewControllerTests {
    func testItPushesAnEmployeeDetailsViewControllerWhenTheUserSelectsAnEmployee() {
        givenAMainSceneRootViewController()
        whenTheViewLoads()
        whenTheUserSelects(employee: testEmployee)
        let employeeDetailsViewController = mockNavigationController.pushedViewController as! EmployeeDetailsViewController
        XCTAssertEqual(employeeDetailsViewController.employee, testEmployee)
    }
}
