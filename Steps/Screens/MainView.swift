//
//  MainView.swift
//  Steps
//
//  Created by Brittany Rima on 12/13/22.
//

import SwiftUI

struct MainView: View {
    @StateObject var stepsViewModel = StepsViewModel()

    var body: some View {
        TabView {
            HomeView(viewModel: stepsViewModel, settingsViewModel: SettingsViewModel())
                .tabItem {
                    Label(Constants.homeTab, systemImage: "house")
                }

            GoalView(viewModel: .init())
                .tabItem {
                    Label(Constants.goalsTab, systemImage: "checklist")
                }

            AwardView(viewModel: stepsViewModel)
                .tabItem {
                    Label(Constants.awardsTab, systemImage: "trophy")
                }

            SettingsView(stepsViewModel: stepsViewModel)
                .tabItem {
                    Label(Constants.settingsTab, systemImage: "slider.vertical.3")
                }
        }
        .tint(.indigo)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
