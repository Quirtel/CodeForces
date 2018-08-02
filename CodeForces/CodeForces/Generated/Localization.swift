// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
internal enum L10n {

  internal enum Alert {

    internal enum Action {
      /// OK
      internal static let ok = L10n.tr("Localizable", "Alert.Action.ok")
    }

    internal enum Title {
      /// Error
      internal static let error = L10n.tr("Localizable", "Alert.title.error")
    }
  }

  internal enum ContestsVc {
    /// Contests
    internal static let title = L10n.tr("Localizable", "Contests_VC.title")

    internal enum AlertHandleError {
      /// Handle contains invalid characters
      internal static let message = L10n.tr("Localizable", "Contests_VC.Alert_Handle_Error.message")
    }

    internal enum AlertResponseError {
      /// Failed to get the contests. Please try again later
      internal static let message = L10n.tr("Localizable", "Contests_VC.Alert_Response_Error.message")
    }

    internal enum FinishedEventsSection {
      /// Finished contests
      internal static let title = L10n.tr("Localizable", "Contests_VC.Finished_Events_Section.title")
    }

    internal enum StatusCell {
      ///  KB
      internal static let memoryConsumptionLabel = L10n.tr("Localizable", "Contests_VC.Status_Cell.Memory_Consumption_Label")
      ///  ms
      internal static let timeConsumptionLabel = L10n.tr("Localizable", "Contests_VC.Status_Cell.Time_Consumption_Label")

      internal enum Verdict {
        /// Compilation error
        internal static let compilationError = L10n.tr("Localizable", "Contests_VC.Status_Cell.verdict.Compilation_Error")
        /// Memory limit exceeded
        internal static let memoryLimitExceeded = L10n.tr("Localizable", "Contests_VC.Status_Cell.verdict.Memory_Limit_Exceeded")
        /// OK
        internal static let ok = L10n.tr("Localizable", "Contests_VC.Status_Cell.verdict.ok")
        /// Rejected
        internal static let rejected = L10n.tr("Localizable", "Contests_VC.Status_Cell.verdict.Rejected")
        /// Runtime error
        internal static let runtimeError = L10n.tr("Localizable", "Contests_VC.Status_Cell.verdict.Runtime_Error")
        /// Security violated
        internal static let securityViolated = L10n.tr("Localizable", "Contests_VC.Status_Cell.verdict.Security_Violated")
        /// Testing
        internal static let testing = L10n.tr("Localizable", "Contests_VC.Status_Cell.verdict.testing")
        /// Time limit exceeded
        internal static let timeLimitExceeded = L10n.tr("Localizable", "Contests_VC.Status_Cell.verdict.Time_Limit_Exceeded")
        /// Wrong answer on test
        internal static let wrongAnswer = L10n.tr("Localizable", "Contests_VC.Status_Cell.verdict.Wrong_Answer")
      }
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

  internal enum SettingsVc {
    /// Settings
    internal static let title = L10n.tr("Localizable", "Settings_VC.title")

    internal enum Cache {
      /// Cache time:
      internal static let title = L10n.tr("Localizable", "Settings_VC.cache.title")

      internal enum Time {
        /// Never
        internal static let never = L10n.tr("Localizable", "Settings_VC.cache.time.never")
        /// One day
        internal static let oneday = L10n.tr("Localizable", "Settings_VC.cache.time.oneday")
        /// Three days
        internal static let threedays = L10n.tr("Localizable", "Settings_VC.cache.time.threedays")
        /// Two days
        internal static let twodays = L10n.tr("Localizable", "Settings_VC.cache.time.twodays")
        /// Week
        internal static let week = L10n.tr("Localizable", "Settings_VC.cache.time.week")
      }
    }

    internal enum Theme {
      /// Dark
      internal static let dark = L10n.tr("Localizable", "Settings_VC.theme.dark")
      /// Light
      internal static let light = L10n.tr("Localizable", "Settings_VC.theme.light")
      /// Theme:
      internal static let title = L10n.tr("Localizable", "Settings_VC.theme.title")
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

    internal enum Searchscope {

      internal enum Title {
        /// Names
        internal static let name = L10n.tr("Localizable", "Tasks_VC.SearchScope.title.name")
        /// Tags
        internal static let tags = L10n.tr("Localizable", "Tasks_VC.SearchScope.title.tags")
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
