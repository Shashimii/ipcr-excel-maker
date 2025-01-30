<template>
  <router-view/>
</template>

<style>
#app {
  font-family: "Lexend", sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

body {
  background-color: #eceff1;
  min-height: 100vh;
}

.br {
  border-radius: 1rem !important;
}

.fr-sb {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
}

.datepicker-modal {
  top: 25% !important;
}

.btn-block {
  display: flex;
  width: 100%;
}

.no-prompt {
  height: 20rem;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.toast-text {
  font-weight: 700;
  color: #ffff00;
}

.no-prompt-primary-text {
  margin: 0;
  font-size: 2rem;
  color: #616161;
}

.no-prompt-secondary-text {
  margin: 0;
  font-size: 1rem;
  font-weight: 700;
  color: #1b5e20;
}

/* label color */
.input-field label {
  color: #000000 !important;
}

/* label focus color */
.input-field input[type=text]:focus + label {
  color: #388e3c !important;
}

/* label underline focus color */
.input-field input[type=text]:focus {
  border-bottom: 1px solid #388e3c !important;
  box-shadow: 0 1px 0 0 #388e3c !important;
}

/* icon prefix focus color */
.input-field .prefix.active {
  color: #388e3c !important;
}

.validation {
  color: red;
}

.preloader-container {
  height: 80vh;
  display: flex;
  align-items: center;
  justify-content: center;
}

</style>
