import UIKit

class MovieDetailViewController: UIViewController {
    private let model: PopularSearchModel
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let seasonsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(model: PopularSearchModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        populateData()
    }
    
    private let playButton: UIButton = {
            let button = UIButton()
            button.setTitle("Play", for: .normal)
            button.backgroundColor = .black
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
    private let downloadButton: UIButton = {
            let button = UIButton()
            button.setTitle("Download", for: .normal)
            button.backgroundColor = .darkGray
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
    private let rateButton: UIButton = {
            let button = UIButton()
            button.setTitle("Rate", for: .normal)
            button.backgroundColor = .darkGray
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
    
    private let changeScreen: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "airplayaudio"), for: .normal)
        button.tintColor = .black // Set the color as per your design
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let delete: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black // Set the color as per your design
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setupViews() {
        view.backgroundColor = .black
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(yearLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(playButton)
        contentView.addSubview(seasonsLabel)
        contentView.addSubview(downloadButton)
        contentView.addSubview(rateButton)
        contentView.addSubview(changeScreen)
        contentView.addSubview(delete)
    }
    
    private func setupConstraints() {
        // Constraints for scrollView and contentView
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300), // Arbitrary height for the image view
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            yearLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            yearLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            seasonsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            seasonsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            seasonsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            seasonsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20) // This is important to allow the scrollView to scroll
        ])
        
        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            playButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 150), // Width for the button
            playButton.heightAnchor.constraint(equalToConstant: 50), // Height for the button
            
            downloadButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 20),
            downloadButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            downloadButton.widthAnchor.constraint(equalToConstant: 150), // Width for the button
            downloadButton.heightAnchor.constraint(equalToConstant: 50), // Height for the button
            
            rateButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 20),
            rateButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            rateButton.widthAnchor.constraint(equalToConstant: 150), // Width for the button
            rateButton.heightAnchor.constraint(equalToConstant: 50), // Height for the button
            
            seasonsLabel.topAnchor.constraint(equalTo: downloadButton.bottomAnchor, constant: 20),
            seasonsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            seasonsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            seasonsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
}
    
    private func populateData() {
        titleLabel.text = model.title
        yearLabel.text = "Year: \(model.year)"
        descriptionLabel.text = model.description
        seasonsLabel.text = "Seasons: \(model.numberOfSeasons)"
        imageView.image = UIImage(named: model.image)
   }
}
