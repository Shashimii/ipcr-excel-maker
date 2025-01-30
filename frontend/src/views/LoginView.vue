<template>
    <div class="row main">
        <div class="col s12 l7 logo hide-on-med-and-down">
            <img src="@/assets/logo/splash.png" alt="Logo">
        </div>
        <div class="col s12 m12 l5 login">
            <LoginForm></LoginForm>
        </div>
    </div>
</template>

<script>
import LoginForm from '@/components/Login/LoginForm.vue';
export default {
    name: 'loginView',
    components: {
        LoginForm
    },
}
</script>

<style scoped>
.main {
    margin: 0 !important;
    padding: 2rem;
    display: flex;
    height: 100vh;
}

.logo {
    display: flex;
    align-items: center;
    justify-content: center;
}

.login {
    display: flex;
}
</style>