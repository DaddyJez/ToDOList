//
//  TaskTableViewCell.swift
//  ToDoList
//
//  Created by Влад Карагодин on 10.02.2025.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var checkboxButton: UIButton!
    
    weak var delegate: TaskCellDelegate?

    var isCompleted: Bool = false {
        didSet {
            let imageName = isCompleted ? "checkmark.circle" : "circle"
            let image = UIImage(systemName: imageName)
            checkboxButton.setImage(image, for: .normal)
            updateTitleStyle()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let interaction = UIContextMenuInteraction(delegate: self)
        self.addInteraction(interaction)
    }

    private func updateTitleStyle() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strikethroughStyle: isCompleted ? NSUnderlineStyle.single.rawValue : 0
        ]
        let attributedText = NSAttributedString(string: titleLabel.text ?? "", attributes: attributes)
        titleLabel.attributedText = attributedText
    }

    @IBAction func checkboxTapped(_ sender: UIButton) {
        isCompleted.toggle()
        delegate?.didToggleComplete(for: self)
    }
}

// MARK: - UIContextMenuInteractionDelegate

extension TaskTableViewCell: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {

        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            // Создаем контекстное меню
            let editAction = UIAction(title: "Редактировать", image: UIImage(systemName: "pencil")) { _ in
                self.delegate?.didTapEdit(for: self)
            }

            let shareAction = UIAction(title: "Поделиться", image: UIImage(systemName: "square.and.arrow.up")) { _ in
                self.delegate?.didTapShare(for: self)
            }

            let deleteAction = UIAction(title: "Удалить", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
                self.delegate?.didTapDelete(for: self)
            }

            return UIMenu(title: "", children: [editAction, shareAction, deleteAction])
        }
    }
}

// MARK: - Расширение для получения родительского ViewController

extension TaskTableViewCell {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
