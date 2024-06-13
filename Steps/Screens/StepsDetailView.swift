import SwiftUI
import HealthKit

struct StepsDetailView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: StepsViewModel
    @ObservedObject var settingsViewModel: SettingsViewModel
    @ObservedObject var units: StepsViewModel
    @AppStorage(Constants.unitsKey) var unitPref: String = "ft"
    @AppStorage(Constants.metricKey) var metric: Bool = false
    
    var body: some View {
        
        ScrollView{
            
            VStack(spacing: 20) {
                let formattedFloat = String(format: "%.1f", viewModel.currentDistance2)
                FactView(viewModel: viewModel)
                CircleProgressBar(value: viewModel.currentSteps, maxValue: viewModel.goal)
                    .padding()
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2), content: {
                    StepsDetailCardView(title: Constants.caloriesBurned, image: "flame.fill", value: "\(viewModel.currentCalories) kcal")
                    StepsDetailCardView(title: Constants.distance, image: "figure.walk", value: "\(formattedFloat) \(viewModel.unit)")
                })
                
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
            
            NewWeekStepsView(viewModel: viewModel)
            Spacer()
        }
        .padding(.top, 30)
        .padding(.horizontal)

        .refreshable {
            dismiss()
        }
        .onAppear {
            if (viewModel.shouldRefresh) {
                DispatchQueue.main.async {
                    viewModel.shouldRefresh = false
                }
                viewModel.update()
                dismiss()
            }
        }
    }
}

struct StepsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StepsDetailView(viewModel: StepsViewModel(), settingsViewModel: SettingsViewModel(), units: StepsViewModel())
    }
}

