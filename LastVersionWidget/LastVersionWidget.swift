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
        let object = self.loadStructFromUserDefaults(VersionModel.self, forKey: "nextRace",
                                                     suiteName: "group.devcodereleases")
        let currentDate = Date()
        let nextUpdateDate = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()

        let entry = LatestVersionEntry(date: currentDate,
                                       compilers: object?.compilers,
                                       requires: object?.requires,
                                       versionDate: object?.date,
                                       version: object?.version,
                                       name: object?.name)
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
}

struct LastVersionWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)

            Text(entry.name ?? "nada")
        }
    }
}

struct LastVersionWidget: Widget {
    let kind: String = "LastVersionWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                LastVersionWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                LastVersionWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    LastVersionWidget()
} timeline: {
    versionEntryExample
}

let versionEntryExample = LatestVersionEntry(date: Date.now,
                                             compilers: Compilers(clang: nil,
                                                                  swift: nil,
                                                                  llvm: nil,
                                                                  llvmGCC: nil,
                                                                  gcc: nil),
                                             requires: "14.0",
                                             versionDate: DateClass(year: 2024, month: 04, day: 16),
                                             version: Version(number: "15.4",
                                                              build: "15F5021i",
                                                              release: VersionRelease(rc: nil,
                                                                                      release: nil,
                                                                                      beta: 1,
                                                                                      gm: nil,
                                                                                      gmSeed: nil,
                                                                                      dp: nil)),
                                             name: "15.4")
