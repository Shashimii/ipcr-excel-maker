<template>
  <div class="navbar-fixed">
    <nav class="black">
      <div class="nav-wrapper white-text">
        <ul>
          <li><router-link to="/" class="nav-link">Dashboard</router-link></li>
          <li><router-link to="/assigned-duties" class="nav-link">Assign Duties</router-link></li>
          <li><router-link to="/officers-duties" class="nav-link">Officers Duties</router-link></li>
          <li><router-link to="/settings" class="nav-link">Settings</router-link></li>
          <li><a @click.prevent="logout()" class="nav-link">Logout</a></li>
        </ul>
      </div>
    </nav>
  </div>
  <div style="height: 2rem;"></div>
</template>

<script>
import axios from 'axios'
export default {
  name: 'PageNavbar',

  methods: {
    async logout() {
      try {
        await axios.post(`/logout`)
        
        localStorage.removeItem('authToken');
        this.$router.push('/login')

        M.toast({
          html:'<p class="toast-text">Logged Out</p>',
          displayLength: 4000
        })

      } catch (error) {
        console.error('Fail to logout', error.message);
      }
    }
  }
}

</script>

<style scoped>
nav {
  display: flex;
  justify-content: center;
  align-items: center;
}

.router-link-active {
    color: #00c853 ;
    font-weight: bold; 
}
</style>