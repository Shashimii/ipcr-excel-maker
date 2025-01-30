<template>
    <PageNavbar></PageNavbar>
    <div class="row">
        <div class="col s12 m12 l5">
            <FormAssign></FormAssign>
        </div>
        <div class="col s12 m12 l7">
            <IpcrTable></IpcrTable>
        </div>
    </div>
    <div style="height: 5rem;"></div>
</template>

<script>
import PageNavbar from '@/components/Global/PageNavbar.vue';
import IpcrTable from '@/components/Global/IpcrTable.vue';
import FormAssign from '@/components/AssignDuties/FormAssign.vue';
export default {
    name: 'AssignedDuties',
    components: {
        PageNavbar,
        IpcrTable,
        FormAssign
    },

    methods: {
        requestOfficers() {
            this.$store.dispatch('getOfficers');
        },

        requestDuties() {
            this.$store.dispatch('getDuties');
        },

        requestAssignedDuties() {
            this.$store.dispatch('getAssignedDuties');
        }
    },

    mounted() {
        this.requestOfficers();
        this.requestDuties();
        this.requestAssignedDuties();
    }
}
</script>

<style scoped>
.row {
    padding-inline: 5rem;
}

</style>