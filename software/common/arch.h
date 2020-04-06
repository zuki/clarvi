/// Syntacore SCR* infra
///
/// @copyright (C) Syntacore 2015-2017. All rights reserved.
/// @author mn-sc
///
/// @brief Architecture specific defs and inlines

#ifndef INFRA_ARCH_H
#define INFRA_ARCH_H

#include <stdint.h>
#include <stdbool.h>
#include "csr.h"

static inline uint32_t __attribute__((const)) arch_isa(void)
{
  uint32_t res;
  asm ("csrr %0, misa" : "=r"(res));
  return res;
}

static inline uint32_t __attribute__((const)) arch_impid(void)
{
  uint32_t res;
  asm ("csrr %0, mimpid" : "=r"(res));
  return res;
}

static inline uint32_t __attribute__((const)) arch_hartid(void)
{
  uint32_t res;
  asm ("csrr %0, mhartid" : "=r"(res));
  return res;
}

static inline uint32_t __attribute__((const)) arch_badaddr(void)
{
  uint32_t res;
  asm ("csrr %0, 0x343" : "=r"(res));
  return res;
}

// arch specific CSRs

static inline uint32_t __attribute__((const)) get_system_id(void)
{
    return 0;
}

static inline uint32_t __attribute__((const)) get_build_id(void)
{
    return 0;
}

static inline void ifence(void)
{
    asm volatile ("fence.i" ::: "memory");
}

static inline void fence(void)
{
    asm volatile ("fence" ::: "memory");
}

static inline void wfi(void)
{
    asm volatile ("wfi" ::: "memory");
}

void __attribute__((noreturn)) _hart_halt(void);

#endif // INFRA_ARCH_H
