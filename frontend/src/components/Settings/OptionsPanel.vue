<template>
    <div class="card-panel">
        <h5>Account Settings</h5>
        <button @click="editUsername()" class="btn waves-effect waves-light blue accent-4 btn-block">Change Username</button>
        <button @click="editPassword()" class="btn waves-effect waves-light blue accent-4 btn-block">Change Password</button>
    </div>


    <div id="usernameModal" class="modal modal-fixed-footer">
        <form @submit.prevent="applyEditUsername()">
            <div class="modal-content">
                <i class="large material-icons blue-text">account_circle</i>
                <h4>Edit Username</h4>
                <div class="input-field col s12">
                    <input type="text" placeholder="Username" v-model="userData.username">
                    <label>Account Username</label>
                    <p v-if="validationMSG.validateUsername" class="validation">{{ validationMSG.validateUsername }}</p>
                </div>
            </div>
            <div class="modal-footer">
                <button @click.prevent="resetModal()" class="btn-flat waves-effect waves-light modal-close btn-block">Cancel</button>
                <button class="btn waves-effect waves-light blue accent-4 btn-block" type="submit">Apply Changes</button>
            </div>
        </form>
    </div>

    <div id="passwordModal" class="modal modal-fixed-footer">
        <form @submit.prevent="applyEditPassword()">
            <div class="modal-content">
                <i class="large material-icons blue-text">lock</i>
                <h4>New Password</h4>
                <div class="input-field col s12">
                    <input type="text" placeholder="Password" v-model="userData.password">
                    <label>Account Password</label>
                    <p v-if="validationMSG.validatePassword" class="validation">{{ validationMSG.validatePassword }}</p>
                </div>
            </div>
            <div class="modal-footer">
                <button @click.prevent="resetModal()" class="btn-flat waves-effect waves-light modal-close btn-block">Cancel</button>
                <button class="btn waves-effect waves-light blue accent-4 btn-block" type="submit">Set New Password</button>
            </div>
        </form>
    </div>

</template>

<script>
export default {
    name: 'OptionsPanel',

    data() {
        return {
            userData: {
                id: null,
                username: '',
                password: ''
            },

            validationMSG: {
                validateUsername: '',
                validatePassword: ''
            }
        }
    },

    computed: {
        loggedUserData() {
            return this.$store.getters.loggedUser
        }
    },

    methods: {
        setUserData() {
            this.userData = {
                id: this.loggedUserData.id,
                username: this.loggedUserData.username,
                password: ''
            }
        },

        editUsername() {
            M.Modal.getInstance(document.getElementById('usernameModal')).open();
        },

        editPassword() {
            M.Modal.getInstance(document.getElementById('passwordModal')).open();
        },

        applyEditUsername() {
            if (this.validateUsername()) {
                this.$store.dispatch('editUsername', this.userData)
                this.closeMaterializeCSS();
            }
        },

        applyEditPassword() {
            if (this.validatePassword()) {
                this.$store.dispatch('editPassword', this.userData)
                this.closeMaterializeCSS();
            }
        },

        // validate
        validateUsername() {
            let isValid = true;
            const regex = /^[a-zA-Z0-9.,\-! /]+$/;

            if(this.userData.username === '' || !regex.test(this.userData.username.trim())) {
                if (this.userData.username === '' ) {
                    this.validationMSG.validateUsername = 'Username cannot be Empty'
                    isValid = false
                } else {
                    this.validationMSG.validateUsername = 'Username invalid format'
                    isValid = false
                }
            }

            return isValid
        },

        validatePassword() {
            let isValid = true;
            const regex = /^[a-zA-Z0-9.,\-! /]+$/;

            if(this.userData.password === '' || !regex.test(this.userData.password.trim())) {
                if (this.userData.password === '' ) {
                    this.validationMSG.validatePassword = 'Password cannot be Empty'
                    isValid = false
                } else {
                    this.validationMSG.validatePassword = 'Password invalid format'
                    isValid = false
                }
            }

            return isValid
        },


        // modal cancel/close 
        resetModal() {
            if (this.userData != '') {
                this.userData = {
                    username: '',
                    password: '',
                }

                this.validationMSG = {
                    validateUsername: '',
                    validatePassword: ''
                }
            }
        },

        initializeMaterializeCSS() {
            this.$nextTick(() => {
                const ModalElems = document.querySelectorAll('.modal');
                M.Modal.init(ModalElems, {
                    onOpenStart: () => {
                        this.setUserData();
                    },

                    onCloseEnd: () => {
                        this.resetModal();
                    }
                });

                M.updateTextFields();
            });
        },
        
        closeMaterializeCSS() {
            const ModalElems = document.querySelectorAll('.modal');

            ModalElems.forEach(modalElem => {
                var instance = M.Modal.getInstance(modalElem);
                if (instance) {
                    instance.close();
                }
            });
        }
    },

    mounted() {
        this.initializeMaterializeCSS();
        this.$store.dispatch('getLoggedUser');
        this.setUserData();
    },

    watch: {
        // close modal when data is updated
        officers: {
            handler() {
                this.closeMaterializeCSS();
            },
            deep: true
        },

        duties: {
            handler() {
                this.closeMaterializeCSS();
            },
            deep: true
        },
        
        loggedUserData: {
            handler() {
                this.setUserData();
            },
            deep: true
        }
    },

    beforeUnmount() {
        this.closeMaterializeCSS();
    }
}
</script>

<style scoped>
.card-panel {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.modal {
    max-width: 50rem;
    max-height: 30rem;
    top: 25% !important;
}

.modal-content {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}

.modal-footer {
    padding-inline: 2rem !important;
    display: flex;
    justify-content: center;
    gap: 1rem;
    border: 1px solid #cfd8dc;
}

.btn-flat {
  border: 1px solid #cfd8dc !important;
}


</style>