//
//  StoriesViewModel.swift
//  TheGlobeiOSTest
//
//  Created by Raphael Araújo on 2024-10-15.
//
import Foundation

protocol StoriesViewModelProtocol: AnyObject {
    var viewController: StoriesViewControllerProtocol? { get set}
    
    func update()
}

class StoriesViewModel: StoriesViewModelProtocol {
    weak var viewController: StoriesViewControllerProtocol?
    
    private(set) var storiesUseCase = StoriesUseCase()
    
    func update() {
        storiesUseCase.fetchStories { [weak self] result in
            switch result {
            case .success(let storiesModel):
                var cellData: [StoryCellData] = []
                
                for story in storiesModel.stories {
                    let storyCellData = StoryCellData(story: story)
                    cellData.append(storyCellData)
                }
                DispatchQueue.main.async {
                    self?.viewController?.display(cellContent: cellData)
                }
            case .failure:
                self?.viewController?.hideData()
            }
        }
    }
}
