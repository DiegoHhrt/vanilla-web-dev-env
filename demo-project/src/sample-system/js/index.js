const periodicCall = (repeat = 0) => {
  setTimeout(() => {
    console.log("This message appears every second.", repeat);
    periodicCall(repeat + 1);
  }, 1000);
};

periodicCall();
