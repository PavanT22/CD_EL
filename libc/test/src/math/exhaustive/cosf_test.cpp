//===-- Exhaustive test for cosf ------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "exhaustive_test.h"
#include "src/__support/FPUtil/FPBits.h"
#include "src/math/cosf.h"
#include "test/UnitTest/FPMatcher.h"
#include "utils/MPFRWrapper/MPFRUtils.h"

#include <thread>

using FPBits = __llvm_libc::fputil::FPBits<float>;

namespace mpfr = __llvm_libc::testing::mpfr;

struct LlvmLibcCosfExhaustiveTest : public LlvmLibcExhaustiveTest<uint32_t> {
  bool check(uint32_t start, uint32_t stop,
             mpfr::RoundingMode rounding) override {
    mpfr::ForceRoundingMode r(rounding);
    if (!r.success)
      return true;
    uint32_t bits = start;
    bool result = true;
    do {
      FPBits xbits(bits);
      float x = float(xbits);
      bool r = TEST_MPFR_MATCH(mpfr::Operation::Cos, x, __llvm_libc::cosf(x),
                               0.5, rounding);
      result &= r;
    } while (++bits < stop);
    return result;
  }
};

// Range: [0, +Inf);
static constexpr uint32_t POS_START = 0x0000'0000U;
static constexpr uint32_t POS_STOP = 0x7f80'0000U;

TEST_F(LlvmLibcCosfExhaustiveTest, PostiveRangeRoundNearestTieToEven) {
  test_full_range(POS_START, POS_STOP, mpfr::RoundingMode::Nearest);
}

TEST_F(LlvmLibcCosfExhaustiveTest, PostiveRangeRoundUp) {
  test_full_range(POS_START, POS_STOP, mpfr::RoundingMode::Upward);
}

TEST_F(LlvmLibcCosfExhaustiveTest, PostiveRangeRoundDown) {
  test_full_range(POS_START, POS_STOP, mpfr::RoundingMode::Downward);
}

TEST_F(LlvmLibcCosfExhaustiveTest, PostiveRangeRoundTowardZero) {
  test_full_range(POS_START, POS_STOP, mpfr::RoundingMode::TowardZero);
}

// Range: (-Inf, 0];
static constexpr uint32_t NEG_START = 0x8000'0000U;
static constexpr uint32_t NEG_STOP = 0xff80'0000U;

TEST_F(LlvmLibcCosfExhaustiveTest, NegativeRangeRoundNearestTieToEven) {
  test_full_range(NEG_START, NEG_STOP, mpfr::RoundingMode::Nearest);
}

TEST_F(LlvmLibcCosfExhaustiveTest, NegativeRangeRoundUp) {
  test_full_range(NEG_START, NEG_STOP, mpfr::RoundingMode::Upward);
}

TEST_F(LlvmLibcCosfExhaustiveTest, NegativeRangeRoundDown) {
  test_full_range(NEG_START, NEG_STOP, mpfr::RoundingMode::Downward);
}

TEST_F(LlvmLibcCosfExhaustiveTest, NegativeRangeRoundTowardZero) {
  test_full_range(NEG_START, NEG_STOP, mpfr::RoundingMode::TowardZero);
}
