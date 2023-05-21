import UIKit

final class FavoriteCustomTableViewCell: UITableViewCell {
    
    //MARK: - Cell identifier
    
    static let identifier = "FavoriteCustomTableViewCell"
    
    //MARK: - Properties
    
    private let sizeOfImage: CGFloat = 80

    private let generatedImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private let generatedTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    
    //MARK: - Initialise
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        generatedImage.image    = nil
        generatedTextLabel.text = nil
    }
    
    //MARK: - Update cell
    
    func updateCell(model: FavoriteModel) {
        generatedImage.image    = model.image
        generatedTextLabel.text = model.text
    }
    
    //MARK: - Add subviews
    
    private func setup() {
        backgroundColor = .clear
        selectionStyle  = .none
        contentView.addSubview(generatedImage)
        contentView.addSubview(generatedTextLabel)
        updateConstraintsIfNeeded()
    }
    
    //MARK: - Set constrains
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            generatedImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            generatedImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            generatedImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            generatedImage.widthAnchor.constraint(equalToConstant: sizeOfImage),
            generatedImage.heightAnchor.constraint(equalToConstant: sizeOfImage),
            
            generatedTextLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            generatedTextLabel.leadingAnchor.constraint(equalTo: generatedImage.trailingAnchor, constant: 10),
            generatedTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
    }
}
