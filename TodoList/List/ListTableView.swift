import UIKit

class ListTableView: UITableView {

    // MARK: - Initialization Methods

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("Use init(frame:style:).")
    }
}
