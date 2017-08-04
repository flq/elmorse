
let oscillator = null;
let audioCtx = null;

try {
  audioCtx = new (window.AudioContext || window.webkitAudioContext)();
  oscillator = audioCtx.createOscillator();
  oscillator.type = "sine";
  oscillator.frequency.value = 880; // value in hertz
  oscillator.start();
} catch (x) {
  console.warn("Oscillator not available in your env");
  // null implementations for test environment.
  audioCtx = {
    destination: {}
  };
  oscillator = {
    connect: () => {},
    disconnect: () => {}
  };
}

export function initAudioPort(elmApp) {
  let isConnected = false;
  elmApp.ports.audioOn.subscribe(function() {
    if (isConnected) return;
    oscillator.connect(audioCtx.destination);
    isConnected = true;
  });
  elmApp.ports.audioOff.subscribe(function() {
    if (!isConnected) return;
    oscillator.disconnect(audioCtx.destination);
    isConnected = false;
  });
}