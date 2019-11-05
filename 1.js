const fs = require('fs');
const wabt = require('wabt')();

async function main() {
  const src = '1.wat';
  const wasm = wabt.parseWat(src, fs.readFileSync(src, 'utf8'));
  const {buffer} = wasm.toBinary({});
  const {instance} = await WebAssembly.instantiate(buffer);
  const {exports: e} = instance;

  console.log('f11_branching', {
    25: e.f11_branching(25),
    100: e.f11_branching(100)
  });

  // console.log('f12_branching_pure', {
  //   25: e.f12_branching_pure(25),
  //   100: e.f12_branching_pure(100)
  // });

  // console.log('f13_fibonacci_loop',
  //   Array.from({length: 10}, (_, i) => e.f13_fibonacci_loop(i)));

  // console.log('f14_fibonacci_recursive',
  //   Array.from({length: 10}, (_, i) => e.f14_fibonacci_recursive(i)));
}

main().catch(e => {
  console.error(e);
  process.exit(1);
});
