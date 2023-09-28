const std = @import("std");

// sieve of sundaram
pub fn findPrimes(allocator: std.mem.Allocator, n: u64) ![]u64 {
    var primes = std.ArrayList(u64).init(allocator);
    var sieve = std.ArrayList(bool).init(allocator);
    defer sieve.deinit();
    try sieve.resize(@divTrunc(n, 2));
    var i: u64 = 1;
    while (i < n / 2) : (i += 1) {
        var j: u64 = 1;
        while (j <= i and i + j + 2 * i * j < n / 2) : (j += 1) {
            sieve.items[i + j + 2 * i * j] = true;
        }
    }
    try primes.append(2);
    i = 1;
    while (i < n / 2) : (i += 1) {
        if (!sieve.items[i]) {
            try primes.append(2 * i + 1);
        }
    }
    var ret = try primes.toOwnedSlice();
    return ret;
}

pub fn anotherOne(allocator: std.mem.Allocator, n: u64) !bool {
    if (n < 3) {
        if (n < 2) {
            return false;
        } else {
            return true;
        }
    }
    var k: u64 = @divTrunc((n - 3), 2) + 1;
    var int_list = try allocator.alloc(bool, k);
    defer allocator.free(int_list);
    var i: u64 = 0;
    while (i < k) : (i += 1) int_list[i] = true;

    var ops: u64 = 0;
    i = 0;
    while (i < @as(u64, @intFromFloat(@divFloor((@floor(@sqrt(@as(f64, @floatFromInt(n)))) - 3), 2) + 1))) : (i += 1) {
        if (int_list[i]) {
            var s = 2 * i + 3;
            var j = (s * s - 3) / 2;
            while (j < k) : (j += s) {
                int_list[j] = false;
                ops += 1;
            }
        }
    }
    std.debug.print("Total operations: {any}\n", .{ops});

    var count: u64 = 0;
    i = 0;
    while (i < k) : (i += 1) {
        if (int_list[i]) {
            count += 1;
        }
    }
    std.debug.print("Total primes: {any}\n", .{count});
    return true;
}

pub fn soe(allocator: std.mem.Allocator, n: u64) ![]u64 {
    if (n < 3) return undefined;
    var k: u64 = @divTrunc((n - 3), 2) + 1;
    var marked = try allocator.alloc(bool, k);
    defer allocator.free(marked);

    var primes = try allocator.alloc(u64, k);

    var limit = @as(u64, @intFromFloat(@divFloor((@floor(@sqrt(@as(f64, @floatFromInt(n)))) - 3), 2) + 1));
    var i: u64 = 0;
    while (i < k) : (i += 1) marked[i] = true;
    i = 0;

    while (i < limit) : (i += 1) {
        if (marked[i]) {
            var s = (2 * i) + 3;
            var j = (s * s - 3) / 2;
            while (j < k) : (j += s) {
                marked[j] = false;
            }
        }
    }
    i = 0;
    while (i < k) : (i += 1) {
        if (marked[i]) {
            primes[i] = (2 * i) + 3;
        }
    }
    return primes; //(primes, 0, k);
}

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    //var primes = try findPrimes(allocator, 189788857);
    //std.debug.print("done\n", .{});
    var primes = try soe(allocator, 15485867);
    defer allocator.free(primes);
    var i: u64 = 0;

    while (i < 100) : (i += 1) {
        std.debug.print("{d}\n", .{primes[i]});
    }

    std.debug.print("done, first val: {d}\n", .{primes[0]});
}
