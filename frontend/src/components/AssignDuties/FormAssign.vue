<template>
    <div class="card-panel">
        <div class="header">
            <i class="large material-icons blue-text">edit</i>
            <h3>Assign Duty</h3>
        </div>
        <form @submit.prevent="this.formSubmit()">
            <div class="row">
                <div class="input-field col s12">
                    <i class="material-icons prefix">person</i>
                    <select v-model="assignedDuty.officer_index" ref="selectionOfficer">
                        <option value="" disabled selected>Select Officer</option>
                        <option v-for="(officer, index) in this.officers" :key="index" :value="index">{{ officer.name }}</option>
                    </select>
                <label>Officer</label>
                <p v-if="validationMSG.officer" class="validation">{{ validationMSG.officer }}</p> 
                </div>
                <div class="input-field col s12">
                    <i class="material-icons prefix">description</i>
                    <select v-model="assignedDuty.duty_index" ref="selectionDuty" id="select">
                        <option value="" disabled selected>Select Duty</option>
                        <option v-for="(duty, index) in  this.duties" :key="index" :value="index">{{ duty.title }}</option>
                    </select>
                    <label>Duty</label>
                    <p v-if="validationMSG.duty" class="validation">{{ validationMSG.duty }}</p> 
                </div>
                <div class="input-field col s12">
                    <i class="material-icons prefix">event_available</i>
                    <input id="datepickerInput" type="text" class="datepicker" placeholder="Select Assign Date">
                    <label>Select Date</label>
                    <p v-if="validationMSG.date" class="validation">{{ validationMSG.date }}</p> 
                </div>
                <div class="input-field col s12">
                    <i class="material-icons prefix">looks_6</i>
                    <input v-model="assignedDuty.odtsCode" type="text" placeholder="Enter ODTS Code">
                    <label>ODTS Code</label>
                    <p v-if="validationMSG.odtsCode" class="validation">{{ validationMSG.odtsCode }}</p> 
                </div>
  
                <div class="col s12">
                    <button class="btn waves-effect waves-light green accent-4 btn-block" type="submit">Assign Duty</button>
                </div>
            </div>
        </form>
    </div>
</template>

<script>
export default {
    name: 'FormAssign',

    data() {
        return {
            // holds form data
            assignedDuty: {
                officer_id: null,
                duty_id: null,
                officer_index: '',
                duty_index: '',
                officer: '',
                duty: '',
                date: '',
                odtsCode: ''
            },

            // holds validation message
            validationMSG: {
                officer: '',
                duty: '',
                date: '',
                odtsCode: ''
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
        validation() {
            // clear values
            this.validationMSG = {
                officer: '',
                duty: '',
                date: '',
                odtsCode: ''
            }

            // flag
            let isValid = true;
            // valid format
            const regex = /^[a-zA-Z0-9-_]+$/;

            // validate

            // officer
            if(this.assignedDuty.officer_index === '') {
                this.validationMSG.officer = 'Please Select an Officer.'
                isValid = false;
            }

            // duty
            if(this.assignedDuty.duty_index === '') {
                this.validationMSG.duty = 'Please Select a Duty.'
                isValid = false;
            }

            // date
            if(this.assignedDuty.date === '') {
                this.validationMSG.date = 'Please Select a Date.'
                isValid = false;
            }

            // code
            if(this.assignedDuty.odtsCode === '' || !regex.test(this.assignedDuty.odtsCode)) {
                if (this.assignedDuty.odtsCode === '') {
                    this.validationMSG.odtsCode = 'ODTS Code cannot be empty.'
                    isValid = false;
                } else {
                    this.validationMSG.odtsCode = 'ODTS Code Invalid Format'
                    isValid = false;
                }
            } 

            // return flag
            return isValid
        },

        formSubmit() {
            // validation
            if (this.validation()) {
                // set officer
                const selectionOfficer = this.$refs.selectionOfficer;
                this.assignedDuty.officer = selectionOfficer.options[selectionOfficer.selectedIndex].text;
                // set duty
                const selectionDuty = this.$refs.selectionDuty;
                this.assignedDuty.duty = selectionDuty.options[selectionDuty.selectedIndex].text;
                // set officer id
                this.assignedDuty.officer_id = this.officers[this.assignedDuty.officer_index].id;
                // set duty id
                this.assignedDuty.duty_id = this.duties[this.assignedDuty.duty_index].id;
                // set code
                this.assignedDuty.odtsCode = '(' + this.assignedDuty.odtsCode + ')';
                // post 
                this.formPost();
                // clear
                this.formClear();
            }

        },

        formPost() {
            // call the action on store with form data
            this.$store.dispatch('postAssignedDuty', this.assignedDuty);
        },

        formClear() {
            // clear holders
            this.assignedDuty = {
                officer_id: null,
                duty_id: null,
                officer_index: '',
                duty_index: '',
                officer: '',
                duty: '',
                date: '',
                odtsCode: ''
            }
            // clear datepicker
            document.querySelector('.datepicker').value = '';
            // reinitalize
            this.initializeMaterializeCSS();
        },

        initializeMaterializeCSS() {
            // initalize after DOM updates
            this.$nextTick(() => {
                const SelectElem = document.querySelectorAll('select');
                M.FormSelect.init(SelectElem, {});

                const DatepickerElem = document.querySelector('.datepicker');
                M.Datepicker.init(DatepickerElem, {
                    format: 'mm/dd/yyyy',
                    onClose: () => {
                        this.assignedDuty.date = document.querySelector('#datepickerInput').value;
                    }
                });

                M.updateTextFields();
            });
        },

        closeMaterializeCSS() {
            const DatepickerElems = document.querySelectorAll('.datepicker');

            DatepickerElems.forEach(DatepickerElem => {
                var instance = M.Datepicker.getInstance(DatepickerElem);
                if (instance) {
                    instance.close();
                }
            });
        }

    },

    watch: {
        // reinitalize when the data is loaded
        officers: {
            handler() {
                this.initializeMaterializeCSS();
            },
            deep: true
        },

        duties: {
            handler() {
                this.initializeMaterializeCSS();
            },
            deep: true
        }
    },

    mounted() {
        // intialize
        this.initializeMaterializeCSS();
    },

    beforeUnmount() {
        this.closeMaterializeCSS();
    }
}
</script>

<style scoped>
.header {
    padding-top: 2rem;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}
</style>