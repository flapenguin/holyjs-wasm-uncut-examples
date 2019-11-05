(module
  (export "f11_branching"           (func $f11_branching))
  (export "f12_branching_pure"      (func $f12_branching_pure))
  (export "f13_fibonacci_loop"      (func $f13_fibonacci_loop))
  (export "f14_fibonacci_recursive" (func $f14_fibonacci_recursive))

  (func $f11_branching (param $cond i32) (result i32)
    (local $x i32)

    ;; https://webassembly.github.io/spec/core/text/instructions.html#folded-instructions
    (if (i32.gt_s (local.get $cond) (i32.const 50))
      (then
        (local.set $x (i32.const 1))
      )

      (else
        (local.set $x (i32.const 0))
      )
    )

    local.get $x
  )

  (func $f12_branching_pure (param $cond i32) (result i32)
    (local $x i32)
    (i32.gt_s (local.get $cond) (i32.const 50))
    if
    (local.set $x (i32.const 1))
    else
    (local.set $x (i32.const 0))
    end
    local.get $x
  )

  (func $f13_fibonacci_loop (param $n i32) (result i32)
    (local $prev i32)
    (local $curr i32)
    (if (i32.eqz (local.get $n))
      (return (i32.const 0))
    )

    (local.set $n
      (i32.sub (local.get $n) (i32.const 1))
    )

    (local.set $prev (i32.const 0))
    (local.set $curr (i32.const 1))

    ;; block
    ;; while (false) { CODE ... CODE; }
    ;;
    ;; loop
    ;; while (true) { CODE ... CODE; break; }

    ;; https://webassembly.github.io/spec/core/exec/instructions.html#exec-block
    (block (loop
    ;; 1    0
      (br_if 1 (i32.eqz (local.get $n)))

      local.get $curr

      (local.set $curr
        (i32.add (local.get $prev) (local.get $curr))
      )

      local.set $prev

      (local.set $n
        (i32.sub (local.get $n) (i32.const 1))
      )

      (br 0)
    ))

    local.get $curr
  )

  (func $f14_fibonacci_recursive (param $n i32) (result i32)
    (if (i32.eq (local.get $n) (i32.const 0))
      (then
        (return (i32.const 0))
      )
    )

    (if (i32.eq (local.get $n) (i32.const 1))
      (then
        (return (i32.const 1))
      )
    )

    (i32.add
      (call $f14_fibonacci_recursive
        (i32.sub (local.get $n) (i32.const 2))
      )
      (call $f14_fibonacci_recursive
        (i32.sub (local.get $n) (i32.const 1))
      )
    )
  )
)
