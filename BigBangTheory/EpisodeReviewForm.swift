import SwiftUI

struct EpisodeReviewForm: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.dynamicTypeSize) private var typeSize
    @EnvironmentObject private var episodeVm: EpisodesVM
    @ObservedObject var reviewVm: EpisodeReviewVM
    
    
    var body: some View {
        NavigationView {
            Form {
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
                            .lineLimit(5, reservesSpace: true)
                            .keyboardType(.asciiCapable)
                            .textInputAutocapitalization(.sentences)
                            .accessibilityLabel(Text("Note about episode"))
                    }
                    
                } header: {
                    Text("Episode review")
                }
            }
            .navigationTitle(Text("Episode Review"))
            .navigationBarTitleDisplayMode(.inline)
            .textFieldStyle(.roundedBorder)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        reviewVm.cancelChanges()
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                    .accessibilityHint(Text("This button will clean any change done which have not been saved"))
                }
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
            }
            
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
    EpisodeReviewForm.preview
}
