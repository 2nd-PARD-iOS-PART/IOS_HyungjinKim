import UIKit

class ComingSoonPage: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var models = PopularSearchModel.modelData
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainNavigationBar()
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ComingSoonTableViewCell.self, forCellReuseIdentifier: ComingSoonTableViewCell.identifier)
    }
    
    func mainNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        
        let logo = UIImage(systemName: "bell.circle.fill")?.withRenderingMode(.alwaysOriginal)
        let imageView = UIImageView(image: logo)
        
        let label = UILabel()
        label.text = "Notifications"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        
        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: stackView)
        
        navigationBarAppearance.configureWithDefaultBackground()
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.compactAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ComingSoonTableViewCell.identifier, for: indexPath) as! ComingSoonTableViewCell
        
        let model = models[indexPath.row]
        cell.configure(with: model.title, image: model.image)
        
        return cell
    }
    
    // ComingSoonTableViewCell
    
    class ComingSoonTableViewCell: UITableViewCell {
        
        static let identifier = "ComingSoonTableViewCell"
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.textColor = .white
            return label
        }()
        
        private let newArrivalLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.textColor = .red
            label.text = "New Arrival"
            return label
        }()
        
        private let titleImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()

        
        private let releaseDateLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = .gray
            label.text = "Nov 6"
            return label
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.addSubview(titleImageView)
            contentView.addSubview(newArrivalLabel)
            contentView.addSubview(titleLabel)
            contentView.addSubview(releaseDateLabel)
            
            applyConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func applyConstraints() {
            // Constants for padding and image size
            let labelSpacing: CGFloat = 5
            let imagePadding: CGFloat = 10
            let imageHeight: CGFloat = 80
            let imageWidth: CGFloat = 150 // Adjust the width as needed for a longer image

            NSLayoutConstraint.activate([
                    // Constraints for titleImageView
                    titleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: imagePadding),
                    titleImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                    titleImageView.widthAnchor.constraint(equalToConstant: imageWidth),
                    titleImageView.heightAnchor.constraint(equalToConstant: imageHeight),

                    // Constraints for newArrivalLabel
                    newArrivalLabel.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor, constant: imagePadding),
                    newArrivalLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -labelSpacing),
                    newArrivalLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -imagePadding),

                    // Constraints for titleLabel
                    titleLabel.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor, constant: imagePadding),
                    titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                    titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -imagePadding),
                    
                    // Constraints for releaseDateLabel
                    releaseDateLabel.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor, constant: imagePadding),
                    releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: labelSpacing),
                    releaseDateLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -imagePadding)
                ])
        }

        
        func configure(with title: String, image: String) {
            titleLabel.text = title
            titleImageView.image = UIImage(named: image)
        }
    }
    
}
