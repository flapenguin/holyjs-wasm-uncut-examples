(module
  (import "env" "log_i32" (func $log_i32 (param i32)))
  (export "f21_log" (func $f21_log))

  (func $f21_log (param $n i32)
    (local $i i32)
    (local.set $i (i32.const 0))

    (block (loop
      (br_if 1 (i32.eq (local.get $i) (local.get $n)))

      (call $log_i32 (local.get $i))

      (local.set $i
        (i32.add (local.get $i) (i32.const 1))
      )

      (br 0)
    ))
  )
)
