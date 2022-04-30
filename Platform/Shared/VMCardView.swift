//
// Copyright © 2020 osy. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import SwiftUI

@available(iOS 14, macOS 11, *)
struct VMCardView: View {
    @ObservedObject var vm: UTMVirtualMachine
    @EnvironmentObject private var data: UTMData
    
    #if os(macOS)
    let buttonColor: Color = .black
    typealias PlatformImage = NSImage
    #else
    let buttonColor: Color = .accentColor
    typealias PlatformImage = UIImage
    #endif
    
    var body: some View {
        HStack {
            if vm.isShortcut {
                Logo(logo: PlatformImage(contentsOfURL: vm.detailsIconUrl))
                        .overlay(Image(systemName: "arrowshape.turn.up.forward.fill")
                                    .resizable()
                                    .frame(width: 8, height: 8)
                                    .aspectRatio(contentMode: .fit), alignment: .bottomLeading)
            } else {
                Logo(logo: PlatformImage(contentsOfURL: vm.detailsIconUrl))
            }
            VStack(alignment: .leading) {
                Text(vm.detailsTitleLabel)
                    .font(.headline)
                Text(vm.detailsSubtitleLabel)
                    .font(.subheadline)
            }.lineLimit(1)
            .truncationMode(.tail)
            Spacer()
            Button {
                data.run(vm: vm)
            } label: {
                Label("Run", systemImage: "play.circle")
                    .font(.largeTitle)
                    .foregroundColor(buttonColor)
                    .labelStyle(.iconOnly)
            }
        }.padding([.top, .bottom], 10)
        .buttonStyle(.plain)
    }
}

@available(iOS 14, macOS 11, *)
struct CardView: View {
    @EnvironmentObject private var data: UTMData
    
    #if os(macOS)
    let buttonColor: Color = .black
    typealias PlatformImage = NSImage
    #else
    let buttonColor: Color = .accentColor
    typealias PlatformImage = UIImage
    #endif
    
    var title: String
    var subtitle: String
    var systemImage: String
    
    var body: some View {
        HStack {
            Logo(logo: PlatformImage(systemSymbolName: systemImage, accessibilityDescription: nil)!)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.subheadline)
            }.lineLimit(1)
            .truncationMode(.tail)
        }.padding([.top, .bottom], 10)
        .buttonStyle(.plain)
    }
}

#if os(macOS)
@available(macOS 11, *)
struct Logo: View {
    let logo: NSImage?
    
    var body: some View {
        Group {
            if logo != nil {
                Image(nsImage: logo!)
                    .resizable()
                    .frame(width: 30.0, height: 30.0)
                    .aspectRatio(contentMode: .fit)
            } else {
                Image(systemName: "desktopcomputer")
                    .resizable()
                    .frame(width: 30.0, height: 30.0)
                    .foregroundColor(.accentColor)
            }
        }
    }
}
#else // iOS
@available(iOS 14, *)
struct Logo: View {
    let logo: UIImage?
    
    var body: some View {
        Group {
            if logo != nil {
                Image(uiImage: logo!)
                    .resizable()
                    .frame(width: 30.0, height: 30.0)
                    .aspectRatio(contentMode: .fit)
            } else {
                Image(systemName: "desktopcomputer")
                    .resizable()
                    .frame(width: 30.0, height: 30.0)
            }
        }
    }
}
#endif

@available(iOS 14, macOS 11, *)
struct VMCardView_Previews: PreviewProvider {
    static var previews: some View {
        VMCardView(vm: UTMVirtualMachine(configuration: UTMQemuConfiguration(), withDestinationURL: URL(fileURLWithPath: "/")))
    }
}
