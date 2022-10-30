//
//  EmployeeListViewControllerTests.swift
//  View TestingTests
//
//  Created by Stephen Anthony on 30/10/2022.
//

import XCTest
import DJATesting
@testable import View_Testing

final class EmployeeListViewControllerTests: XCTestCase {
    private var employeeListViewController: EmployeeListViewController!
    private var employees: [Employee]!
    private var mockDelegate: MockEmployeeListViewControllerDelegate!
    
    override func setUp() {
        super.setUp()
        let employeeData = try! Data(contentsOf: Bundle(for: EmployeeListViewController.self).url(forResource: "Employees", withExtension: "json")!)
        employees = try! JSONDecoder().decode([Employee].self, from: employeeData)
        mockDelegate = MockEmployeeListViewControllerDelegate()
    }
    
    override func tearDown() {
        employeeListViewController = nil
        employees = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    private func givenAnEmployeeListViewController() {
        employeeListViewController = EmployeeListViewController()
        employeeListViewController.delegate = mockDelegate
    }
    
    private func whenTheViewLoads() {
        employeeListViewController.loadViewIfNeeded()
    }
    
    private func whenTheViewIsLaidOut() {
        employeeListViewController.view.layoutIfNeeded()
    }
    
    private func whenTheCollectionViewVendsCell(atIndexPath indexPath: IndexPath) -> UICollectionViewCell? {
        employeeListViewController.collectionView.cellForItem(at: indexPath)
    }
    
    private func whenTheUserSelectsEmployee(atIndexPath indexPath: IndexPath) {
        employeeListViewController.collectionView.delegate?.collectionView?(employeeListViewController.collectionView, didSelectItemAt: indexPath)
    }
}

// MARK: - UICollectionViewDataSource
extension EmployeeListViewControllerTests {
    func testItDisplaysTheCorrectNumberOfEmployees() {
        givenAnEmployeeListViewController()
        whenTheViewLoads()
        XCTAssertEqual(employeeListViewController.collectionView.numberOfSections, 1)
        XCTAssertEqual(employeeListViewController.collectionView.numberOfItems(inSection: 0), employees.count)
    }
    
    func testItDisplaysTheCorrectEmployeeData() {
        givenAnEmployeeListViewController()
        whenTheViewIsLaidOut()
        let cell = whenTheCollectionViewVendsCell(atIndexPath: IndexPath(item: 4, section: 0))
        let contentConfiguration = cell?.contentConfiguration as! UIListContentConfiguration
        XCTAssertEqual(contentConfiguration.text, employees[4].name)
    }
}

// MARK: - UICollectionViewDelegate
extension EmployeeListViewControllerTests {
    func testItReportsTheSelectedEmployeeToItsDelegate() {
        givenAnEmployeeListViewController()
        whenTheViewIsLaidOut()
        whenTheUserSelectsEmployee(atIndexPath: IndexPath(item: 4, section: 0))
        XCTAssertEqual(mockDelegate.selectedEmployee, employees[4])
    }
}

private extension EmployeeListViewController {
    var collectionView: UICollectionView {
        view.subview(ofType: UICollectionView.self, withAccessibilityIdentifier: "collection_view")!
    }
}

private final class MockEmployeeListViewControllerDelegate: EmployeeListViewControllerDelegate {
    private(set) var selectedEmployee: Employee?
    func employeeListViewController(_ employeeListViewController: EmployeeListViewController, didSelectEmployee employee: Employee) {
        selectedEmployee = employee
    }
}
