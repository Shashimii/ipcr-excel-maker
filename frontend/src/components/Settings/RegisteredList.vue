<template>
    <div class="card-panel">
        <div class="card-header">
            <h3>Officers</h3>
            <div class="btn-container">
                <button @click="addOfficer()" class="btn waves-effect waves-light green accent-4"><i class="material-icons left">person_add</i>Add New</button>
            </div>
        </div>
        <div v-if="officers.length != 0">
            <ul>
                <li v-for="(officer, index) in this.officers" :key="index" class="list">
                    <p class="list-text">{{ officer.name }}</p>
                    <div class="list-btn">
                        <button @click="editOfficer(index)" class="btn waves-effect waves-light blue accent-4">Edit</button>
                        <button @click="deleteOfficer(index)" class="btn waves-effect waves-light red accent-4">Delete</button>
                    </div>
                </li>
            </ul>
        </div>
        <div v-else class="no-prompt">
            <p class="no-prompt-primary-text">Officers List will be shown here.</p>
            <p class="no-prompt-secondary-text">Add Officer using Add New button.</p>
        </div>
    </div>

    <div class="card-panel">
        <div class="card-header">
            <h3>Duties</h3>
            <div class="btn-container">
                <button @click="addDuty()" class="btn waves-effect waves-light green accent-4"><i class="material-icons left">description</i>Add New</button>
            </div>
        </div>
        <div v-if="duties.length != 0">
            <ul>
                <li v-for="(duty, index) in this.duties" :key="index" class="list">
                    <p class="list-text">{{ duty.title }}</p>
                    <div class="list-btn">
                        <button @click="editDuty(index)" class="btn waves-effect waves-light blue accent-4">Edit</button>
                        <button @click="deleteDuty(index)" class="btn waves-effect waves-light red accent-4">Delete</button>
                    </div>
                </li>
            </ul>
        </div>
        <div v-else class="no-prompt">
            <p class="no-prompt-primary-text">Duties List will be shown here.</p>
            <p class="no-prompt-secondary-text">Add Duties using Add New button.</p>
        </div>
    </div>



    <!-- Modals -->

    <div id="modal1" class="modal modal-fixed-footer">
        <form @submit.prevent="applyEditOfficer()">
            <div class="modal-content">
                <i class="large material-icons blue-text">edit</i>
                <h4>Edit Officer</h4>
                <div class="input-field col s12">
                    <input type="text" placeholder="Name" v-model="officerData.name">
                    <label>Officer Name</label>
                    <p v-if="validationMSG.validateOfficer" class="validation">{{ validationMSG.validateOfficer }}</p>
                </div>
            </div>
            <div class="modal-footer">
                <button @click.prevent="resetModal()" class="btn-flat waves-effect waves-light modal-close btn-block">Cancel</button>
                <button class="btn waves-effect waves-light blue accent-4 btn-block" type="submit">Apply Changes</button>
            </div>
        </form>
    </div>

    <div id="modal2" class="modal modal-fixed-footer">
        <div class="modal-content">
            <i class="large material-icons red-text">delete_forever</i>
            <h4>Delete Officer</h4>
            <h5>Sure you want to Delete this Officer ?</h5>
            <h5 class="red-text">{{ officerData.name }}</h5>
        </div>
        <div class="modal-footer">
            <button @click.prevent="resetModal()" class="btn-flat waves-effect waves-light modal-close btn-block">No Cancel</button>
            <button @click="applyDeleteOfficer()" class="btn waves-effect waves-light red accent-4 btn-block">Yes Delete Officer</button>
        </div>
    </div>

    <div id="modal3" class="modal modal-fixed-footer">
        <form @submit.prevent="applyEditDuty()">
            <div class="modal-content">
                <i class="large material-icons blue-text">edit</i>
                <h4>Edit Duty</h4>
                <div class="input-field col s12">
                    <input type="text" placeholder="Title" v-model="dutyData.title">
                    <label>Duty Title</label>
                    <p v-if="validationMSG.validateDuty" class="validation">{{ validationMSG.validateDuty }}</p>
                </div>
            </div>
            <div class="modal-footer">
                <button @click.prevent="resetModal()" class="btn-flat waves-effect waves-light modal-close btn-block">Cancel</button>
                <button class="btn waves-effect waves-light blue accent-4 btn-block" type="submit">Apply Changes</button>
            </div>
        </form>
    </div>

    <div id="modal4" class="modal modal-fixed-footer">
        <div class="modal-content">
            <i class="large material-icons red-text">delete_forever</i>
            <h4>Delete Duty</h4>
            <h5>Sure you want to Delete this Duty ?</h5>
            <h5 class="red-text">{{ dutyData.title }}</h5>
        </div>
        <div class="modal-footer">
            <button @click.prevent="resetModal()" class="btn-flat waves-effect waves-light modal-close btn-block">No Cancel</button>
            <button @click="applyDeleteDuty()" class="btn waves-effect waves-light red accent-4 btn-block">Yes Delete Duty</button>
        </div>
    </div>
    
    <div id="modal5" class="modal modal-fixed-footer">
        <form @submit.prevent="saveOfficer()">
            <div class="modal-content">
                <i class="large material-icons blue-text">person_add</i>
                <h4>Add Officer</h4>
                <div class="input-field col s12">
                    <input type="text" placeholder="Name" v-model="officerData.name">
                    <label>Officer Name</label>
                    <p v-if="validationMSG.validateOfficer" class="validation">{{ validationMSG.validateOfficer }}</p>
                </div>
            </div>
            <div class="modal-footer">
                <button @click.prevent="resetModal()" class="btn-flat waves-effect waves-light modal-close btn-block">Cancel</button>
                <button class="btn waves-effect waves-light blue accent-4 btn-block" type="submit">Add Officer</button>
            </div>
        </form>
    </div>

    <div id="modal6" class="modal modal-fixed-footer">
        <form @submit.prevent="saveDuty()">
            <div class="modal-content">
                <i class="large material-icons blue-text">description</i>
                <h4>Add Duty</h4>
                <div class="input-field col s12">
                    <input type="text" placeholder="Title" v-model="dutyData.title">
                    <label>Duty Title</label>
                    <p v-if="validationMSG.validateDuty" class="validation">{{ validationMSG.validateDuty }}</p>
                </div>
            </div>
            <div class="modal-footer">
                <button @click.prevent="resetModal()" class="btn-flat waves-effect waves-light modal-close btn-block">Cancel</button>
                <button class="btn waves-effect waves-light blue accent-4 btn-block" type="submit">Add Duty</button>
            </div>
        </form>
    </div>
</template>

<script>
export default {
    name: 'RegisteredList',

    data() {
        return {
            officerData: {
                id: null,
                name: '',
            },

            dutyData: {
                id: null,
                title: '',
            },

            validationMSG: {
                validateOfficer: '',
                validateDuty: ''
            }
        }
    },

    computed: {
        // get data from store
        officers() {
           return this.$store.getters.officers;
        },

        duties() {
            return this.$store.getters.duties;
        },
    },

    methods: {
        // officer

        // add
        addOfficer() {
            // open modal
            M.Modal.getInstance(document.getElementById('modal5')).open();
        },

        // save new
        saveOfficer() {
            if (this.validateOfficerData()) {
                this.$store.dispatch('postOfficer', this.officerData.name);
            }
        },

        // edit
        editOfficer(index) {
            // open modal
            M.Modal.getInstance(document.getElementById('modal1')).open();
            // set
            this.setofficerData(index);
        },

        // delete
        deleteOfficer(index) {
            // open modal
            M.Modal.getInstance(document.getElementById('modal2')).open();
            // set
            this.setofficerData(index);
        },

        // set data for edit/delete
        setofficerData(index) {
            this.officerData = {
                id: this.officers[index].id,
                name: this.officers[index].name
            }
        },

        // apply edit
        applyEditOfficer() {
            if (this.validateOfficerData()) {
                console.table(this.officerData);
                this.$store.dispatch('editOfficer', this.officerData);
            }
        },

        // apply delete
        applyDeleteOfficer() {
            this.$store.dispatch('deleteOfficer', this.officerData.id);
        },

        // validate
        validateOfficerData() {
            let isValid = true;
            const regex = /^[a-zA-Z0-9.,\-! /]+$/;

            if(this.officerData.name === '' || !regex.test(this.officerData.name.trim())) {
                if (this.officerData.name === '' ) {
                    this.validationMSG.validateOfficer = 'Officer Name cannot by empty'
                    isValid = false
                } else {
                    this.validationMSG.validateOfficer = 'Officer Name Invalid Format'
                    isValid = false
                }
            }

            return isValid
        },

        // duty

        // add
        addDuty() {
            // open modal
            M.Modal.getInstance(document.getElementById('modal6')).open();
        },

        // save new 
        saveDuty() {
            if (this.validateDutyData()) {
                this.$store.dispatch('postDuty', this.dutyData.title);
            }
        },

        // edit
        editDuty(index) {
            // open modal
            M.Modal.getInstance(document.getElementById('modal3')).open();
            // set
            this.setDutyData(index);
        },

        // delete
        deleteDuty(index) {
            // open modal
            M.Modal.getInstance(document.getElementById('modal4')).open();
            // set
            this.setDutyData(index);
        },

        // set data for edit/delete
        setDutyData(index) {
            this.dutyData = {
                id: this.duties[index].id,
                title: this.duties[index].title
            }
        },

        // apply edit
        applyEditDuty() {
            if (this.validateDutyData()) {
                this.$store.dispatch('editDuty', this.dutyData);
            }
        },

        // apply delete
        applyDeleteDuty() {
            this.$store.dispatch('deleteDuty', this.dutyData.id);
        },

        // validate
        validateDutyData() {
            let isValid = true;
            const regex = /^[a-zA-Z0-9.,\-! /]+$/;

            if(this.dutyData.title === '' || !regex.test(this.dutyData.title.trim())) {
                if (this.dutyData.title === '' ) {
                    this.validationMSG.validateDuty = 'Duty Title cannot be Empty'
                    isValid = false
                } else {
                    this.validationMSG.validateDuty = 'Duty Title invalid format'
                    isValid = false
                }
            }

            return isValid
        },

        // modal cancel/close 
        resetModal() {
            if (this.officerData != '') {
                this.officerData = {
                    id: null,
                    name: '',
                }

                this.validationMSG = {
                    validateOfficer: '',
                }
            }

            if (this.dutyData != '') {
                this.dutyData = {
                    id: null,
                    title: '',
                }

                this.validationMSG = {
                    validateDuty: '',
                }
            }
        },

        initializeMaterializeCSS() {
            this.$nextTick(() => {
                const ModalElems = document.querySelectorAll('.modal');
                M.Modal.init(ModalElems, {
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
        }
    },

    beforeUnmount() {
        this.closeMaterializeCSS();
    }
}
</script>

<style scoped>
.card-panel {
    padding: 0;
}

.card-header {
    padding-inline: 2rem;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.list {
    padding-inline: 2rem;
    padding-block: 0.5rem;
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-top: 1px solid #cfd8dc;
    transition: background-color 0.3s;
}

.list:hover {
    background-color: #cfd8dc;
}

.list-btn {
    display: flex;
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

.btn-container {
    padding-top: 1.5rem;
}

</style>

