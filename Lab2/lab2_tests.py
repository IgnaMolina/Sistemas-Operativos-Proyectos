"""
Tests compartidos Lab 2 — usados por grade-lab2-parcial y grade-lab2-final.
Misma batería para alumnos (make grade-*) y docentes (grading.py).
"""
import re
from gradelib import assert_equal, shell_script, test


def register_sem_tests(r):
    """Syscalls de semáforos vía semtest — 6 puntos."""

    @test(1, "semtest noinit")
    def _sem_noinit():
        r.run_qemu(shell_script(['semtest noinit']))
        r.match('error')

    @test(1, "semtest init value")
    def _sem_init():
        r.run_qemu(shell_script(['semtest init 3']))
        out = r.qemu.output
        assert_equal(
            bool(re.search(r'init\s*:?\s*3', out, re.I) or re.search(r'value\s*=?\s*3', out, re.I)),
            True,
            "init value 3 not found",
        )

    @test(1, "semtest closeuse")
    def _sem_closeuse():
        r.run_qemu(shell_script(['semtest closeuse']))
        r.match('.*closed', '.*error')

    @test(1, "semtest exhaust reuse")
    def _sem_exhaust():
        r.run_qemu(shell_script(['semtest exhaust']))
        out = r.qemu.output.lower()
        assert_equal('exhaust' in out or 'reuse' in out, True, "exhaust/reuse not found")

    @test(1, "semtest grow beyond initial")
    def _sem_grow():
        r.run_qemu(shell_script(['semtest grow']))
        r.match('grow ok')

    @test(1, "semtest double open rejected")
    def _sem_reopen():
        r.run_qemu(shell_script(['semtest reopen']))
        r.match('.*rechazado', '.*error')


def register_pingpong_tests(r):
    """Programa pingpong — 5 puntos."""

    @test(1, "pingpong no parameters")
    def _pp_empty():
        r.run_qemu(shell_script(['pingpong']))
        r.match('ERROR')

    @test(1, "pingpong wrong parameters")
    def _pp_bad():
        r.run_qemu(shell_script(['pingpong -1']))
        r.match('ERROR')

    @test(1, "pingpong three rounds")
    def _pp_3():
        r.run_qemu(shell_script(['pingpong 3']))
        no_ping = len(re.findall(r'\bping\b', r.qemu.output, flags=re.I))
        no_pong = len(re.findall(r'\bpong\b', r.qemu.output, flags=re.I))
        assert_equal(no_ping, 3)
        assert_equal(no_pong, 3)

    @test(1, "pingpong order and termination")
    def _pp_order():
        r.run_qemu(shell_script(['pingpong 10; echo DONE']))
        no_pairs = len(re.findall(r'ping[^\n]*\n[^\n]*pong', r.qemu.output, flags=re.M | re.I))
        assert_equal(no_pairs, 10, "pingpong order issues")
        match = re.search(r'\nDONE\n\$ qemu-system-riscv64', r.qemu.output, flags=re.M)
        assert_equal(match is not None, True, "pingpong exited before DONE")

    @test(1, "pingpong concurrency")
    def _pp_conc():
        r.run_qemu(shell_script([
            'pingpong 10 & ; pingpong 10 & ; pingpong 20 ; echo DONE'
        ]))
        match = re.search(r'echo DONE\n([^D]+)DONE\n', r.qemu.output, flags=re.M)
        assert_equal(match is not None, True, "Malformed output")
        sub = match.group(1)
        assert_equal(len(re.findall(r'i', sub)), 40, "Number of i not expected")
        assert_equal(len(re.findall(r'o', sub)), 40, "Number of o not expected")


def _count_produce_consume(output):
    n_prod = len(re.findall(r'\bproduce\b', output, flags=re.I))
    n_cons = len(re.findall(r'\bconsume\b', output, flags=re.I))
    return n_prod, n_cons


def _max_inflight(output):
    inflight = 0
    max_inf = 0
    for line in output.splitlines():
        if re.search(r'\bproduce\b', line, re.I):
            inflight += 1
            max_inf = max(max_inf, inflight)
        elif re.search(r'\bconsume\b', line, re.I):
            inflight -= 1
    return max_inf, inflight


def register_prodcons_tests(r):
    """Programa prodcons — 4 puntos.

    Cuenta líneas produce/consume; no valida el pid impreso (informativo según enunciado).
    """

    @test(1, "prodcons no parameters")
    def _pc_empty():
        r.run_qemu(shell_script(['prodcons']))
        r.match('ERROR')

    @test(1, "prodcons wrong parameters")
    def _pc_bad():
        r.run_qemu(shell_script(['prodcons 0 5']))
        r.match('ERROR')

    @test(1, "prodcons B=1 alternating")
    def _pc_b1():
        r.run_qemu(shell_script(['prodcons 1 5; echo DONE']))
        n_prod, n_cons = _count_produce_consume(r.qemu.output)
        assert_equal(n_prod, 5)
        assert_equal(n_cons, 5)
        max_inf, final = _max_inflight(r.qemu.output)
        assert_equal(max_inf <= 1, True, "B=1 violated")
        assert_equal(final, 0, "unmatched at end")
        match = re.search(r'\nDONE\n\$ qemu-system-riscv64', r.qemu.output, flags=re.M)
        assert_equal(match is not None, True, "prodcons exited before DONE")

    @test(1, "prodcons B=3 capacity")
    def _pc_b3():
        r.run_qemu(shell_script(['prodcons 3 10; echo DONE']))
        n_prod, n_cons = _count_produce_consume(r.qemu.output)
        assert_equal(n_prod, 10)
        assert_equal(n_cons, 10)
        max_inf, final = _max_inflight(r.qemu.output)
        assert_equal(max_inf <= 3, True, "B=3 violated")
        assert_equal(final, 0, "unmatched at end")
        match = re.search(r'\nDONE\n\$ qemu-system-riscv64', r.qemu.output, flags=re.M)
        assert_equal(match is not None, True, "prodcons exited before DONE")


def register_star_test(r):
    """Punto estrella — 0 puntos (@CREDIT)."""

    @test(0, "@CREDIT prodcons star P/C parallel")
    def _pc_star():
        r.run_qemu(shell_script(['prodcons 2 20 2 2; echo DONE']))
        n_prod, n_cons = _count_produce_consume(r.qemu.output)
        assert_equal(n_prod, 20)
        assert_equal(n_cons, 20)
        max_inf, final = _max_inflight(r.qemu.output)
        assert_equal(max_inf <= 2, True, "star B=2 violated")
        assert_equal(final, 0, "star unmatched at end")
