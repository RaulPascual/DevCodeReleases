//
//  LastVersionWidget.swift
//  LastVersionWidget
//
//  Created by Raul on 18/4/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> LatestVersionEntry {
        versionEntryExample
    }

    func getSnapshot(in context: Context, completion: @escaping (LatestVersionEntry) -> Void) {
        let entry = versionEntryExample
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        var entries: [LatestVersionEntry] = []
        let object = self.loadStructFromUserDefaults(VersionModel.self, forKey: "lastVersion",
                                                     suiteName: "group.devcodereleases")
        let currentDate = Date()
        let nextUpdateDate = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()

        let entry = LatestVersionEntry(date: currentDate,
                                       compilers: object?.compilers,
                                       requires: object?.requires,
                                       versionDate: object?.date,
                                       version: object?.version,
                                       name: object?.name,
                                       sdks: object?.sdks)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .after(nextUpdateDate))
        completion(timeline)
    }

    func loadStructFromUserDefaults<T: Codable>(_ type: T.Type, forKey key: String, suiteName: String? = nil) -> T? {
        let decoder = JSONDecoder()

        let userDefaults: UserDefaults
        if let suiteName = suiteName {
            userDefaults = UserDefaults(suiteName: suiteName) ?? UserDefaults.standard
        } else {
            userDefaults = UserDefaults.standard
        }

        if let data = userDefaults.data(forKey: key),
           let decoded = try? decoder.decode(type, from: data) {
            return decoded
        }

        return nil
    }
}

struct LatestVersionEntry: TimelineEntry {
    var date: Date
    let compilers: Compilers?
    let requires: String?
    let versionDate: DateClass?
    let version: Version?
    let name: String?
    let sdks: Sdks?
}

struct LastVersionWidgetEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {

        switch family {
        case .systemSmall:
            // MARK: - Small
            LastVersionWidgetViewSystemSmall(entry: entry)

        case .systemMedium:
            // MARK: - Medium
            LastVersionWidgetViewSystemMedium(entry: entry)

        case .systemLarge:
            // MARK: - Large
            LastVersionWidgetViewSystemLarge(entry: entry)

        case .systemExtraLarge, .accessoryCorner, .accessoryCircular, .accessoryInline, .accessoryRectangular:
            EmptyView()
        @unknown default:
            EmptyView()
        }
    }
}

// MARK: Small
struct LastVersionWidgetViewSystemSmall: View {
    var entry: Provider.Entry
    var body: some View {
        let version = VersionModel(compilers: entry.compilers,
                                   requires: entry.requires,
                                   date: entry.versionDate,
                                   links: nil,
                                   version: entry.version,
                                   sdks: nil,
                                   name: entry.name,
                                   checksums: nil)
        VStack {
            HStack {
                Image("xcodeIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                Text(version.version?.number ?? "")
                    .bold()

                Spacer()
            }

            HStack {
                Image("calendarIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)

                Text(Utils().formatDate(day: version.date?.day ?? 0,
                                        month: version.date?.month ?? 0,
                                        year: version.date?.year ?? 0,
                                        dateStyle: .short))
                Spacer()
            }

            HStack {
                Image("swiftIcon")
                    .resizable()
                    .frame(width: 35, height: 35)

                Text(version.compilers?.swift?.last?.number ?? "")

                Spacer()
            }

        }
    }
}

// MARK: Medium
struct LastVersionWidgetViewSystemMedium: View {
    var entry: Provider.Entry
    var body: some View {
        let version = VersionModel(compilers: entry.compilers,
                                   requires: entry.requires,
                                   date: entry.versionDate,
                                   links: nil,
                                   version: entry.version,
                                   sdks: nil,
                                   name: entry.name,
                                   checksums: nil)
        VStack {
            VersionView(version: version)

            HStack {
                Image("calendarIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)

                Text(Utils().formatDate(day: version.date?.day ?? 0,
                                        month: version.date?.month ?? 0,
                                        year: version.date?.year ?? 0,
                                        dateStyle: .full))
                Spacer()
            }

            HStack {
                HStack {
                    Image("swiftIcon")
                        .resizable()
                        .frame(width: 35, height: 35)

                    Text(version.compilers?.swift?.last?.number ?? "")
                }

                Spacer()

                HStack {
                    Image("iosIcon")
                        .resizable()
                        .frame(width: 35, height: 35)

                    Text("\(version.sdks?.iOS?.last?.number ?? "-")")
                        .bold(true)
                }
            }
        }
    }
}

// MARK: Large
struct LastVersionWidgetViewSystemLarge: View {
    var entry: Provider.Entry
    var body: some View {
        VStack {
            Text(entry.name ?? "")
        }
    }
}

struct LastVersionWidget: Widget {
    let kind: String = "LastVersionWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                LastVersionWidgetEntryView(entry: entry)
                    .containerBackground(.blue.opacity(0.3), for: .widget)
            } else {
                LastVersionWidgetEntryView(entry: entry)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.blue.opacity(0.3))
            }
        }
        .configurationDisplayName("Last version")
        .description("Shows the last version available")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    LastVersionWidget()
} timeline: {
    versionEntryExample
}

let versionEntryExample = LatestVersionEntry(date: Date.now,
                                             compilers: Compilers(
                                                clang: [
                                                    Clang(
                                                        number: "15.0.0",
                                                        build: "1500.3.9.4",
                                                        release: ClangRelease(release: true)
                                                    )
                                                ],
                                                swift: [
                                                    Clang(
                                                        number: "5.10",
                                                        build: "5.10.0.13",
                                                        release: ClangRelease(release: true)
                                                    )
                                                ],
                                                llvm: nil,
                                                llvmGCC: nil,
                                                gcc: nil
                                             ),
                                             requires: "14.0",
                                             versionDate: DateClass(year: 2024, month: 04, day: 16),
                                             version: Version(
                                                number: "15.4",
                                                build: "15F5021i",
                                                release: VersionRelease(
                                                    rc: nil,
                                                    release: nil,
                                                    beta: 1,
                                                    gm: nil,
                                                    gmSeed: nil,
                                                    dp: nil
                                                )
                                             ),
                                             name: "Xcode",
                                             sdks: Sdks(macOS: [Clang(number: "14.5",
                                                                      build: "",
                                                                      release: nil)],
                                                        tvOS: nil,
                                                        iOS: [Clang(number: "17.5",
                                                                    build: nil,
                                                                    release: nil)],
                                                        watchOS: nil))
