(module
  (export "f01_const"        (func $f01_const))
  (export "f02_params"       (func $f02_params))
  (export "f03_params_named" (func $f03_params_named))
  (export "f04_folded"       (func $f04_folded))
  (export "f05_nested"       (func $f05_nested))
  (export "f06_locals"       (func $f06_locals))

  (func $f01_const (result i32)
    i32.const 42
  )

  (func $f02_params (param i32) (param i32) (result i32)
    ;;               ^^ 0        ^^ 1
    ;; https://webassembly.github.io/spec/core/exec/instructions.html#exec-local-get
    ;; f02_params(1, 2)
    local.get 0
    local.get 1

    ;; https://webassembly.github.io/spec/core/exec/instructions.html#exec-binop
    i32.add
  )

  (func $f03_params_named (param $lhs i32) (param $rhs i32) (result i32)
    local.get $lhs
    local.get $rhs
    i32.add
  )

  (func $f04_folded (param $lhs i32) (param $rhs i32) (result i32)
    ;; https://webassembly.github.io/spec/core/text/instructions.html#folded-instructions
    (i32.add
      (local.get $rhs)
      (local.get $lhs)
    )
  )

  (func $f05_nested (param $lhs i32) (param $rhs i32) (result i32)
    (i32.add
      (i32.add (local.get $rhs) (local.get $lhs))
      (i32.const 100)
    )
  )

  (func $f06_locals (param $lhs i32) (param $rhs i32) (result i32)
    ;;                     ^^^^ 0           ^^^^ 1
    (local $x i32)
    ;;     ^^ 2
    (local.set $x
      (i32.add
        (i32.add (local.get $rhs) (local.get $lhs))
        (i32.const 100)
      )
    )

    ;; do some other work

    local.get $x
  )
)
