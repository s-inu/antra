// 1.
let salaries = {
  John: 100,
  Ann: 160,
  Pete: 130,
};

const SOLN1 = ((o) => Object.values(o).reduce((acc, cur) => acc + cur))(
  salaries
);

// 2.
let menu = {
  width: 200,
  height: 300,
  title: "My menu",
};

function multiplyNum(obj) {
  Object.entries(obj).forEach(
    ([k, v]) => (obj[k] = typeof v === "number" ? v * 2 : v)
  );
}
const SOLN2 = multiplyNum;

// 3.
function checkEmailId(str) {
  return /@.+\./i.test(str);
}
const SOLN3 = checkEmailId;

// 4.
function truncate(str, maxlength) {
  const ELLIPSIS_CHAR = "\u2026"; // U+2026: …

  return str.length <= maxlength
    ? str
    : str.slice(0, maxlength - ELLIPSIS_CHAR.length) + ELLIPSIS_CHAR;
}
const SOLN4 = truncate;

// 5.
const SOLN5 = () => {
  const styles = ["James", "Brennie"];

  styles.push("Robert");
  styles.length % 2 === 1 && (styles[(styles.length - 1) / 2] = "Calvin");
  styles.splice(0, 1), console.log(styles);
  styles.unshift("Rose", "Regal");

  return styles;
};
