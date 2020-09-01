export default {
  cn: function(defaultClassName, comboMap) {
    return defaultClassName + Object.keys(comboMap).filter((k) => comboMap[k]).reduce((acc, k) => acc + " " + k, "")
  },
}
