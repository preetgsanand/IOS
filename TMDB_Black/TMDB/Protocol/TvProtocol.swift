//
//  TvProtocol.swift
//  TMDB
//
//  Created by Preet G S Anand on 11/10/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation

protocol TvProtocol {
    func renderTvList(viewModels : [TvViewModel])
    func add(tvViewModels : [TvViewModel])
    func initializeSegmentControl()
    func initializeLoadingIndicator()
}


protocol TvDetailProtocol {
    func renderView(viewModel : TvDetailViewModel, castViewModels : [CastViewModel], seasonViewModels : [SeasonViewModel])
    func setTitle(title : String)
}
