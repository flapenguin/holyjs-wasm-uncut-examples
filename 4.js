const fs = require('fs');
const wabt = require('wabt')();

async function main() {
  const src = '4.wat';
  const wasm = wabt.parseWat(src, fs.readFileSync(src, 'utf8'));
  const {buffer} = wasm.toBinary({});
  const {instance} = await WebAssembly.instantiate(buffer, {
    env: {log: console.log}
  });
  const {exports: e} = instance;

  e.table.set(0, e.f42_log_1234);
  //             ^^^^^^^^^^^^^^ must be wasm function

  e.f41_call_indirect(0, 42);
}

main().catch(e => {
  console.error(e);
  process.exit(1);
});
