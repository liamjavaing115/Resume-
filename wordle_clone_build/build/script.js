import { WORDS } from "./words.js";

const NUMBER_OF_GUESSES = 6;
let guessesRemaining = NUMBER_OF_GUESSES;
let currentGuess = [];
let nextLetter = 0;
let rightGuessString = WORDS[Math.floor(Math.random() * WORDS.length)];

console.log("[DEBUG] answer:", rightGuessString); // remove if you like

function initBoard() {
  const board = document.getElementById("game-board");
  for (let i = 0; i < NUMBER_OF_GUESSES; i++) {
    const row = document.createElement("div");
    row.className = "letter-row";
    for (let j = 0; j < 5; j++) {
      const box = document.createElement("div");
      box.className = "letter-box";
      row.appendChild(box);
    }
    board.appendChild(row);
  }
}
initBoard();

// animate.css helper (from docs)
const animateCSS = (element, animation, prefix = 'animate__') =>
  new Promise((resolve) => {
    const animationName = `${prefix}${animation}`;
    const node = element;
    node.style.setProperty('--animate-duration', '0.3s');
    node.classList.add(`${prefix}animated`, animationName);
    function handleAnimationEnd(e) {
      e.stopPropagation();
      node.classList.remove(`${prefix}animated`, animationName);
      resolve();
    }
    node.addEventListener('animationend', handleAnimationEnd, { once: true });
  });

document.addEventListener("keyup", (e) => {
  if (guessesRemaining === 0) return;

  let pressedKey = String(e.key);

  if (pressedKey === "Backspace" && nextLetter !== 0) {
    deleteLetter();
    return;
  }
  if (pressedKey === "Enter") {
    checkGuess();
    return;
  }

  // only accept letters a-z
  const found = pressedKey.match(/^[a-z]$/i);
  if (!found) return;

  insertLetter(pressedKey);
});

function insertLetter(pressedKey) {
  if (nextLetter === 5) return;

  pressedKey = pressedKey.toLowerCase();
  const row = document.getElementsByClassName("letter-row")[6 - guessesRemaining];
  const box = row.children[nextLetter];

  animateCSS(box, "pulse");
  box.textContent = pressedKey;
  box.classList.add("filled-box");

  currentGuess.push(pressedKey);
  nextLetter += 1;
}

function deleteLetter() {
  const row = document.getElementsByClassName("letter-row")[6 - guessesRemaining];
  const box = row.children[nextLetter - 1];
  box.textContent = "";
  box.classList.remove("filled-box");
  currentGuess.pop();
  nextLetter -= 1;
}

function checkGuess() {
  const row = document.getElementsByClassName("letter-row")[6 - guessesRemaining];
  let guessString = "";
  let rightGuess = Array.from(rightGuessString);

  for (const ch of currentGuess) guessString += ch;

  if (guessString.length !== 5) {
    toastr.error("Not enough letters!");
    return;
  }
  if (!WORDS.includes(guessString)) {
    toastr.error("Word not in list!");
    return;
  }

  for (let i = 0; i < 5; i++) {
    let letterColor = "";
    const box = row.children[i];
    const letter = currentGuess[i];
    const letterPosition = rightGuess.indexOf(letter);

    if (letterPosition === -1) {
      letterColor = "grey";
    } else {
      if (letter === rightGuess[i]) {
        letterColor = "green";
      } else {
        letterColor = "yellow";
      }
      rightGuess[letterPosition] = "#";
    }

    const delay = 250 * i;
    setTimeout(() => {
      animateCSS(box, "flipInX");
      box.style.backgroundColor = letterColor;
      shadeKeyBoard(letter, letterColor);
    }, delay);
  }

  if (guessString === rightGuessString) {
    toastr.success("You guessed right! Game over!");
    guessesRemaining = 0;
    return;
  } else {
    guessesRemaining -= 1;
    currentGuess = [];
    nextLetter = 0;

    if (guessesRemaining === 0) {
      toastr.error("You've run out of guesses! Game over!");
      toastr.info(`The right word was: "${rightGuessString}"`);
    }
  }
}

function shadeKeyBoard(letter, color) {
  for (const elem of document.getElementsByClassName("keyboard-button")) {
    if (elem.textContent === letter) {
      const oldColor = elem.style.backgroundColor;
      if (oldColor === "green") return;
      if (oldColor === "yellow" && color !== "green") return;
      elem.style.backgroundColor = color;
      break;
    }
  }
}

document.getElementById("keyboard-cont").addEventListener("click", (e) => {
  const target = e.target;
  if (!target.classList.contains("keyboard-button")) return;

  let key = target.textContent;
  if (key === "Del") key = "Backspace";
  document.dispatchEvent(new KeyboardEvent("keyup", { key }));
});
