const std = @import("std");
const zout = std.io.getStdOut().writer();
const zin = std.io.getStdIn().writer();

fn checkInt(comptime t: type) bool {
    if ((@typeName(t)[0] != 'i') and (@typeName(t)[0] != 'u')) {
        return false;
    }
    return true;
}

pub fn isPrime(comptime t: type,  n: t) bool {
    // Make sure we're dealing with an integer
    if (!checkInt(t)) @panic("isPrime: type must be an integer");

    // Make sure we're dealing with a positive integer
    if (@mod(n, 2) == 0) return n == 2;
    if (@mod(n, 3) == 0) return n == 3;

    // Check if n is divisible by any number between 5 and sqrt(n)
    var d: t = 5;
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
        if (isPrime(u64, i)) {
            n += 1;
            _ = try zout.print("n = {d}\t->\t{d}\n", .{ n, i });
            i += i - 1;
        }
    }
}
