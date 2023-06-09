import UIKit

final class FavoriteViewController: UIViewController {
    
    //MARK: - Internal properties
    
    var presenter: FavoritePresenterProtocol?
    
    //MARK: - Private properties
            
    private let favoriteTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.register(FavoriteCustomTableViewCell.self, forCellReuseIdentifier: FavoriteCustomTableViewCell.identifier)
        view.rowHeight = 100
        view.separatorStyle = .none
        view.tableHeaderView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteTableView.reloadData()
    }
    
    //MARK: - Private methods
    
    private func setup() {
        title = "Favorites"
        setupDelegate()
    }
    
    private func setupDelegate() {
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
    }
    
    //MARK: - Setup layout
    
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(favoriteTableView)
        
        NSLayoutConstraint.activate([
            favoriteTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoriteTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            favoriteTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

//MARK: - Extension: UITableViewDelegate & UITableViewDataSource

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getArrayCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCustomTableViewCell.identifier, for: indexPath) as? FavoriteCustomTableViewCell else { return UITableViewCell() }
        let model = presenter?.getModel(with: indexPath.row)
        
        if let model = model  {
            cell.updateCell(model: model)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.deleteModel(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

//MARK: - Extension: FavoriteViewProtocol

extension FavoriteViewController: FavoriteViewProtocol {}
