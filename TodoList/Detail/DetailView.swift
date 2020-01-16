import UIKit

class DetailView: UIView {

    // MARK: - Instance Properties

    private let todo: Todo

    // MARK: UI Properties

    private(set) lazy var descriptionTextField = UITextField(frame: .zero)

    // MARK: - Initialization Methods

    init(frame: CGRect = .zero, with todo: Todo) {
        self.todo = todo
        super.init(frame: frame)
        setupSelf()
    }

    override init(frame: CGRect) {
        fatalError("Use init(frame:with:).")
    }

    required init?(coder: NSCoder) {
        fatalError("Use init(frame:with:).")
    }

    // MARK: - Instance Methods

    private func setupSelf() {
        backgroundColor = .systemBackground
        descriptionTextField.text = todo.description

        setupDescriptionTextField(descriptionTextField)
        setupConstraints()
    }

    private func setupDescriptionTextField(_ descriptionTextField: UITextField) {
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false

        descriptionTextField.borderStyle = .roundedRect

        addSubview(descriptionTextField)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            descriptionTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionTextField.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
