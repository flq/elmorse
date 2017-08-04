import './main.css';
import { Main } from './Main.elm';
import { initAudioPort  } from './audioPort.js';
const app = Main.embed(document.getElementById('root'));

initAudioPort(app);