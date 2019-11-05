const fs = require('fs');
const wabt = require('wabt')();

async function main() {
  const src = '0.wat';
  const wasm = wabt.parseWat(src, fs.readFileSync(src, 'utf8'));
  const {buffer} = wasm.toBinary({});
  const {instance} = await WebAssembly.instantiate(buffer);
  const {exports: e} = instance;

  console.log('f01_const', e.f01_const());
  // console.log('f02_params', e.f02_params(1, 2));
  // console.log('f03_params_named', e.f03_params_named(1, 2));
  // console.log('f04_folded', e.f04_folded(1, 2));
  // console.log('f05_nested', e.f05_nested(1, 2));
  // console.log('f06_locals', e.f06_locals(1, 2));
}

main().catch(e => {
  console.error(e);
  process.exit(1);
});
