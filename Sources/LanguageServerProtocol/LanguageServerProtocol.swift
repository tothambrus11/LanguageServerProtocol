import JSONRPC

/// A placeholder type for responses that are not used.
public typealias UnusedResult = LSPAny?
/// A placeholder type for request parameters that are not used.
public typealias UnusedParam = LSPAny?

/// An error that occurs during LSP message dispatch.
public enum ProtocolError: Error {
	/// The method string was not recognized.
	case unrecognizedMethod(String)
	/// Required parameters were missing from the message.
	case missingParams
	/// A dynamic registration method was not handled.
	case unhandledRegistrationMethod(String)
	/// No reply was available for a request.
	case missingReply
}

/// An event received by a server from a client.
public enum ClientEvent: Sendable {
	/// The result type for request handlers.
	public typealias RequestResult = Result<Encodable & Sendable, AnyJSONRPCResponseError>
	/// A closure that handles a request result.
	public typealias RequestHandler = @Sendable (RequestResult) async -> Void

	/// A request with its JSON-RPC id.
	case request(id: JSONId, request: ClientRequest)
	/// A notification.
	case notification(ClientNotification)
	/// A protocol-level error.
	case error(Error)
}

/// An event received by a client from a server.
public enum ServerEvent: Sendable {
	/// The result type for request handlers.
	public typealias RequestResult = Result<Encodable & Sendable, AnyJSONRPCResponseError>
	/// A closure that handles a request result.
	public typealias RequestHandler = @Sendable (RequestResult) async -> Void

	/// A request with its JSON-RPC id.
	case request(id: JSONId, request: ServerRequest)
	/// A notification.
	case notification(ServerNotification)
	/// A protocol-level error.
	case error(Error)
	// case error(ServerError)
}

/// A notification sent from the client to the server.
public enum ClientNotification: Sendable, Hashable {
	/// The LSP method string for each client notification.
	public enum Method: String, Hashable, Sendable {
		case initialized
		case exit
		case windowWorkDoneProgressCancel = "window/workDoneProgress/cancel"
		case workspaceDidChangeWatchedFiles = "workspace/didChangeWatchedFiles"
		case workspaceDidChangeConfiguration = "workspace/didChangeConfiguration"
		case workspaceDidChangeWorkspaceFolders = "workspace/didChangeWorkspaceFolders"
		case workspaceDidCreateFiles = "workspace/didCreateFiles"
		case workspaceDidRenameFiles = "workspace/didRenameFiles"
		case workspaceDidDeleteFiles = "workspace/didDeleteFiles"
		case textDocumentDidOpen = "textDocument/didOpen"
		case textDocumentDidChange = "textDocument/didChange"
		case textDocumentDidClose = "textDocument/didClose"
		case textDocumentWillSave = "textDocument/willSave"
		case textDocumentDidSave = "textDocument/didSave"
		case protocolCancelRequest = "$/cancelRequest"
		case protocolSetTrace = "$/setTrace"
	}

	case initialized(InitializedParams)
	case exit
	case textDocumentDidOpen(DidOpenTextDocumentParams)
	case textDocumentDidChange(DidChangeTextDocumentParams)
	case textDocumentDidClose(DidCloseTextDocumentParams)
	case textDocumentWillSave(WillSaveTextDocumentParams)
	case textDocumentDidSave(DidSaveTextDocumentParams)
	case protocolCancelRequest(CancelParams)
	case protocolSetTrace(SetTraceParams)
	case workspaceDidChangeWatchedFiles(DidChangeWatchedFilesParams)
	case windowWorkDoneProgressCancel(WorkDoneProgressCancelParams)
	case workspaceDidChangeWorkspaceFolders(DidChangeWorkspaceFoldersParams)
	case workspaceDidChangeConfiguration(DidChangeConfigurationParams)
	case workspaceDidCreateFiles(CreateFilesParams)
	case workspaceDidRenameFiles(RenameFilesParams)
	case workspaceDidDeleteFiles(DeleteFilesParams)

	/// The method string corresponding to this notification.
	public var method: Method {
		switch self {
		case .initialized:
			return .initialized
		case .exit:
			return .exit
		case .textDocumentDidChange:
			return .textDocumentDidChange
		case .textDocumentDidOpen:
			return .textDocumentDidOpen
		case .textDocumentDidClose:
			return .textDocumentDidClose
		case .textDocumentWillSave:
			return .textDocumentWillSave
		case .textDocumentDidSave:
			return .textDocumentDidSave
		case .workspaceDidChangeWatchedFiles:
			return .workspaceDidChangeWatchedFiles
		case .protocolCancelRequest:
			return .protocolCancelRequest
		case .protocolSetTrace:
			return .protocolSetTrace
		case .windowWorkDoneProgressCancel:
			return .windowWorkDoneProgressCancel
		case .workspaceDidChangeWorkspaceFolders:
			return .workspaceDidChangeWorkspaceFolders
		case .workspaceDidChangeConfiguration:
			return .workspaceDidChangeConfiguration
		case .workspaceDidCreateFiles:
			return .workspaceDidCreateFiles
		case .workspaceDidRenameFiles:
			return .workspaceDidRenameFiles
		case .workspaceDidDeleteFiles:
			return .workspaceDidDeleteFiles
		}
	}
}

/// A request sent from the client to the server.
public enum ClientRequest: Sendable {
	/// A closure that handles a typed response.
	public typealias Handler<T: Sendable & Encodable> = @Sendable (
		Result<T, AnyJSONRPCResponseError>
	) async -> Void
	/// A closure that handles an error-only response.
	public typealias ErrorOnlyHandler = @Sendable (AnyJSONRPCResponseError?) async -> Void

	// NOTE: The same `ClientRequest` type is used on the client side and the server side, only the server use the handler to send back the response, on the client side we use the `NullHandler`, which will never be called
	/// A no-op handler used on the client side where no response callback is needed.
	@Sendable
	public static func NullHandler<T>(result: Result<T, AnyJSONRPCResponseError>) async {
		// throw NullHandlerError.notImplemented(result)
	}

	/// The LSP method string for each client request.
	public enum Method: String, Hashable, Sendable {
		case initialize
		case shutdown
		case workspaceExecuteCommand = "workspace/executeCommand"
		case workspaceInlayHintRefresh = "workspace/inlayHint/refresh"
		case workspaceWillCreateFiles = "workspace/willCreateFiles"
		case workspaceWillRenameFiles = "workspace/willRenameFiles"
		case workspaceWillDeleteFiles = "workspace/willDeleteFiles"
		case workspaceSymbol = "workspace/symbol"
		case workspaceSymbolResolve = "workspaceSymbol/resolve"
		case textDocumentWillSaveWaitUntil = "textDocument/willSaveWaitUntil"
		case textDocumentCompletion = "textDocument/completion"
		case completionItemResolve = "completionItem/resolve"
		case textDocumentHover = "textDocument/hover"
		case textDocumentSignatureHelp = "textDocument/signatureHelp"
		case textDocumentDeclaration = "textDocument/declaration"
		case textDocumentDefinition = "textDocument/definition"
		case textDocumentPrepareTypeHierarchy = "textDocument/prepareTypeHierarchy"
		case textDocumentTypeDefinition = "textDocument/typeDefinition"
		case textDocumentImplementation = "textDocument/implementation"
		case textDocumentReferences = "textDocument/references"
		case textDocumentDocumentHighlight = "textDocument/documentHighlight"
		case textDocumentDocumentSymbol = "textDocument/documentSymbol"
		case textDocumentCodeAction = "textDocument/codeAction"
		case codeActionResolve = "codeAction/resolve"
		case codeLensResolve = "codeLens/resolve"
		case textDocumentCodeLens = "textDocument/codeLens"
		case textDocumentDiagnostic = "textDocument/diagnostic"
		case textDocumentDocumentLink = "textDocument/documentLink"
		case documentLinkResolve = "documentLink/resolve"
		case textDocumentDocumentColor = "textDocument/documentColor"
		case textDocumentColorPresentation = "textDocument/colorPresentation"
		case textDocumentFormatting = "textDocument/formatting"
		case textDocumentRangeFormatting = "textDocument/rangeFormatting"
		case textDocumentOnTypeFormatting = "textDocument/onTypeFormatting"
		case textDocumentRename = "textDocument/rename"
		case textDocumentInlayHint = "textDocument/inlayHint"
		case inlayHintResolve = "inlayHint/resolve"
		case textDocumentPrepareRename = "textDocument/prepareRename"
		case textDocumentPrepareCallHierarchy = "textDocument/prepareCallHierarchy"
		case textDocumentFoldingRange = "textDocument/foldingRange"
		case textDocumentSelectionRange = "textDocument/selectionRange"
		case textDocumentLinkedEditingRange = "textDocument/linkedEditingRange"
		case textDocumentSemanticTokens = "textDocument/semanticTokens"
		case textDocumentSemanticTokensRange = "textDocument/semanticTokens/range"
		case textDocumentSemanticTokensFull = "textDocument/semanticTokens/full"
		case textDocumentSemanticTokensFullDelta = "textDocument/semanticTokens/full/delta"
		case textDocumentMoniker = "textDocument/moniker"
		case callHierarchyIncomingCalls = "callHierarchy/incomingCalls"
		case callHierarchyOutgoingCalls = "callHierarchy/outgoingCalls"
		case typeHierarchySubtypes = "typeHierarchy/subtypes"
		case typeHierarchySupertypes = "typeHierarchy/supertypes"
		case custom
	}

	case initialize(InitializeParams, Handler<InitializationResponse>)
	case shutdown(Handler<LSPAny?>)
	case workspaceExecuteCommand(ExecuteCommandParams, Handler<LSPAny?>)
	case workspaceInlayHintRefresh(Handler<LSPAny?>)
	case workspaceWillCreateFiles(CreateFilesParams, Handler<WorkspaceEdit?>)
	case workspaceWillRenameFiles(RenameFilesParams, Handler<WorkspaceEdit?>)
	case workspaceWillDeleteFiles(DeleteFilesParams, Handler<WorkspaceEdit?>)
	case workspaceSymbol(WorkspaceSymbolParams, Handler<WorkspaceSymbolResponse>)
	case workspaceSymbolResolve(WorkspaceSymbol, Handler<WorkspaceSymbol>)
	case textDocumentWillSaveWaitUntil(WillSaveTextDocumentParams, Handler<[TextEdit]?>)
	case completion(CompletionParams, Handler<CompletionResponse>)
	case completionItemResolve(CompletionItem, Handler<CompletionItem>)
	case hover(TextDocumentPositionParams, Handler<HoverResponse>)
	case signatureHelp(TextDocumentPositionParams, Handler<SignatureHelpResponse>)
	case declaration(TextDocumentPositionParams, Handler<DeclarationResponse>)
	case definition(TextDocumentPositionParams, Handler<DefinitionResponse>)
	case typeDefinition(TextDocumentPositionParams, Handler<TypeDefinitionResponse>)
	case implementation(TextDocumentPositionParams, Handler<ImplementationResponse>)
	case diagnostics(DocumentDiagnosticParams, Handler<DocumentDiagnosticReport>)
	case documentHighlight(DocumentHighlightParams, Handler<DocumentHighlightResponse>)
	case documentSymbol(DocumentSymbolParams, Handler<DocumentSymbolResponse>)
	case codeAction(CodeActionParams, Handler<CodeActionResponse>)
	case codeActionResolve(CodeAction, Handler<CodeAction>)
	case codeLens(CodeLensParams, Handler<CodeLensResponse>)
	case codeLensResolve(CodeLens, Handler<CodeLens>)
	case selectionRange(SelectionRangeParams, Handler<SelectionRangeResponse>)
	case linkedEditingRange(LinkedEditingRangeParams, Handler<LinkedEditingRangeResponse>)
	case prepareCallHierarchy(CallHierarchyPrepareParams, Handler<CallHierarchyPrepareResponse>)
	case prepareRename(PrepareRenameParams, Handler<PrepareRenameResponse>)
	case prepareTypeHierarchy(TypeHierarchyPrepareParams, Handler<PrepareTypeHeirarchyResponse>)
	case rename(RenameParams, Handler<RenameResponse>)
	case inlayHint(InlayHintParams, Handler<InlayHintResponse>)
	case inlayHintResolve(InlayHint, Handler<InlayHintResponse>)
	case documentLink(DocumentLinkParams, Handler<DocumentLinkResponse>)
	case documentLinkResolve(DocumentLink, Handler<DocumentLink>)
	case documentColor(DocumentColorParams, Handler<DocumentColorResponse>)
	case colorPresentation(ColorPresentationParams, Handler<ColorPresentationResponse>)
	case formatting(DocumentFormattingParams, Handler<FormattingResult>)
	case rangeFormatting(DocumentRangeFormattingParams, Handler<FormattingResult>)
	case onTypeFormatting(DocumentOnTypeFormattingParams, Handler<FormattingResult>)
	case references(ReferenceParams, Handler<ReferenceResponse>)
	case foldingRange(FoldingRangeParams, Handler<FoldingRangeResponse>)
	case moniker(MonikerParams, Handler<MonikerResponse>)
	case semanticTokensFull(SemanticTokensParams, Handler<SemanticTokensResponse>)
	case semanticTokensFullDelta(SemanticTokensDeltaParams, Handler<SemanticTokensDeltaResponse>)
	case semanticTokensRange(SemanticTokensRangeParams, Handler<SemanticTokensResponse>)
	case callHierarchyIncomingCalls(
		CallHierarchyIncomingCallsParams, Handler<CallHierarchyIncomingCallsResponse>)
	case callHierarchyOutgoingCalls(
		CallHierarchyOutgoingCallsParams, Handler<CallHierarchyOutgoingCallsResponse>)
	case typeHierarchySubtypes(TypeHierarchySubtypesParams, Handler<TypeHierarchySubtypesResponse>)
	case typeHierarchySupertypes(
		TypeHierarchySupertypesParams, Handler<TypeHierarchySupertypesResponse>)
	case custom(String, LSPAny, Handler<LSPAny>)

	/// The method string corresponding to this request.
	public var method: Method {
		switch self {
		case .initialize:
			return .initialize
		case .shutdown:
			return .shutdown
		case .workspaceExecuteCommand:
			return .workspaceExecuteCommand
		case .workspaceInlayHintRefresh:
			return .workspaceInlayHintRefresh
		case .workspaceWillCreateFiles:
			return .workspaceWillCreateFiles
		case .workspaceWillRenameFiles:
			return .workspaceWillRenameFiles
		case .workspaceWillDeleteFiles:
			return .workspaceWillDeleteFiles
		case .workspaceSymbol:
			return .workspaceSymbol
		case .workspaceSymbolResolve:
			return .workspaceSymbolResolve
		case .textDocumentWillSaveWaitUntil:
			return .textDocumentWillSaveWaitUntil
		case .completion:
			return .textDocumentCompletion
		case .completionItemResolve:
			return .completionItemResolve
		case .hover:
			return .textDocumentHover
		case .signatureHelp:
			return .textDocumentSignatureHelp
		case .declaration:
			return .textDocumentDeclaration
		case .definition:
			return .textDocumentDefinition
		case .typeDefinition:
			return .textDocumentTypeDefinition
		case .implementation:
			return .textDocumentImplementation
		case .documentHighlight:
			return .textDocumentDocumentHighlight
		case .documentSymbol:
			return .textDocumentDocumentSymbol
		case .codeAction:
			return .textDocumentCodeAction
		case .codeActionResolve:
			return .codeActionResolve
		case .codeLens:
			return .textDocumentCodeLens
		case .codeLensResolve:
			return .codeLensResolve
		case .selectionRange:
			return .textDocumentSelectionRange
		case .linkedEditingRange:
			return .textDocumentLinkedEditingRange
		case .prepareCallHierarchy:
			return .textDocumentPrepareCallHierarchy
		case .prepareRename:
			return .textDocumentPrepareRename
		case .prepareTypeHierarchy:
			return .textDocumentPrepareTypeHierarchy
		case .rename:
			return .textDocumentRename
		case .inlayHint:
			return .textDocumentInlayHint
		case .inlayHintResolve:
			return .inlayHintResolve
		case .documentLink:
			return .textDocumentDocumentLink
		case .documentLinkResolve:
			return .documentLinkResolve
		case .documentColor:
			return .textDocumentDocumentColor
		case .diagnostics:
			return .textDocumentDiagnostic
		case .colorPresentation:
			return .textDocumentColorPresentation
		case .formatting:
			return .textDocumentFormatting
		case .rangeFormatting:
			return .textDocumentRangeFormatting
		case .onTypeFormatting:
			return .textDocumentOnTypeFormatting
		case .references:
			return .textDocumentReferences
		case .foldingRange:
			return .textDocumentFoldingRange
		case .moniker:
			return .textDocumentMoniker
		case .semanticTokensFull:
			return .textDocumentSemanticTokensFull
		case .semanticTokensFullDelta:
			return .textDocumentSemanticTokensFullDelta
		case .semanticTokensRange:
			return .textDocumentSemanticTokensRange
		case .callHierarchyIncomingCalls:
			return .callHierarchyIncomingCalls
		case .callHierarchyOutgoingCalls:
			return .callHierarchyOutgoingCalls
		case .typeHierarchySubtypes:
			return .typeHierarchySubtypes
		case .typeHierarchySupertypes:
			return .typeHierarchySupertypes
		case .custom:
			return .custom
		}
	}
}

extension ClientRequest: Equatable {
	/// Returns whether two requests are equal, comparing only their parameters and ignoring handlers.
	public static func == (lhs: ClientRequest, rhs: ClientRequest) -> Bool {
		// This really stinks. But, the handler parameter was a big win for server-side development, and
		// this is a one-time cost. Still, error-prone. Please take care when adding/modifying.

		switch (lhs, rhs) {
		case let (
			.callHierarchyIncomingCalls(lhsParam, _), .callHierarchyIncomingCalls(rhsParam, _)
		):
			return lhsParam == rhsParam
		case let (
			.callHierarchyOutgoingCalls(lhsParam, _), .callHierarchyOutgoingCalls(rhsParam, _)
		):
			return lhsParam == rhsParam
		case let (.codeAction(lhsParam, _), .codeAction(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.codeActionResolve(lhsParam, _), .codeActionResolve(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.codeLens(lhsParam, _), .codeLens(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.codeLensResolve(lhsParam, _), .codeLensResolve(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.colorPresentation(lhsParam, _), .colorPresentation(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.completion(lhsParam, _), .completion(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.completionItemResolve(lhsParam, _), .completionItemResolve(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.custom(lhsMethod, lhsParam, _), .custom(rhsMethod, rhsParam, _)):
			return lhsMethod == rhsMethod && lhsParam == rhsParam
		case let (.declaration(lhsParam, _), .declaration(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.definition(lhsParam, _), .definition(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.diagnostics(lhsParam, _), .diagnostics(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.documentColor(lhsParam, _), .documentColor(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.documentHighlight(lhsParam, _), .documentHighlight(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.documentLink(lhsParam, _), .documentLink(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.documentLinkResolve(lhsParam, _), .documentLinkResolve(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.documentSymbol(lhsParam, _), .documentSymbol(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.foldingRange(lhsParam, _), .foldingRange(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.formatting(lhsParam, _), .formatting(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.hover(lhsParam, _), .hover(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.implementation(lhsParam, _), .implementation(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.initialize(lhsParam, _), .initialize(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.inlayHint(lhsParam, _), .inlayHint(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.inlayHintResolve(lhsParam, _), .inlayHintResolve(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.linkedEditingRange(lhsParam, _), .linkedEditingRange(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.moniker(lhsParam, _), .moniker(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.onTypeFormatting(lhsParam, _), .onTypeFormatting(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.prepareCallHierarchy(lhsParam, _), .prepareCallHierarchy(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.prepareRename(lhsParam, _), .prepareRename(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.prepareTypeHierarchy(lhsParam, _), .prepareTypeHierarchy(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.rangeFormatting(lhsParam, _), .rangeFormatting(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.references(lhsParam, _), .references(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.rename(lhsParam, _), .rename(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.selectionRange(lhsParam, _), .selectionRange(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.semanticTokensFull(lhsParam, _), .semanticTokensFull(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.semanticTokensFullDelta(lhsParam, _), .semanticTokensFullDelta(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.semanticTokensRange(lhsParam, _), .semanticTokensRange(rhsParam, _)):
			return lhsParam == rhsParam
		case (.shutdown, .shutdown):
			return true
		case let (.signatureHelp(lhsParam, _), .signatureHelp(rhsParam, _)):
			return lhsParam == rhsParam
		case let (
			.textDocumentWillSaveWaitUntil(lhsParam, _), .textDocumentWillSaveWaitUntil(rhsParam, _)
		):
			return lhsParam == rhsParam
		case let (.typeDefinition(lhsParam, _), .typeDefinition(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.workspaceExecuteCommand(lhsParam, _), .workspaceExecuteCommand(rhsParam, _)):
			return lhsParam == rhsParam
		case (.workspaceInlayHintRefresh, .workspaceInlayHintRefresh):
			return true
		case let (.workspaceSymbol(lhsParam, _), .workspaceSymbol(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.workspaceSymbolResolve(lhsParam, _), .workspaceSymbolResolve(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.workspaceWillCreateFiles(lhsParam, _), .workspaceWillCreateFiles(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.workspaceWillDeleteFiles(lhsParam, _), .workspaceWillDeleteFiles(rhsParam, _)):
			return lhsParam == rhsParam
		case let (.workspaceWillRenameFiles(lhsParam, _), .workspaceWillRenameFiles(rhsParam, _)):
			return lhsParam == rhsParam
		default:
			return false
		}
	}
}

/// A notification sent from the server to the client.
public enum ServerNotification: Sendable, Hashable {
	/// The LSP method string for each server notification.
	public enum Method: String, Hashable, Sendable {
		case windowLogMessage = "window/logMessage"
		case windowShowMessage = "window/showMessage"
		case textDocumentPublishDiagnostics = "textDocument/publishDiagnostics"
		case telemetryEvent = "telemetry/event"
		case protocolCancelRequest = "$/cancelRequest"
		case protocolProgress = "$/progress"
		case protocolLogTrace = "$/logTrace"
	}

	case windowLogMessage(LogMessageParams)
	case windowShowMessage(ShowMessageParams)
	case textDocumentPublishDiagnostics(PublishDiagnosticsParams)
	case telemetryEvent(LSPAny)
	case protocolCancelRequest(CancelParams)
	case protocolProgress(ProgressParams)
	case protocolLogTrace(LogTraceParams)

	/// The method string corresponding to this notification.
	public var method: Method {
		switch self {
		case .windowLogMessage:
			return .windowLogMessage
		case .windowShowMessage:
			return .windowShowMessage
		case .textDocumentPublishDiagnostics:
			return .textDocumentPublishDiagnostics
		case .telemetryEvent:
			return .telemetryEvent
		case .protocolCancelRequest:
			return .protocolCancelRequest
		case .protocolProgress:
			return .protocolProgress
		case .protocolLogTrace:
			return .protocolLogTrace
		}
	}
}

/// A request sent from the server to the client.
public enum ServerRequest: Sendable {
	/// A closure that handles a typed response.
	public typealias Handler<T: Sendable & Encodable> = @Sendable (
		Result<T, AnyJSONRPCResponseError>
	) async -> Void
	/// A closure that handles a void response.
	public typealias VoidHandler = @Sendable () async -> Void
	/// A closure that handles an error-only response.
	public typealias ErrorOnlyHandler = @Sendable (AnyJSONRPCResponseError?) async -> Void

	/// The LSP method string for each server request.
	public enum Method: String {
		case workspaceConfiguration = "workspace/configuration"
		case workspaceFolders = "workspace/workspaceFolders"
		case workspaceApplyEdit = "workspace/applyEdit"
		case clientRegisterCapability = "client/registerCapability"
		case clientUnregisterCapability = "client/unregisterCapability"
		case workspaceCodeLensRefresh = "workspace/codeLens/refresh"
		case workspaceSemanticTokenRefresh = "workspace/semanticTokens/refresh"
		case windowShowMessageRequest = "window/showMessageRequest"
		case windowShowDocument = "window/showDocument"
		case windowWorkDoneProgressCreate = "window/workDoneProgress/create"
		case custom
	}

	case workspaceConfiguration(ConfigurationParams, Handler<[LSPAny]>)
	case workspaceFolders(Handler<WorkspaceFoldersResponse>)
	case workspaceApplyEdit(ApplyWorkspaceEditParams, Handler<ApplyWorkspaceEditResult>)
	case clientRegisterCapability(RegistrationParams, ErrorOnlyHandler)
	case clientUnregisterCapability(UnregistrationParams, ErrorOnlyHandler)
	case workspaceCodeLensRefresh(ErrorOnlyHandler)
	case workspaceSemanticTokenRefresh(ErrorOnlyHandler)
	case windowShowMessageRequest(ShowMessageRequestParams, Handler<ShowMessageRequestResponse>)
	case windowShowDocument(ShowDocumentParams, Handler<ShowDocumentResult>)
	case windowWorkDoneProgressCreate(WorkDoneProgressCreateParams, ErrorOnlyHandler)
	case custom(String, LSPAny, Handler<LSPAny>)

	/// The method string corresponding to this request.
	public var method: Method {
		switch self {
		case .workspaceConfiguration:
			return .workspaceConfiguration
		case .workspaceFolders:
			return .workspaceFolders
		case .workspaceApplyEdit:
			return .workspaceApplyEdit
		case .clientRegisterCapability:
			return .clientRegisterCapability
		case .clientUnregisterCapability:
			return .clientUnregisterCapability
		case .workspaceCodeLensRefresh:
			return .workspaceCodeLensRefresh
		case .workspaceSemanticTokenRefresh:
			return .workspaceSemanticTokenRefresh
		case .windowShowMessageRequest:
			return .windowShowMessageRequest
		case .windowShowDocument:
			return .windowShowDocument
		case .windowWorkDoneProgressCreate:
			return .windowWorkDoneProgressCreate
		case .custom:
			return .custom
		}
	}

	/// Responds to this request with a generic internal error.
	public func relyWithError(_ error: Error) async {
		let protocolError = AnyJSONRPCResponseError(
			code: JSONRPCErrors.internalError, message: "unsupported", data: nil)

		switch self {
		case let .workspaceConfiguration(_, handler):
			await handler(.failure(protocolError))
		case let .workspaceFolders(handler):
			await handler(.failure(protocolError))
		case let .workspaceApplyEdit(_, handler):
			await handler(.failure(protocolError))
		case let .clientRegisterCapability(_, handler):
			await handler(protocolError)
		case let .clientUnregisterCapability(_, handler):
			await handler(protocolError)
		case let .workspaceCodeLensRefresh(handler):
			await handler(protocolError)
		case let .workspaceSemanticTokenRefresh(handler):
			await handler(protocolError)
		case let .windowShowMessageRequest(_, handler):
			await handler(.failure(protocolError))
		case let .windowShowDocument(_, handler):
			await handler(.failure(protocolError))
		case let .windowWorkDoneProgressCreate(_, handler):
			await handler(protocolError)
		case let .custom(_, _, handler):
			await handler(.failure(protocolError))
		}
	}
}

/// A dynamic registration sent by the server to the client.
public enum ServerRegistration {
	/// The LSP method string for each registerable capability.
	public enum Method: String {
		case workspaceDidChangeWatchedFiles = "workspace/didChangeWatchedFiles"
		case workspaceDidChangeConfiguration = "workspace/didChangeConfiguration"
		case workspaceDidChangeWorkspaceFolders = "workspace/didChangeWorkspaceFolders"

		case textDocumentSemanticTokens = "textDocument/semanticTokens"
	}

	case workspaceDidChangeWatchedFiles(DidChangeWatchedFilesRegistrationOptions)
	case textDocumentSemanticTokens(SemanticTokensRegistrationOptions)
	case workspaceDidChangeConfiguration
	case workspaceDidChangeWorkspaceFolders

	/// The method string corresponding to this registration.
	public var method: Method {
		switch self {
		case .workspaceDidChangeWatchedFiles:
			return .workspaceDidChangeWatchedFiles
		case .textDocumentSemanticTokens:
			return .textDocumentSemanticTokens
		case .workspaceDidChangeConfiguration:
			return .workspaceDidChangeConfiguration
		case .workspaceDidChangeWorkspaceFolders:
			return .workspaceDidChangeWorkspaceFolders
		}
	}
}
