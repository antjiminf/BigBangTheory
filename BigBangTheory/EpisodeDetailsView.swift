import SwiftUI

struct EpisodeDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.dynamicTypeSize) private var typeSize
    @FocusState var focusState: Bool
    @EnvironmentObject private var episodeVm: EpisodesVM
    @ObservedObject var reviewVm: EpisodeReviewVM
    
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            Form {
                Section{
                    ZStack(alignment: .bottom) {
                        Image(reviewVm.episode.image)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .clipped()
                            .accessibilityLabel(Text("Image of the episode"))
                        
                        LinearGradient(
                            gradient: Gradient(colors: [Color.black.opacity(0.6), Color.black.opacity(0)]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                        .frame(height: 100)
                        Text(reviewVm.episode.name.uppercased())
                            .font(.custom("Impact", size: 20))
                            .colorInvert()
                            .bold()
                            .padding(.bottom, 10)
                        
                    }
                    .frame(height: 200)
                    
                    VStack(alignment: .leading) {
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
                    }
                } header: {
                    Text("Episode details")
                }
                
                Section{
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Rating")
                                .bold()
                                .accessibilityHidden(true)
                            Spacer()
                            ForEach(1..<6, id: \.self) { number in
                                let isFirst = number == 1
                                Image(systemName: number <= reviewVm.rating ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                                    .onTapGesture {
                                        reviewVm.rating = number
                                    }
                                    .accessibilityLabel(Text("^[\(number) star](inflect: true)"))
                                    .accessibilityAddTraits(.isButton)
                                    .accessibilityHint(Text("\(isFirst ? "Composed button of  5 stars icons to rate the episode, tab on the desired" : "")"))
                            }
                        }
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 0))
                        
                        Divider()
                        
                        if typeSize.isAccessibilitySize {
                            favAndViewed
                        } else {
                            HStack {
                                favAndViewed
                            }
                        }
                        
                        Divider()
                        
                        Text("Note")
                            .bold()
                            .accessibilityHidden(true)
                            .padding(.top, 10)
                        TextField("Enter a note about this episode", text: $reviewVm.note, axis: .vertical)
                            .lineLimit(4, reservesSpace: true)
                            .keyboardType(.asciiCapable)
                            .textInputAutocapitalization(.sentences)
                            .accessibilityLabel(Text("Note about episode"))
                            .focused($focusState)
                    }
                    
                } header: {
                    Text("Episode review")
                }
            }
            .navigationTitle("Episode Details")
            .navigationBarTitleDisplayMode(.inline)
            .textFieldStyle(.roundedBorder)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        episodeVm.updateEpisode(episode: reviewVm.updateEpisode())
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                    .disabled(reviewVm.changed ? false : true)
                    .accessibilityHint(Text("This button will activate with any change done"))
                    //                    .opacity(actionsVM.changed ? 1 : 0)
                }
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button {
                            focusState = false
                        } label: {
                            Image(systemName: "keyboard.chevron.compact.down.fill")
                        }
                    }
                }
            }
            .onTapGesture {
                if focusState {
                    focusState = false
                }
            }
            
            Link(destination: reviewVm.episode.url) {
                        Text("WATCH HERE!")
                            .bold()
                            .font(.subheadline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
            .padding()
            .opacity(focusState ? 0 : 1)
            .disabled(focusState)
            .accessibilityHint(Text("Click here to watch this episode online"))
            
//            VStack(alignment: .center) {
//                Text("Watch")
//                    .font(.title3)
//                    .foregroundStyle(.blue)
//                    .bold()
//                Button {
//                    
//                } label: {
//                    Image(systemName: "video.fill")
//                        .font(.title)
//                        .padding(20)
//                        .foregroundStyle(.white)
//                        .background(Color.blue)
//                        .clipShape(Circle())
//                }
//            }
//            .padding()
            
        }
    }
    
    var favAndViewed: some View {
        Group {
            HStack {
                Text("Favorited")
                    .bold()
                    .accessibilityHidden(true)
                
                
                Toggle(isOn: $reviewVm.favorited) {
                    Image(systemName: reviewVm.favorited ? "heart.fill" : "heart")
                }
                .toggleStyle(.button)
                .tint(reviewVm.favorited ? .red : .blue)
                .accessibilityLabel(Text("Favorite"))
                .accessibilityValue(Text("\(reviewVm.favorited)"))
                .accessibilityHint(Text("Tab to mark as favorite"))
            }
            Spacer()
            HStack {
                Text("Watched")
                    .bold()
                    .accessibilityHidden(true)
                
                Toggle(isOn: $reviewVm.viewed) {
                    Image(systemName: reviewVm.viewed ? "eye.fill" : "eye.slash.fill")
                }
                .toggleStyle(.button)
                .tint(.black)
                .accessibilityLabel(Text("Watched"))
                .accessibilityValue(Text("\(reviewVm.viewed)"))
                .accessibilityHint(Text("Tab to mark as seen episode"))
            }
        }
        
    }
}


#Preview {
    EpisodeDetailsView.preview
}
