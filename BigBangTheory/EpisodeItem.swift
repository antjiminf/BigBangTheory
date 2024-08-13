import SwiftUI

struct EpisodeItem: View {
    let episode: Episode
    
    var body: some View {
        HStack {
            Image(episode.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            
            VStack(alignment: .leading) {
                Text(episode.name)
                    .font(.headline)
                Text("Season \(episode.season.description) - Episode \(episode.number.description)")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                
                HStack{
                    Group {
                        if let rating = episode.rating {
                            ForEach(1..<6) { i in
                                Image(systemName: i <= rating ? "star.fill" : "star")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 12)
                            }
                        } else {
                            ForEach(1..<6) { i in
                                Image(systemName: "star")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 12)
                            }
                        }
                    }
                }
            }.padding(.leading, 5)
            Spacer()
            VStack {
                
                Image(systemName: episode.favorite ? "heart.fill" : "heart")
                    .foregroundStyle(episode.favorite ? .red : .blue)
                    .padding(.bottom, 10)
                
                Image(systemName: episode.viewed ? "eye.fill" : "eye.slash.fill")
                
            }
        }
    }
}

#Preview {
    EpisodeItem(episode: .episodeTest)
}
