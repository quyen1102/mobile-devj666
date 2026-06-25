import WidgetKit
import SwiftUI

struct SimpleEntry: TimelineEntry {
    let date: Date
    let username: String
    let lastUpdated: String
}

struct SampleDataWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), username: "Guest", lastUpdated: "Never")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(
            date: Date(),
            username: LichessAppGroup.username,
            lastUpdated: LichessAppGroup.lastUpdated
        )
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let entry = SimpleEntry(
            date: Date(),
            username: LichessAppGroup.username,
            lastUpdated: LichessAppGroup.lastUpdated
        )
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct SampleDataWidgetEntryView : View {
    var entry: SampleDataWidgetProvider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("App Widget")
                .font(.headline)
                .foregroundColor(.blue)
            
            Text("User: \(entry.username)")
                .font(.body)
            
            Text("Updated: \(entry.lastUpdated)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

struct SampleDataWidget: Widget {
    let kind: String = "SampleDataWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: SampleDataWidgetProvider()) { entry in
            SampleDataWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Sample Widget")
        .description("This is a sample widget demonstrating shared App Group data.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
