//  PageContent.swift
//  SparkOnB
//
//  Created by Ghada Alsubaie on 10/06/1446 AH.
//

import SwiftUI

struct PageContent {
    let image: String
    let title: String
    let description: String
}

let content = [
    PageContent(
        image: "Image1",
        title: "ADD YOUR TASKS",
        description: "Add your daily tasks you want to get done"
    ),
    PageContent(
        image: "Image2",
        title: "DOUBLE TAP",
        description: "Enable the back double tap in Settings, to check off your tasks easily!"
    ),
    PageContent(
        image: "Image3",
        title: "GROW SPARK",
        description: "FunFact: did you know that all dogs have ADHD? watch your spark grows!"
    )
]
