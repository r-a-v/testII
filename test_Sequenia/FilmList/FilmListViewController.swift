//
//  FilmListViewController.swift
//  test_Sequenia
//
//  Created by aleksandr_rudikov on 08.09.2021.
//

import UIKit

class FilmListViewController: UITableViewController {
    
    private var viewModel: FilmListViewModelProtocol! {
        didSet {
            viewModel.getFilms {
                self.updateTableView()
            }
        }
    }

//MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        viewModel = FilmListViewModel()
        configureTableView()
        configureNavigationBar()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension FilmListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        SectionHeaderView(with: viewModel.sectionName(section: section))
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        70
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilmCell.reuseID, for: indexPath)
                as? FilmCell else { return UITableViewCell() }
        
        cell.viewModel = viewModel.filmCellViewModel(atIndexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVC = FilmDetailViewController()
        detailVC.viewModel = viewModel.filmDetailVIewModel(atIndexPath: indexPath)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

//MARK: - Configure UI
extension FilmListViewController {
    private func configureTableView() {
        tableView.register(FilmCell.self, forCellReuseIdentifier: FilmCell.reuseID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
    
    private func configureNavigationBar() {
        title = "Фильмы"
        navigationController?.navigationBar.prefersLargeTitles = true

        let navBarAppearence = UINavigationBarAppearance()
        navBarAppearence.configureWithOpaqueBackground()
        navBarAppearence.backgroundColor = .mainPurple

        navBarAppearence.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearence.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = navBarAppearence
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearence
    }
    
    private func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
