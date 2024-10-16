//
//  StoryCellData.swift
//  TheGlobeiOSTest
//
//  Created by Raphael Araújo on 2024-10-15.
//
import Foundation
import UIKit

struct StoryCellData {
    var headline: NSAttributedString?
    var bylines: String?
    var promoImage: URL?
    var isProtected: Bool =  false
    
    init(story: Story) {
        
        let attributedText = NSMutableAttributedString(string: story.headline)
        
        if story.protectionProduct == "red" {
            let protectedString = NSAttributedString(string: "  X", attributes: [.foregroundColor: UIColor.red])
            attributedText.append(protectedString)
        }
        
        headline = attributedText
        
        if let bylines = story.bylines {
            self.bylines = formatByLines(bylines: bylines)
        }
        
        if let urlString = story.promoImage?.urls?["650"] {
            promoImage = URL(string: urlString)
        }
    }
    
    private func formatByLines(bylines: [String]) -> String? {
        guard !bylines.isEmpty else { return nil }
        
        var authors = bylines
        
        switch authors.count {
        case 1:
            return authors.first
        case 2:
            return authors.joined(separator: " and ")
        default:
            let lastAuthor = authors.removeLast()
            return "\(authors.joined(separator: ", ")), and \(lastAuthor)"
        }
    }
}
