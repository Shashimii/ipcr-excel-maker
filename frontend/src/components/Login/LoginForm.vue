<template>
    <div class="card-panel">
        <div class="header">
            <i class="large material-icons green-text">near_me</i>
            <h1>Sign up</h1>
            <p class="green-text accent-4">Enter your Username & Password.</p>
        </div>
        <div class="content">
            <div class="row">
                <form @submit.prevent="loginUser()" class="form-container">
                    <div class="input-field col s12">
                        <i class="material-icons prefix">account_circle</i>
                        <input v-model="loginCredentials.username" placeholder="Username" id="username" type="text">
                        <label for="username">Enter Username</label>
                        <p v-if="validationMSG.validateUsername" class="validation">{{ validationMSG.validateUsername }}</p>
                    </div>
                    <div class="password-field-container">
                        <div class="input-field col s12">
                            <i class="material-icons prefix">lock</i>
                            <input v-model="loginCredentials.password" placeholder="Password" id="password" :type="showPassword ? 'text' : 'password'">
                            <label for="password">Enter Password</label>
                            <p v-if="validationMSG.validatePassword" class="validation">{{ validationMSG.validatePassword }}</p>
                        </div>

                        <a class="toggle-password-btn no-select" @click.prevent="togglePassword()">
                            <i v-if="showPassword" class="material-icons">visibility_off</i>
                            <i v-else class="material-icons">visibility</i>
                        </a>
                    </div>

                    <div class="btn-container">
                        <button class="btn waves-effect waves-light green accent-4 btn-block" type="submit">Sign up</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="footer">
            <p>v1.0.0</p>
            <i class="fa-brands fa-github"></i>
            <a href="https://github.com/Shashimii" class="black-text"><p>Shashimii</p></a>
        </div>
    </div>
</template>

<script>
export default {
    name: 'LoginForm',

    data() {
        return {
            loginCredentials: {
                username: '',
                password: ''
            },

            validationMSG: {
                validateUsername: '',
                validatePassword: ''
            },

            showPassword: false
        }
    },

    computed: {
        logedUserInfo() {
            return this.$store.getters.loggedUser;
        }
    },

    methods: {
        togglePassword() {
            this.showPassword = !this.showPassword;
        },

        loginUser() {
            if(this.validation()) {
                this.$store.dispatch('loginUser', {
                    loginCredentials: this.loginCredentials,
                    router: this.$router
                });
            } 
        },

        validation() {
            this.validationMSG = {
                validateUsername: '',
                validatePassword: ''
            }

            let isValid = true;

            if (this.loginCredentials.username === '') {
                this.validationMSG.validateUsername = 'Username cannot be empty.'
                isValid = false;
            }

            if (this.loginCredentials.password === '') {
                this.validationMSG.validatePassword = 'Password cannot be empty.'
                isValid = false;
            }

            return isValid
        },

        initializeMaterializeCSS() {
            this.$nextTick(() => {
                M.updateTextFields();
            });
        }
    },

    watch: {
        logedUserInfo: {
            handler() {
                console.log(this.logedUserInfo);
            },

            deep: true
        }
    },

    updated() {
        this.initializeMaterializeCSS();
    },

    mounted() {
        this.initializeMaterializeCSS();
    }
}
</script>

<style scoped>
.card-panel {
    padding: 0 !important;
    flex: 1;
    display: flex;
    flex-direction: column;
}

.header {
    padding-top: 2rem;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}

.content {
    padding: 3rem;
    height: 60%;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.form-container {
    display: flex;
    flex-direction: column;
    gap: 2rem;
}

.password-field-container {
    display: flex;
    align-items: center;
    justify-content: center;
}

.toggle-password-btn {
    color: black;
    cursor: pointer;
}

.btn-container {
    display: flex;
    align-items: center;
    padding-inline: 0.7rem;
}

.footer {
    border-top: 1px solid #cfd8dc;
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
}
</style>