import UIKit

class ListTableViewCell: UITableViewCell {

    // MARK: - Type Properties

    static let reuseIdentifier = String(describing: self)

    // MARK: - Instance Properties

    private var todo: Todo?
    private var onUpdate: ((Todo) -> Void)?

    // MARK: UI Properties

    private lazy var checkboxButton = UIButton(type: .custom)
    private lazy var descriptionLabel = UILabel(frame: .zero)

    // MARK: - Initialization Methods

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSelf()
    }

    required init?(coder: NSCoder) {
        fatalError("Use init(style:reuseIdentifier:).")
    }

    // MARK: - UITableViewCell Override Methods

    override func prepareForReuse() {
        super.prepareForReuse()

        checkboxButton.isSelected = false
        descriptionLabel.text = nil
    }

    // MARK: - Instance Methods

    func config(with todo: Todo, onUpdate: ((Todo) -> Void)?) {
        self.todo = todo
        self.onUpdate = onUpdate

        checkboxButton.isSelected = todo.isCompleted
        descriptionLabel.text = todo.description
    }

    private func setupSelf() {
        setupCheckboxButton(checkboxButton)
        setupDescriptionLabel(descriptionLabel)
        setupConstraints()
    }

    private func setupCheckboxButton(_ checkboxButton: UIButton) {
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false

        checkboxButton.setImage(UIImage(systemName: "square"), for: .normal)
        checkboxButton.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
        checkboxButton.addTarget(self, action: #selector(checkboxButtonTapped(_:)), for: .touchUpInside)

        contentView.addSubview(checkboxButton)
    }

    private func setupDescriptionLabel(_ descriptionLabel: UILabel) {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(descriptionLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            checkboxButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkboxButton.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),

            descriptionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: checkboxButton.trailingAnchor, constant: 8.0)
        ])
    }

    @objc private func checkboxButtonTapped(_ sender: UIButton) {
        todo?.isCompleted.toggle()
        checkboxButton.isSelected.toggle()

        if let todo = todo {
            onUpdate?(todo)
        }
    }
}
