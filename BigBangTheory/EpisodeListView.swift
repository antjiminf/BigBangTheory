import SwiftUI

struct EpisodeListView: View {
    @EnvironmentObject var vm: EpisodesVM
    
    var body: some View {
        NavigationStack {
            Group {
                if !vm.filteredEpisodes.isEmpty {
                    List(vm.organizedEpisodes.keys.sorted(), id: \.self){ season in
                        
                        Section {
                            ForEach(vm.organizedEpisodes[season]!) { episode in
                                NavigationLink(value: episode) {
                                    EpisodeItem(episode: episode)
                                }
                            }
                        } header: {
                            HStack(alignment: .center) {
                                
                                Text("Season \(season)")
                                    .font(.headline)
                                Spacer()
                                Button {
                                    vm.watchSeason(season: season)
                                } label: {
                                    Text("Mark as watched")
                                        .font(.caption2)
                                            .foregroundColor(.white)
                                            .padding(10)
                                            .background(Color.blue)
                                            .cornerRadius(10)
                                            .shadow(color: .gray, radius: 5, x: 0, y: 2)
                                }
                                .accessibilityHint("Tap to mark whole season as watched")
                            }
                        }
                    }
                } else {
                    ContentUnavailableView(
                        "No episodes coincidences",
                        systemImage: "video.slash.fill",
                        description: Text("There are no episodes containing '\(vm.search)' in their title.")
                    )
                }
            }
            .navigationTitle("Episodes")
            .navigationDestination(for: Episode.self){ episode in
                EpisodeDetailsView(reviewVm: EpisodeReviewVM(episode: episode))
            }
            .searchable(text: $vm.search)
        }
    }
}

#Preview {
    EpisodeListView()
        .environmentObject(EpisodesVM(interactor: EpisodeInteractorTest()))
}
