(module
  (memory $memory 1) ;; 1 x 64 KiB
  (data (i32.const 0) "holyjs")
  ;;     ^^^^^^^^^^^ offset

  (export "memory" (memory $memory))
  (export "f31_ascii_capitalize" (func $f31_ascii_capitalize))


  (func $f31_ascii_capitalize (param $offset i32) (param $len i32)
    (local $char i32)
    (local $addr i32)
    (block (loop
      (br_if 1 (i32.eqz (local.get $len)))

      (local.set $len
        (i32.sub (local.get $len) (i32.const 1))
      )

      (local.set $addr (i32.add (local.get $offset) (local.get $len)))
      (local.set $char (i32.load8_u (local.get $addr)))

      (if
        (i32.and
          (i32.ge_u (local.get $char) (i32.const 0x61)) ;; >= 'a'
          (i32.le_u (local.get $char) (i32.const 0x7a)) ;; <= 'z'
        )
        (then
          (i32.store8 (local.get $addr)
            (i32.and (local.get $char) (i32.const 0xdf))
          )
        )
      )

      (br 0)
    ))
  )
)
