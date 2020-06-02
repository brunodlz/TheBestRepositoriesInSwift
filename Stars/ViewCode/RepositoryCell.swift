import UIKit

class RepositoryCell: UITableViewCell, Reusable {

	private lazy var repositoryIcon: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		let image = UIImage(named: "repo.png")?.withRenderingMode(.alwaysTemplate)
		imageView.image = image
		imageView.tintColor = .systemGray
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	private lazy var repositorynameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 2
		label.textColor = .systemBlue
		label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
		label.setContentHuggingPriority(.defaultLow, for: .horizontal)
		label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
		return label
	}()

	private lazy var starIcon: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		let image = UIImage(named: "star.png")?.withRenderingMode(.alwaysTemplate)
		imageView.image = image
		imageView.tintColor = .systemGray2
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	private lazy var numberOfStarLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .left
		label.textColor = .systemGray2
		label.text = "123"
		label.font = UIFont.systemFont(ofSize: 15)
		label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
		return label
	}()

	private lazy var avatarImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		let image = UIImage(named: "repo.png")?.withRenderingMode(.alwaysTemplate)
		imageView.image = image
		imageView.tintColor = .systemGray
		imageView.translatesAutoresizingMaskIntoConstraints = false
		
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 2
		
		return imageView
	}()

	private lazy var usernameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .systemGray
		label.font = UIFont.systemFont(ofSize: 15)
		label.setContentHuggingPriority(.defaultLow, for: .horizontal)
		label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
		return label
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		buildHierarchy()
		buildConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func buildHierarchy() {
		contentView.addSubview(repositoryIcon)
		contentView.addSubview(repositorynameLabel)
		contentView.addSubview(starIcon)
		contentView.addSubview(numberOfStarLabel)
		
		contentView.addSubview(avatarImageView)
		contentView.addSubview(usernameLabel)
	}

	private func buildConstraints() {
		repositoryIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
		repositoryIcon.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
		repositoryIcon.widthAnchor.constraint(equalToConstant: 26).isActive = true
		repositoryIcon.heightAnchor.constraint(equalToConstant: 26).isActive = true
		
		repositorynameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
		repositorynameLabel.leadingAnchor.constraint(equalTo: repositoryIcon.trailingAnchor, constant: 2).isActive = true
		repositorynameLabel.trailingAnchor.constraint(equalTo: starIcon.leadingAnchor, constant: 2).isActive = true
		
		starIcon.centerYAnchor.constraint(equalTo: numberOfStarLabel.centerYAnchor).isActive = true
		starIcon.leadingAnchor.constraint(equalTo: repositorynameLabel.trailingAnchor, constant: -2).isActive = true
		starIcon.trailingAnchor.constraint(equalTo: numberOfStarLabel.leadingAnchor).isActive = true
		starIcon.heightAnchor.constraint(equalToConstant: 16).isActive = true
		starIcon.widthAnchor.constraint(equalToConstant: 16).isActive = true
		
		numberOfStarLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
		numberOfStarLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
		
		avatarImageView.topAnchor.constraint(equalTo: repositorynameLabel.bottomAnchor, constant: 8).isActive = true
		avatarImageView.centerXAnchor.constraint(equalTo: repositoryIcon.centerXAnchor).isActive = true
		avatarImageView.heightAnchor.constraint(equalToConstant: 22).isActive = true
		avatarImageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
		
		usernameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor).isActive = true
		usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 2).isActive = true
		usernameLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true

		let bottomBreakableConstraint = avatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
		bottomBreakableConstraint.priority = UILayoutPriority(200)
		bottomBreakableConstraint.isActive = true
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		
		repositorynameLabel.text = nil
		numberOfStarLabel.text = nil
		avatarImageView.image = nil
		usernameLabel.text = nil
	}
	
	func configure(_ github: GitHub) {
		repositorynameLabel.text = github.repositoryName
		numberOfStarLabel.text = "\(github.stars)"
		avatarImageView.imageFromURL(github.user.avatar)
		usernameLabel.text = github.user.name
	}
}
