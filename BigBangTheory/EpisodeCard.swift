import SwiftUI

struct EpisodeCard: View {
    let episode: Episode
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            Image(episode.image)
                .resizable()
                .scaledToFill()
                .frame(width: 160, height: 150)
                .clipped()
                .overlay(
                    ZStack(alignment: .bottom) {
                        LinearGradient(
                            gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                        Text(episode.name.uppercased())
                            .font(.custom("Impact", size: 20))
                            .foregroundStyle(Color.white)
                            .bold()
                            .padding(.bottom, 10)
                    }
                )
                .cornerRadius(10)
            Image(systemName: "heart.fill")
                .font(.title2)
                .foregroundStyle(.red)
                .padding(8)
            
        }
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
    
}

#Preview {
    EpisodeCard(episode: .episodeTest)
}
