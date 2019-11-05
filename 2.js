const fs = require('fs');
const wabt = require('wabt')();

async function main() {
  const src = '2.wat';
  const wasm = wabt.parseWat(src, fs.readFileSync(src, 'utf8'));
  const {buffer} = wasm.toBinary({});
  const {instance} = await WebAssembly.instantiate(buffer, {
    env: { log_i32: console.log } // <<<<<
  });
  const {exports: e} = instance;

  console.log('f21_log', e.f21_log(5));
}

main().catch(e => {
  console.error(e);
  process.exit(1);
});
