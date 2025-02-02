<template>
    <header>
        <h3>Officer Duties</h3>

        <button v-if="this.assignedOfficers.length != 0" @click="deleteAll()" class="btn waves-effect waves-light red accent-4"><i class="material-icons left">delete_sweep</i>Delete All</button>
    </header>
    <div v-if="assignedOfficers.length != 0">
        <ul class="collapsible">
            <li v-for="(officer, index) in this.assignedOfficers" :key="index">
                <div class="collapsible-header">
                    <i class="material-icons">person</i>
                        {{ officer.name }}
                    <span class="new badge red" data-badge-caption="Duties">
                        {{ officer.assigned_duties.length }}
                    </span>
                </div>
                <div class="collapsible-body">
                    <div class="header">
                        <i class="small material-icons">description</i>
                        <h5>Duties</h5>
                    </div>
                    <ul>
                        <li v-for="(assignedDuty, index) in officer.assigned_duties" :key="index">
                            <div class="assigned-duty">
                                <div class="duty-item">
                                    <div class="duty-item-content">
                                        <i class="small material-icons">description</i>
                                        <p>{{ assignedDuty.duty }}</p>
                                    </div>
                                </div>
                                <div class="duty-item">
                                    <div class="duty-item-content">
                                        <i class="small material-icons">event_available</i>
                                        <p>{{ assignedDuty.date }}</p>
                                    </div>
                                </div>
                                <div class="duty-item">
                                    <div class="duty-item-content">
                                        <i class="small material-icons">looks_6</i>
                                        <p>{{ assignedDuty.code }}</p>
                                    </div>
                                </div>
                                <div class="duty-item-btn">
                                    <button @click="this.deleteDuty(assignedDuty.id, assignedDuty.duty)" class="btn waves-effect waves-lighten red accent-4">
                                        Delete
                                        <i class="material-icons left">delete_forever</i>
                                    </button>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </li>
        </ul>
    </div>
    <div v-else class="no-prompt">
        <p class="no-prompt-primary-text">Assigned Officers Duties will be shown here.</p>
        <p class="no-prompt-secondary-text">Assign Duties on Assign Duties section first.</p>
    </div>

    <div id="confirmDeleteModal" class="modal modal-fixed-footer">
        <div class="modal-content">
            <i class="large material-icons red-text">delete_forever</i>
            <h4>Delete Duty</h4>
            <h5>Sure you want to Delete this Duty ?</h5>
            <h5 class="red-text">{{ dutyData.duty }}</h5>
        </div>
        <div class="modal-footer">
            <button @click.prevent="resetModal()" class="btn-flat waves-effect waves-light modal-close btn-block">No Cancel</button>
            <button @click="applyDeleteDuty()" class="btn waves-effect waves-light red accent-4 btn-block">Yes Delete Duty</button>
        </div>
    </div>
    <div id="confirmDeleteAll" class="modal modal-fixed-footer">
        <div class="modal-content">
            <i class="large material-icons red-text">delete_forever</i>
            <h4>Delete All Duties</h4>
            <h5>Sure you want to Delete All Assigned Duties ?</h5>
            <h5 class="red-text">This cannot be undone.</h5>
        </div>
        <div class="modal-footer">
            <button class="btn-flat waves-effect waves-light modal-close btn-block">No Cancel</button>
            <button @click="applyDeleteAll()" class="btn waves-effect waves-light red accent-4 btn-block">Yes Delete All Assigned Duties</button>
        </div>
    </div>
</template>

<script>
export default {
    name: 'AssignedOfficers',

    data() {
        return {
            dutyData: {
                id: null,
                duty: ''
            }
        }
    },

    computed: {
        assignedOfficers() {
            return this.$store.getters.assignedOfficers;
        }
    },

    methods:{
        deleteDuty(id, duty) {
            // open modal
            M.Modal.getInstance(document.getElementById('confirmDeleteModal')).open();
            this.setDutyData(id, duty);
        },

        setDutyData(id, duty) {
            this.dutyData = {
                id: id,
                duty: duty
            }
        },

        applyDeleteDuty() {
            this.$store.dispatch('deleteAssignedDuty', this.dutyData.id);
        },

        // modal cancel/close 
        resetModal() {
            if (this.dutyData != '') {
                this.dutyData = {
                    id: null,
                    duty: ''
                }
            }
        },

        deleteAll() {
            // open modal
            M.Modal.getInstance(document.getElementById('confirmDeleteAll')).open();
        },

        applyDeleteAll() {
            this.$store.dispatch('deleteAllAssignedDuties');
        },

        materializeCSS() {
            // initalize after DOM updates
            this.$nextTick(() => {
                const CollapsibleElem = document.querySelectorAll('.collapsible');
                M.Collapsible.init(CollapsibleElem, {
                    inDuration: 300,
                    outDuration: 400
                });

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

    watch: {
        assignedOfficers: {
            handler() {
                this.closeMaterializeCSS();
                this.materializeCSS();
            },
            deep: true
        },
    },

    mounted() {
        this.materializeCSS();
    },

    beforeUnmount() {
        this.closeMaterializeCSS();
    }
}
</script>

<style scoped>
header {
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.header {
    display: flex;
    align-items: center;
    justify-content: flex-start;
    gap: 0.5rem;
}

.assigned-duty {
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-top: 1px solid #cfd8dc;
    border-radius: 0.3rem;
    transition: background-color 0.3s;
}

 /* applies to all child div */
.assigned-duty > * {
    padding: 1rem;
    flex: 1;
    display: flex;
    justify-content: center;
}

.assigned-duty:hover {
    background-color: #cfd8dc;
}

.duty-item {
    display: flex;
    justify-content: flex-start;
}

.duty-item-btn {
    display: flex;
    justify-content: flex-end;
}

.duty-item-content {
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.btn-container {
    margin-top: 0.5rem;
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


@media screen and (max-width: 999px) {
    .assigned-duty {
        flex-direction: column;
    }

    .duty-item {
        display: flex;
        width: 100%;
        justify-content: flex-start;
    }
}
</style>