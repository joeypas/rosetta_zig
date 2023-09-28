const std = @import("std");
const zout = std.io.getStdOut().writer();
const zin = std.io.getStdIn().writer();

pub fn isPrime(n: u64) bool {
    if (@mod(n, 2) == 0) return n == 2;
    if (@mod(n, 3) == 0) return n == 3;
    var d: u64 = 5;
    while (d * d <= n) {
        if (@mod(n, d) == 0) return false;
        d += 2;
        if (@mod(n, d) == 0) return false;
        d += 4;
    }
    return true;
}
pub fn main() !void {
    var i: u64 = 42;
    var n: u64 = 0;
    while (n < 42) : (i += 1) {
        if (isPrime(i)) {
            n += 1;
            _ = try zout.print("n = {d}\t->\t{d}\n", .{ n, i });
            i += i - 1;
        }
    }
}
