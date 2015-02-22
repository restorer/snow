package snow.utils.promhx.error;

enum PromiseError {
    AlreadyResolved(message: String);
    DownstreamNotFullfilled(message: String);
}
