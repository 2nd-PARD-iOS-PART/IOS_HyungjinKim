import Foundation

struct PopularSearchModel {
    var title: String
    var image: String
}

#if DEBUG

extension PopularSearchModel {
    static let modelData: [PopularSearchModel] = [
        PopularSearchModel(title: "19/20", image: "19:20"),
        PopularSearchModel(title: "Extraction 2", image: "Extraction2"),
        PopularSearchModel(title: "Knivesout: Glass Onion", image: "knivesout_glassonion"),
        PopularSearchModel(title: "The Irishman", image: "TheIrishman"),
        PopularSearchModel(title: "The Queen's Gambit", image: "TheQuessn's Gambit"),
        PopularSearchModel(title: "고요의 바다", image: "고요의바다"),
        PopularSearchModel(title: "길복순", image: "길복순"),
        PopularSearchModel(title: "더글로리", image: "더글로리"),
        PopularSearchModel(title: "마스크걸", image: "마스크걸"),
        PopularSearchModel(title: "무빙", image: "무빙"),
        PopularSearchModel(title: "범인은 바로 너", image: "범인은바로너"),
        PopularSearchModel(title: "사냥개들", image: "사냥개들"),
        PopularSearchModel(title: "오징어게임", image: "오징어게임"),
        PopularSearchModel(title: "지금 우리 학교는", image: "지금우리학교는"),
        PopularSearchModel(title: "킹덤", image: "킹덤"),
    ]
}

#endif
