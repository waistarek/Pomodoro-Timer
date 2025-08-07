let workMinutes = 25;
let breakMinutes = 5;
let seconds = 0;
let timerInterval = null;
let isWorkTime = true;

const timerDisplay = document.getElementById("timer");
const beep = document.getElementById("beep");

function updateDisplay() {
    let minutes = isWorkTime ? workMinutes : breakMinutes;
    let sec = seconds < 10 ? "0" + seconds : seconds;
    timerDisplay.textContent = `${minutes}:${sec}`;
}

function startTimer() {
    if (timerInterval) return;
    timerInterval = setInterval(() => {
        if (seconds === 0) {
            if (isWorkTime && workMinutes === 0 || !isWorkTime && breakMinutes === 0) {
                beep.play();
                isWorkTime = !isWorkTime;
                workMinutes = isWorkTime ? 25 : 0;
                breakMinutes = isWorkTime ? 0 : 5;
            }
            if (isWorkTime) {
                workMinutes--;
                seconds = 59;
            } else {
                breakMinutes--;
                seconds = 59;
            }
        } else {
            seconds--;
        }
        updateDisplay();
    }, 1000);
}

function pauseTimer() {
    clearInterval(timerInterval);
    timerInterval = null;
}

function resetTimer() {
    pauseTimer();
    isWorkTime = true;
    workMinutes = 25;
    breakMinutes = 5;
    seconds = 0;
    updateDisplay();
}

document.getElementById("start").addEventListener("click", startTimer);
document.getElementById("pause").addEventListener("click", pauseTimer);
document.getElementById("reset").addEventListener("click", resetTimer);

updateDisplay();
