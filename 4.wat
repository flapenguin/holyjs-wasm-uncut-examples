(module
  (import "env" "log" (func $log (param i32) (param i32)))

  (table $table 128 funcref)
  (type $signature (func (param i32)))

  (export "table" (table $table))
  (export "f41_call_indirect" (func $f41_call_indirect))
  (export "f42_log_1234"      (func $f42_log_1234))
  (export "f42_log_5678"      (func $f42_log_5678))

  (func $f41_call_indirect (param $fn_index i32) (param $arg i32)
    (call_indirect (type $signature)
      (local.get $arg)
      (local.get $fn_index)
    )
  )

  (func $f42_log_1234 (param $arg i32)
    (call $log (i32.const 1234) (local.get $arg))
  )

  (func $f42_log_5678 (param $arg i32)
    (call $log (i32.const 5678) (local.get $arg))
  )
)
