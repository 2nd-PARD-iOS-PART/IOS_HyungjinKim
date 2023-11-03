struct PopularSearchModel {
    var title: String
    var image: String
    var year: String
    var description: String
    var numberOfSeasons: String // Changed from Int? to String
}

#if DEBUG

extension PopularSearchModel {
    static let modelData: [PopularSearchModel] = [
        PopularSearchModel(title: "19/20", image: "19:20", year: "2019", description: "Time stands still in this intriguing sci-fi drama.", numberOfSeasons: "None"),
        PopularSearchModel(title: "Extraction 2", image: "Extraction2", year: "2021", description: "A mercenary's fight for survival gets more complicated.", numberOfSeasons: "None"),
        PopularSearchModel(title: "Knives Out: Glass Onion", image: "knivesout_glassonion", year: "2022", description: "The world's greatest detective takes on a puzzling new case.", numberOfSeasons: "None"),
        PopularSearchModel(title: "The Irishman", image: "TheIrishman", year: "2019", description: "An old mobster reminisces about his life of crime.", numberOfSeasons: "None"),
        PopularSearchModel(title: "The Queen's Gambit", image: "TheQuessn's Gambit", year: "2020", description: "A chess prodigy battles addiction on her path to greatness.", numberOfSeasons: "1"),
        PopularSearchModel(title: "고요의 바다", image: "고요의바다", year: "2022", description: "Astronauts on a perilous mission find more than they bargained for.", numberOfSeasons: "1"),
        PopularSearchModel(title: "길복순", image: "길복순", year: "2018", description: "A tale of luck and the unexpected twists of fate.", numberOfSeasons: "2"),
        PopularSearchModel(title: "더글로리", image: "더글로리", year: "2023", description: "A story of triumph over adversity, set against the backdrop of sport.", numberOfSeasons: "None"),
        PopularSearchModel(title: "마스크걸", image: "마스크걸", year: "2024", description: "A superheroine's journey to find her identity behind the mask.", numberOfSeasons: "3"),
        PopularSearchModel(title: "무빙", image: "무빙", year: "2020", description: "A family on the run tries to find a place to call home.", numberOfSeasons: "None"),
        PopularSearchModel(title: "범인은 바로 너", image: "범인은바로너", year: "2019", description: "A zany whodunnit where everyone could be the culprit.", numberOfSeasons: "1"),
        PopularSearchModel(title: "삶의 개들", image: "사냥개들", year: "2021", description: "The interwoven lives of pets and their owners in a metropolitan city.", numberOfSeasons: "None"),
        PopularSearchModel(title: "오징어게임", image: "오징어게임", year: "2021", description: "Contestants play childhood games with deadly stakes for a big prize.", numberOfSeasons: "1"),
        PopularSearchModel(title: "지금 우리 학교는", image: "지금우리학교는", year: "2022", description: "Students struggle for survival after a zombie outbreak in their school.", numberOfSeasons: "1"),
        PopularSearchModel(title: "킹덤", image: "킹덤", year: "2019", description: "In a kingdom plagued by corruption and famine, a mysterious plague turns the deceased into monsters.", numberOfSeasons: "2"),
    ]
}

#endif
