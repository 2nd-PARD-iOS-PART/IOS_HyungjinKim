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
    
    private let playIcon: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "play.fill"), for: .normal)
            button.tintColor = .white
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.setTitleColor(.black, for: .normal) // Set text color to black
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        
        let playImage = UIImage(systemName: "play.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        button.setImage(playImage, for: .normal)
        
        return button
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8

        // Add download icon
        let downloadImage = UIImage(systemName: "arrow.down.to.line")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(downloadImage, for: .normal)

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
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let delete: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func createButton(withTitle title: String, andSystemImageName systemName: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setImage(UIImage(systemName: systemName), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    private func createTabButton(withTitle title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    func createTabStackView() -> UIStackView {
        let episodesButton = createTabButton(withTitle: "Episodes")
        let collectionButton = createTabButton(withTitle: "Collection")
        let moreLikeThisButton = createTabButton(withTitle: "More Like This")
        let trailersButton = createTabButton(withTitle: "Trailers & More")

        let tabStackView = UIStackView(arrangedSubviews: [episodesButton, collectionButton, moreLikeThisButton, trailersButton])
        tabStackView.axis = .horizontal
        tabStackView.distribution = .fillEqually
        tabStackView.spacing = 10
        tabStackView.translatesAutoresizingMaskIntoConstraints = false
        return tabStackView
    }

    func createButtonStackView() -> UIStackView {
        let myListButton = createButton(withTitle: "My List", andSystemImageName: "plus")
        let rateButton = createButton(withTitle: "Rate", andSystemImageName: "hand.thumbsup")
        let shareButton = createButton(withTitle: "Share", andSystemImageName: "arrow.right")

        let stackView = UIStackView(arrangedSubviews: [myListButton, rateButton, shareButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    private func setupViews() {
        view.backgroundColor = .black
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(yearLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(playButton)
        contentView.addSubview(playIcon)
        contentView.addSubview(seasonsLabel)
        contentView.addSubview(downloadButton)
        contentView.addSubview(rateButton)
        contentView.addSubview(changeScreen)
        contentView.addSubview(delete)
        
        let stackView = createButtonStackView()
        let tabStackView = createTabStackView()

        contentView.addSubview(stackView)
        contentView.addSubview(tabStackView)
    }

    
    private func setupConstraints() {
        // Constraints for scrollView and contentView
        let playIconSize: CGFloat = 60
        let iconSize: CGFloat = 30

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
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            playIcon.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            playIcon.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            playIcon.widthAnchor.constraint(equalToConstant: playIconSize),
            playIcon.heightAnchor.constraint(equalToConstant: playIconSize),
            
            delete.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 10),
            delete.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -10),
            delete.widthAnchor.constraint(equalToConstant: iconSize),
            delete.heightAnchor.constraint(equalToConstant: iconSize),

            changeScreen.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 10),
            changeScreen.trailingAnchor.constraint(equalTo: delete.leadingAnchor, constant: -10),
            changeScreen.widthAnchor.constraint(equalToConstant: iconSize),
            changeScreen.heightAnchor.constraint(equalToConstant: iconSize),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            yearLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            yearLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: downloadButton.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            seasonsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            seasonsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            seasonsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20) // This is important to allow the scrollView to scroll
        ])
        
        NSLayoutConstraint.activate([
            
            playButton.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 20),
            playButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 300), // Width for the button
            playButton.heightAnchor.constraint(equalToConstant: 50), // Height for the button
            
            downloadButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 20),
            downloadButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.widthAnchor.constraint(equalToConstant: 300), // Width for the button
            downloadButton.heightAnchor.constraint(equalToConstant: 50), // Height for the button
            
        ])
//        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: rateButton.bottomAnchor, constant: 20),
//            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            stackView.heightAnchor.constraint(equalToConstant: 50) // Or whatever height you deem fit
//        ])
//
//        // Constraints for tabStackView (Episodes, Collection, More Like This, Trailers & More tabs)
//        NSLayoutConstraint.activate([
//            tabStackView.topAnchor.constraint(equalTo: seasonsLabel.bottomAnchor, constant: 20),
//            tabStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            tabStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            tabStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20) // Ensure this is the last item in your scrollView
//        ])
        
}
    
    private func populateData() {
        titleLabel.text = model.title
        yearLabel.text = "Year: \(model.year)"
        descriptionLabel.text = model.description
        seasonsLabel.text = "Seasons: \(model.numberOfSeasons)"
        imageView.image = UIImage(named: model.image)
   }
}
