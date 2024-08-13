//
//  WhatsappMessageListController.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 13/08/24.
//

import Foundation
import UIKit
import SwiftUI

final class WhatsappMessageListController: UIViewController {
    
    // MARK: View's Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    //MARK: Properties
    private let cellIdentifier = "WhatsappMessageListControllerCells"
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.backgroundColor = .red
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: Methods
    private func setUpViews(){
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}

extension WhatsappMessageListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = .clear
        let message = WhatsappMessageItemViewModel.stubMessages[indexPath.row]
        cell.contentConfiguration = UIHostingConfiguration{
            switch(message.type){
            case .text:
                WhatsappBubbleTextView(item: message)
            case .image:
                WhatsappBubbleImageView(item: message)
            case .video:
                WhatsappBubbleImageView(item: message)
            default:
                Text("Cant preview this message")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WhatsappMessageItemViewModel.stubMessages.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

#Preview {
    WhatsappMessageListView()
}
