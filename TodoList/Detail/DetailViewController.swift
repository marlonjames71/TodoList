import UIKit

class DetailViewController: UIViewController {

    // MARK: Instance Properties

    private let todo: Todo
    private let onSave: ((Todo) -> Void)?

    // MARK: UI Properties

    private lazy var detailView = DetailView(with: todo)

    // MARK: - Initialization Methods

    init(with todo: Todo, onSave: ((Todo) -> Void)?) {
        self.todo = todo
        self.onSave = onSave
        super.init(nibName: nil, bundle: nil)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("Use init(with:onSave).")
    }

    required init?(coder: NSCoder) {
        fatalError("Use init(with:onSave).")
    }

    // MARK: - UITableViewController Override Properties

    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        setupNavigation()
    }

    // MARK: - Instance Methods

    private func setupNavigation() {
        title = "Edit Todo"

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(saveButtonTapped(_:)))
    }

    @objc private func saveButtonTapped(_ sender: UIBarButtonItem) {
        let todo = Todo(description: detailView.descriptionTextField.text ?? self.todo.description,
                        isCompleted: self.todo.isCompleted)

        onSave?(todo)
        dismiss(animated: true)
    }
}
