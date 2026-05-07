import Foundation

extension ClientNotification {
	/// Whether this notification mutates the server's state.
	public var mutatesServerState: Bool {
		return true
	}
}

extension ClientRequest {
	/// Whether this request mutates the server's state.
	public var mutatesServerState: Bool {
		switch self {
		case .initialize:
			return true
		case .shutdown:
			return true
		case .workspaceWillCreateFiles:
			return true
		case .workspaceWillRenameFiles:
			return true
		case .workspaceWillDeleteFiles:
			return true
		case .textDocumentWillSaveWaitUntil:
			return true
		case .custom:
			return true
		default:
			return false
		}
	}
}
