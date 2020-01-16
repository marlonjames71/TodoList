import UIKit

class ListTableViewDataSource: NSObject {

    // MARK: - Instance Properties

    private(set) var todos: [Todo]

    // MARK: Initialization Methods

    override init() {
        if let path = Bundle.main.path(forResource: "todos", ofType: "json"),
            let data = try? String(contentsOfFile: path).data(using: .utf8),
            let todos = try? JSONDecoder().decode([Todo].self, from: data) {
            self.todos = todos
        } else {
            self.todos = []
        }
    }

    // MARK: - Instance Methods

    func update(_ todo: Todo, at index: Int) {
        assert(todos.count > index)
        todos[index] = todo
    }
}

extension ListTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else {
            preconditionFailure("Could not create cell.")
        }

        assert(todos.count > indexPath.row)

        cell.config(with: todos[indexPath.row]) { [weak self] todo in
            self?.todos[indexPath.row] = todo
        }

        return cell
    }
}
