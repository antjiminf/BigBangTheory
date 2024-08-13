import SwiftUI

struct EpisodeDetails2View: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var episodeVm: EpisodesVM
    @ObservedObject var reviewVm: EpisodeReviewVM
    @State private var showForm = false
    @State var detent: PresentationDetent = .fraction(0.75)
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack(alignment: .bottom) {
                    Image(reviewVm.episode.image)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: UIScreen.main.bounds.width)
                        .frame(height: 300)
                        .clipped()
                        .accessibilityLabel(Text("Image of the episode"))
                        .overlay(alignment: .top) {
                            LinearGradient(
                                gradient: Gradient(colors: [Color.black.opacity(0.7), Color.black.opacity(0)]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .frame(height: 250)
                        }
                    
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.8), Color.black.opacity(0)]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .frame(height: 100)
                    
                    HStack {
                        ForEach(1..<6, id: \.self) { number in
                            Image(systemName: number <= reviewVm.episode.rating ?? 0 ? "star.fill" : "star")
                                .foregroundStyle(.yellow)
                                .accessibilityLabel(Text("^[\(number) star](inflect: true)"))
                        }
                        Spacer()
                        Image(systemName: reviewVm.episode.favorite ? "heart.fill" : "heart")
                            .foregroundStyle(reviewVm.episode.favorite ? .red : .blue)
                            .font(.title2)
                        
                        Image(systemName: reviewVm.episode.viewed ? "eye.fill" : "eye.slash.fill")
                            .foregroundStyle(.white)
                            .font(.title2)
                            .padding(.leading, 8)
                    }
                    .padding()
                    
                }
                .frame(height: 300)
                
                VStack(alignment: .leading) {
                    
                    HStack{
                        Text(reviewVm.episode.name.uppercased())
                            .font(.custom("Impact", size: 25))
                            .foregroundStyle(.primary)
                            .bold()
                        
                        Spacer()
                        Image(systemName: "atom")
                            .font(.title)
                            .bold()
                    }
                    .padding(.bottom, 8)
                    
                    if !reviewVm.episode.note.isEmpty {
                        
                        HStack(alignment: .top) {
                            Text("Noted:")
                                .font(.title3)
                            Spacer()
                            Text(reviewVm.episode.note)
                                .font(.subheadline)
                                .padding()
                                .overlay {
                                    ZStack(alignment: .topTrailing) {
                                        Image(systemName: "pencil")
                                            .font(.footnote)
                                            .padding(3)
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.yellow.opacity(0.3))
                                            .shadow(radius: 5)
                                    }
                                        
                                }
                        }
                        .bold()
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Season \(reviewVm.episode.season) · Episode \(reviewVm.episode.number) (\(reviewVm.episode.runtime) min)")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .bold()
                            .padding(.bottom, 5)
                        Spacer()
                        Text("Airdate: \(reviewVm.episode.airdate)")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .bold()
                            .padding(.bottom, 5)
                    }
                    
                    Text(reviewVm.episode.summary)
                        .font(.subheadline)
                        .bold()
                    
                    HStack {
                        Text("Watch it")
                        Link(destination: URL(string: "\(reviewVm.episode.url)")!) {
                            Text("here!")
                            Image(systemName: "video")
                        }
                        .accessibilityHint(Text("Click here to watch de episode online"))
                    }
                    .bold()
                    .font(.subheadline)

                }
                .safeAreaPadding()
            }
            .sheet(isPresented: $showForm) {
                EpisodeReviewForm(reviewVm: reviewVm)
                    .presentationDetents([.large, .fraction(0.75)],
                                         selection: $detent)
                    .presentationBackgroundInteraction(.enabled)
            }
            .padding(.bottom, 20)
        }
        .ignoresSafeArea(edges: .top)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Review") {
                    showForm.toggle()
                }
                .accessibilityHint(Text("Tap to open the review sheet"))
            }
        }
    }
}

#Preview {
    EpisodeDetails2View.preview
}
