import './main.css';
import { Main } from './Main.elm';
import { initAudioPort  } from './typing/audioPort';
const app = Main.embed(document.getElementById('root'));

initAudioPort(app);