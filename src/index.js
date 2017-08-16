import './main.css';
import { Main } from './Main.elm';
import { initAudioPort  } from './typing/audioPort';
import { initLocalStoragePort } from './localStoragePort';
const app = Main.embed(document.getElementById('root'));

initAudioPort(app);
initLocalStoragePort(app);