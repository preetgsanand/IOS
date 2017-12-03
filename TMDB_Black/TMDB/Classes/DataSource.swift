import Foundation
import UIKit

class MovieArrayDataSource : CollectionDataSource<MovieViewModel, MovieCell> {
    
}


class TvArrayDataSource : CollectionDataSource<TvViewModel, TvCell> {
    
}


class EpisodeDataSource : CollectionDataSource<EpisodeViewModel, EpisodeCell> {
    
}

class ListArrayDataSource : TableDataSource<ListViewModel, ListCell> {
    
    var view : HomeListCellProtocol
    
    init(items: [ListViewModel], view : HomeListCellProtocol) {
        self.view = view
        super.init(items: items)
    }
    
    override
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = super.tableView(tableView, cellForRowAt: indexPath) as? ListCell  else {
            return UITableViewCell()
        }
        cell.view = self.view
        return cell
    }
}

class GenreDataSource : CollectionDataSource<GenreViewModel, GenreCell> {
    
}


class PeopleCreditDataSource : CollectionDataSource<PeopleCreditViewModel, PeopleDetailCreditCell> {
    
}
