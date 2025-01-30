import { createStore } from 'vuex'
import axios from 'axios';


export default createStore({
  state: {
    loggedUser: [],
    officers: [],
    duties: [],
    assignedDuties: [],
    assignedOfficers: [],
  },

  getters: {
    loggedUser: state => state.loggedUser,
    officers: state => state.officers,
    duties: state => state.duties,
    assignedDuties: state => state.assignedDuties,
    assignedOfficers: state => state.assignedOfficers
  },

  mutations: {
    save_logged_user(state, loggedUser) {
      state.loggedUser = loggedUser;
    },

    save_officers(state, officers) {
      state.officers = officers;
    },

    save_duties(state, duties) {
      state.duties = duties;
    },

    save_assigned_duties(state, assignedDuties) {
      state.assignedDuties = assignedDuties;
    },

    save_assigned_officers(state, assignedOfficers) {
      state.assignedOfficers = assignedOfficers;
    }
  },

  actions: {
    // login user
    async loginUser({ dispatch }, {loginCredentials, router}) {
      try {
        await axios.get('/sanctum/csrf-cookie');

        const response = await axios.post('/login', {
          username: loginCredentials.username,
          password: loginCredentials.password
        });


        if (response.status === 200) {

          dispatch('getLoggedUser');

          const token = response.data.token;
          localStorage.setItem('authToken', token);
          router.push('/');

          M.toast({
            html:'<p class="toast-text">Login Success</p>',
            displayLength: 5000
          })
        }

      } catch (error) {
        if (error.status === 404) {
            M.toast({
            html:'<p class="toast-text">Invalid Username</p>',
            displayLength: 5000
          })
        } else if (error.status === 401) {
            M.toast({
            html:'<p class="toast-text">Wrong Password</p>',
            displayLength: 5000
          })
        } else {
          M.toast({
            html:'<p class="toast-text">Somethin went wrong Please try again Later</p>',
            displayLength: 5000
          })
        }
      }
    },

    // load logged user info
    async getLoggedUser({ commit }) {
      try {
        const response = await axios.get('/user');
        commit('save_logged_user', response.data)
      } catch (error) {
        console.error(error);
      }
    },

    // edit username
    async editUsername({ dispatch }, editData) {
      try {
        const response = await axios.patch(`/editUsername/${editData.id}`, editData);
        if (response.status === 200) {
          dispatch('getLoggedUser');
          M.toast({
            html: '<p class="toast-text">Username Changed Successfully.<p>',
            displayLength: 3000
          })
        }
      } catch (error) {
        console.error(error);
      }
    },

    // edit password
    async editPassword({ dispatch }, editData) {
      try {
        const response = await axios.patch(`/editPassword/${editData.id}`, editData);
        if (response.status === 200) {
          dispatch('getLoggedUser');
          M.toast({
            html: '<p class="toast-text">Password Changed Successfully.<p>',
            displayLength: 3000
          })
        }
      } catch (error) {
        console.error(error);
      }
    },

    // load data
    async getOfficers({ commit }) {
      try {
          const response = await axios.get('/getOfficers');
          commit('save_officers', response.data);
      } catch (error) {
          console.error(error);
      }
    },

    async getDuties({ commit }) {
      try {
          const response = await axios.get('/getDuties');
          commit('save_duties', response.data);
      } catch (error) {
          console.error(error);
      }
    },

    async getAssignedDuties({ commit }) {
      try {
          const response = await axios.get('/getAssignedDuties');
          commit('save_assigned_duties', response.data);
      } catch (error) {
          console.error(error);
      }
    },

    async getAssignedOfficers({ commit }) {
      try {
        const response = await axios.get('/getAssignedOfficers');
        commit('save_assigned_officers', response.data);
      } catch (error) {
        console.error(error);
      }
    },

    // post data
    async postOfficer({ dispatch }, officer) {
      try {
        const response = await axios.post('/postOfficer', {
          name: officer
        })

        if (response.status === 200) {
          dispatch('getOfficers');
          M.toast({
            html: '<p class="toast-text">Officer Added Successfully.<p>',
            displayLength: 3000
          });
        }
      } catch (error) {
        console.error(error);
      }
    },

    async postDuty({ dispatch }, duty) {
      try {
        const response = await axios.post('/postDuty', {
          title: duty
        })

        if (response.status === 200) {
          dispatch('getDuties');
          M.toast({
            html: '<p class="toast-text">Duty Added Successfully.<p>',
            displayLength: 3000
          });
        }
      } catch (error) {
        console.error(error);
      }
    },
 
    async postAssignedDuty({ dispatch }, assignedDuty) {
      try {
        const response = await axios.post('/postAssignedDuty', {
          officer_id: assignedDuty.officer_id,
          duty_id: assignedDuty.duty_id,
          officer_index: assignedDuty.officer_index,
          duty_index: assignedDuty.duty_index,
          officer: assignedDuty.officer,
          duty: assignedDuty.duty,
          date: assignedDuty.date,
          odtsCode: assignedDuty.odtsCode
        });
        
        if (response.status === 200) {
          dispatch('getAssignedDuties');
          M.toast({
            html: '<p class="toast-text">Duty Assigned Successfully.<p>',
            displayLength: 3000
          });
        }
      } catch (error) {
        console.error(error);     
      }
    },

    // edit data
    async editOfficer({ dispatch }, editData) {
      try {
        const response = await axios.patch(`/editOfficer/${editData.id}`, editData);
        if (response.status === 200) {
          dispatch('getOfficers');
          M.toast({
            html: '<p class="toast-text">Officer Edited Successfully.<p>',
            displayLength: 3000
          })
        }
      } catch (error) {
        console.error(error);
      }
    },

    async editDuty({ dispatch }, editData) {
      try {
        const response = await axios.patch(`/editDuty/${editData.id}`, editData);
        if (response.status === 200) {
          dispatch('getDuties');
          M.toast({
            html: '<p class="toast-text">Duty Edited Successfully.<p>',
            displayLength: 3000
          })
        }
      } catch (error) {
        console.error(error);
      }
    },

    // delete
    async deleteOfficer({ dispatch }, id) {
      try {
        const response = await axios.delete(`/deleteOfficer/${id}`);
        
        if (response.status === 200) {
          dispatch('getOfficers');
          M.toast({
            html: '<p class="toast-text">Officer Deleted Successfully.<p>',
            displayLength: 3000
          })
        }
      } catch (error) {
        console.error(error);     
      }
    },

    async deleteDuty({ dispatch }, id) {
      try {
        const response = await axios.delete(`/deleteDuty/${id}`);
        
        if (response.status === 200) {
          dispatch('getDuties');
          M.toast({
            html: '<p class="toast-text">Duty Deleted Successfully.<p>',
            displayLength: 3000
          })
        }
      } catch (error) {
        console.error(error);     
      }
    },

    async deleteAssignedDuty({ dispatch }, id) {
      try {
        const response = await axios.delete(`/deleteAssignedDuty/${id}`);
        
        if (response.status === 200) {
          dispatch('getAssignedOfficers');
          M.toast({
            html: '<p class="toast-text">Duty Deleted Successfully.<p>',
            displayLength: 3000
          })
        }
      } catch (error) {
        console.error(error);     
      }
    },
    
  },

  modules: {
  }
})
