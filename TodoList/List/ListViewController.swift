import UIKit

class ListViewController: UIViewController {

    // MARK: - Instance Properties

    // MARK: UI Properties

    private lazy var tableView = ListTableView(frame: .zero)
    private lazy var dataSource = ListTableViewDataSource()

    // MARK: - UIViewController Override Methods

    override func loadView() {
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = dataSource
        tableView.delegate = self
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        assert(dataSource.todos.count > indexPath.row)

        let detailViewController = DetailViewController(with: dataSource.todos[indexPath.row]) { [weak self] todo in
            self?.dataSource.update(todo, at: indexPath.row)
            self?.tableView.reloadRows(at: [indexPath], with: .automatic)
        }

        let navigationController = UINavigationController(rootViewController: detailViewController)
        present(navigationController, animated: true)
    }
}
