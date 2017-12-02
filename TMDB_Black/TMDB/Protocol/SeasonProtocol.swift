//
//  SeasonProtocol.swift
//  TMDB
//
//  Created by Preet G S Anand on 11/20/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation

protocol SeasonDetailProtocol {
    // PRESENTER -> VIEW
    func initializeSegments(seasonViewModels : [SeasonViewModel])
    func renderSeasonDetail(seasonViewModel : SeasonDetailViewModel, episodeViewModels : [EpisodeViewModel])
}
