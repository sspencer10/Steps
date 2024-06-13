//
//  ContentView.swift
//  Steps
//
//  Created by Brittany Rima on 12/6/22.
//

import SwiftUI
import HealthKit

struct HomeView: View {
    @ObservedObject var viewModel: StepsViewModel
    @ObservedObject var settingsViewModel: SettingsViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                MountainView(viewModel: viewModel)
                    .edgesIgnoringSafeArea(.all)

                NavigationLink {
                    StepsDetailView(viewModel: viewModel, settingsViewModel: settingsViewModel, units: StepsViewModel())
                } label: {
                    VStack {
                        Spacer()
                        HStack {
                            CurrentStepsCardView(steps: viewModel.currentSteps)
                            Spacer()
                        }
                        .padding()
                        Spacer()
                    }
                    .padding(.bottom, 100)
                }
            }
            .onAppear {
                viewModel.update()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: StepsViewModel(), settingsViewModel: SettingsViewModel())
    }
}

