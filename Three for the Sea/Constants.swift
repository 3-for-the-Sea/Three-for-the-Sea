//
//  Constants.swift
//  Three for the Sea
//
//  Created by Theo Vora on 5/10/21.
//  Copyright © 2021 Ocean Blue Project. All rights reserved.
//

import Foundation

let onboardingPages: [OnboardingPage] =
    [OnboardingPage(imageName: "onboarding0",
                    title: "Ocean Blue Mission",
                    description: "Join us for a mission that's as vast, critical, and inspiring as the Ocean itself.",
                    buttonText: "Join Us!"),
    OnboardingPage(imageName: "onboarding1",
                   title: "One World Ocean",
                   description: "Every stream, river, and ocean is part of a single global ecosystem: One World Ocean.",
                   buttonText: "Get Ready!"),
    OnboardingPage(imageName: "onboarding2",
                   title: "Pick up 3 for the Sea",
                   description: "Pick up at least 3 pieces of plastic daily at your neighborhood park, river, beach, or sidewalk and keep track of your impact!",
                   buttonText: "Get Set!"),
    OnboardingPage(imageName: "onboarding3",
                   title: "Save the Ocean Together",
                   description: "Request a cleanup and Ocean Blue Project can help you organize a cleanup at your local beach or river!",
                   buttonText: "Go!")]

let userDefaults = UserDefaults.standard

struct TFSUserDefaults {
    static let hasCompletedOnboarding = "hasCompletedOnboarding"
}
