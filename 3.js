const fs = require('fs');
const wabt = require('wabt')();

async function main() {
  const src = '3.wat';
  const wasm = wabt.parseWat(src, fs.readFileSync(src, 'utf8'));
  const {buffer} = wasm.toBinary({});
  const {instance} = await WebAssembly.instantiate(buffer);
  const {exports: e} = instance;

  console.log(e.memory.buffer);
  console.log('f31_ascii_capitalize', e.f31_ascii_capitalize(0, 6));
  console.log(e.memory.buffer);

  // console.log(new TextDecoder().decode(new Uint8Array(e.memory.buffer, 0, 6)));

  // const str = 'hi there!';
  // const len = str.length;
  // new TextEncoder().encodeInto(str, new Uint8Array(e.memory.buffer, 0, len));
  // e.f31_ascii_capitalize(0, len);
  // console.log(new TextDecoder().decode(new Uint8Array(e.memory.buffer, 0, len)));
}

main().catch(e => {
  console.error(e);
  process.exit(1);
});
