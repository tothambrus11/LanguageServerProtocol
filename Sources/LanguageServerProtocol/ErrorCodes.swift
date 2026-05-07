/// Error codes defined by JSON-RPC and the Language Server Protocol.
public enum ErrorCodes {
	/// Invalid JSON was received by the server.
	public static let ParseError = -32700
	/// The JSON sent is not a valid request object.
	public static let InvalidRequest = -32600
	/// The method does not exist or is not available.
	public static let MethodNotFound = -32601
	/// Invalid method parameters.
	public static let InvalidParams = -32602
	/// Internal JSON-RPC error.
	public static let InternalError = -32603

	/// The start range of JSON-RPC reserved error codes.
	///
	/// It doesn't denote a real error code. No LSP error codes should
	/// be defined between the start and end range. For backwards
	/// compatibility the `ServerNotInitialized` and the `UnknownErrorCode`
	/// are left in the range.
	///
	/// - Since: 3.16.0
	public static let jsonrpcReservedErrorRangeStart = -32099
	/// - Note: Deprecated, use `jsonrpcReservedErrorRangeStart`.
	public static let serverErrorStart = jsonrpcReservedErrorRangeStart

	/// The server received a notification or request before the `initialize` request.
	public static let ServerNotInitialized = -32002
	/// An unknown error code.
	public static let UnknownErrorCode = -32001

	/// The end range of JSON-RPC reserved error codes.
	///
	/// It doesn't denote a real error code.
	///
	/// - Since: 3.16.0
	public static let jsonrpcReservedErrorRangeEnd = -32000
	/// - Note: Deprecated, use `jsonrpcReservedErrorRangeEnd`.
	public static let serverErrorEnd = jsonrpcReservedErrorRangeEnd

	/// The start range of LSP reserved error codes.
	///
	/// It doesn't denote a real error code.
	///
	/// - Since: 3.16.0
	public static let lspReservedErrorRangeStart = -32899

	/// A request failed but it was syntactically correct, e.g. the
	/// method name was known and the parameters were valid. The error
	/// message should contain human-readable information about why
	/// the request failed.
	///
	/// - Since: 3.17.0
	public static let RequestFailed = -32803

	/// The server cancelled the request.
	///
	/// This error code should only be used for requests that explicitly support
	/// being server cancellable.
	///
	/// - Since: 3.17.0
	public static let ServerCancelled = -32802

	/// The server detected that the content of a document got
	/// modified outside normal conditions.
	///
	/// A server should NOT send this error code if it detects a content change
	/// in its unprocessed messages. The result even computed on an older state
	/// might still be useful for the client.
	public static let ContentModified = -32801

	/// The client has canceled a request and the server has detected the cancel.
	public static let RequestCancelled = -32800

	/// The end range of LSP reserved error codes.
	///
	/// It doesn't denote a real error code.
	///
	/// - Since: 3.16.0
	public static let lspReservedErrorRangeEnd = -32800
}
