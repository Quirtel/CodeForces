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
