//
//  CategoryCell.swift
//  DiscourseClient
//
//  Created by Osvaldo Chaparro on 21/01/2021.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    var viewModel: CategoryCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            textLabel?.text = viewModel.textLabelText
        }
    }
}
