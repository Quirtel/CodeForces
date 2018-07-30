// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
internal enum L10n {

  internal enum ContestsVc {
    /// Contests
    internal static let title = L10n.tr("Localizable", "Contests_VC.title")

    internal enum FinishedEventsSection {
      /// Finished contests
      internal static let title = L10n.tr("Localizable", "Contests_VC.Finished_Events_Section.title")
    }

    internal enum TableViewCell {

      internal enum ContestInProgress {
        /// In progress
        internal static let text = L10n.tr("Localizable", "Contests_VC.Table_View_Cell.Contest_In_Progress.text")
      }

      internal enum Finished {
        /// Finished
        internal static let text = L10n.tr("Localizable", "Contests_VC.Table_View_Cell.Finished.text")
      }

      internal enum PendingTest {
        /// Pending test
        internal static let text = L10n.tr("Localizable", "Contests_VC.Table_View_Cell.Pending_Test.text")
      }

      internal enum SystemTesting {
        /// System testing in progress
        internal static let text = L10n.tr("Localizable", "Contests_VC.Table_View_Cell.System_Testing.text")
      }
    }

    internal enum UpcomingEventsSection {
      /// Upcoming contests
      internal static let title = L10n.tr("Localizable", "Contests_VC.Upcoming_Events_Section.title")
    }
  }

  internal enum TasksVc {
    /// Tasks
    internal static let title = L10n.tr("Localizable", "Tasks_VC.title")

    internal enum Cell {

      internal enum Header {

        internal enum SolvedCountLabel {
          /// Solved count:
          internal static let text = L10n.tr("Localizable", "Tasks_VC.cell.header.solved_count_label.text")
        }
      }
    }
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
