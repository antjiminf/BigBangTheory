import SwiftUI

struct FavoriteGridView: View {
    @EnvironmentObject var vm: EpisodesVM
    
    let adaptativeGrid: [GridItem] = [GridItem(.adaptive(minimum: 160))]
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(alignment: .leading){
                    HStack{
                        Text("Favorite episodes")
                            .font(.custom("Impact", size: 35))
                        Image(systemName: "atom")
                    }
                    .font(.largeTitle)
                    .padding()
                    Group {
                        if vm.favorites.isEmpty{
                            ContentUnavailableView(
                                "No favorite episodes",
                                systemImage: "heart.slash.fill",
                                description: Text("There are no favorite episodes and is Big Bang what we talking about!"))
                        } else {
                            LazyVGrid(columns: adaptativeGrid) {
                                ForEach(vm.favorites) { ep in
                                    NavigationLink(value: ep){
                                        EpisodeCard(episode: ep)
                                    }
                                }
                            }
                        }
                    }
                    .navigationDestination(for: Episode.self){ episode in
                        EpisodeDetails2View(reviewVm: EpisodeReviewVM(episode: episode))
                    }
                    
                }
            }.safeAreaPadding()
        }
    }
    
}

#Preview {
    FavoriteGridView.preview
}
