//===-- Exhaustive test for log10f ----------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "exhaustive_test.h"
#include "src/__support/FPUtil/FPBits.h"
#include "src/math/log10f.h"
#include "test/UnitTest/FPMatcher.h"
#include "utils/MPFRWrapper/MPFRUtils.h"

using FPBits = __llvm_libc::fputil::FPBits<float>;

namespace mpfr = __llvm_libc::testing::mpfr;

struct LlvmLibcLog10fExhaustiveTest : public LlvmLibcExhaustiveTest<uint32_t> {
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
      result &= TEST_MPFR_MATCH(mpfr::Operation::Log10, x,
                                __llvm_libc::log10f(x), 0.5, rounding);
    } while (bits++ < stop);
    return result;
  }
};

// Range: All non-negative;
static constexpr uint32_t START = 0x0000'0000U;
static constexpr uint32_t STOP = 0x7f80'0000U;
// Range: [1, 10];
// static constexpr uint32_t START = 0x3f80'0000U;
// static constexpr uint32_t STOP  = 0x41c0'0000U;
TEST_F(LlvmLibcLog10fExhaustiveTest, RoundNearestTieToEven) {
  test_full_range(START, STOP, mpfr::RoundingMode::Nearest);
}

TEST_F(LlvmLibcLog10fExhaustiveTest, RoundUp) {
  test_full_range(START, STOP, mpfr::RoundingMode::Upward);
}

TEST_F(LlvmLibcLog10fExhaustiveTest, RoundDown) {
  test_full_range(START, STOP, mpfr::RoundingMode::Downward);
}

TEST_F(LlvmLibcLog10fExhaustiveTest, RoundTowardZero) {
  test_full_range(START, STOP, mpfr::RoundingMode::TowardZero);
}
