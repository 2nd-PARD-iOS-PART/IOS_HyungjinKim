//
//  Model.swift
//  3rd_homework_KimHyungjin
//
//  Created by hyungjin kim on 2023/10/07.
//

import Foundation

struct Model{
    var title : String
    var image : String
}

#if DEBUG

extension Model{
    static var ModelData = [
        [
            Model(title: "Previews", image: "Image 1"),
            Model(title: "Previews", image: "Image 2"),
            Model(title: "Previews", image: "Image 3"),
        ],
        [
            Model(title: "Continue Watching for Hyungjin", image: "Continue_1"),
            Model(title: "Continue Watching for Hyungjin", image: "Continue_2"),
            Model(title: "Continue Watching for Hyungjin", image: "Continue_3"),
        ],
        [
            Model(title: "My List", image: "Movie Card"),
            Model(title: "My List", image: "Movie Card-2"),
            Model(title: "My List", image: "Movie Card-11"),
            Model(title: "My List", image: "Movie Card-4"),
            Model(title: "My List", image: "Movie Card-5"),
            Model(title: "My List", image: "Movie Card-6"),
        ],
        [
            Model(title: "Europe movie", image: "Movie Card-7"),
            Model(title: "Europe movie", image: "Movie Card-8"),
            Model(title: "Europe movie", image: "Movie Card-9"),
            Model(title: "Europe movie", image: "Movie Card-10"),
            Model(title: "Europe movie", image: "Movie Card-11"),
            Model(title: "Europe movie", image: "Movie Card-5"),
        ],
        [
            Model(title: "Romace/Drama", image: "Movie Card-6"),
            Model(title: "Romace/Drama", image: "Movie Card-5"),
            Model(title: "Romace/Drama", image: "Movie Card-4"),
            Model(title: "Romace/Drama", image: "Movie Card-11"),
            Model(title: "Romace/Drama", image: "Movie Card-2"),
            Model(title: "Romace/Drama", image: "Movie Card"),
        ],
        [
            Model(title: "Action/Thriller", image: "Movie Card-11"),
            Model(title: "Action/Thriller", image: "Movie Card-10"),
            Model(title: "Action/Thriller", image: "Movie Card-9"),
            Model(title: "Action/Thriller", image: "Movie Card-7"),
            Model(title: "Action/Thriller", image: "Movie Card-8"),
            Model(title: "Action/Thriller", image: "Movie Card-5"),

        ],
    ]
}
    
#endif
