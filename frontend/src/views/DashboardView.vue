<template>
    <PageNavbar></PageNavbar>
    <main>
        <div class="container">
            <CardCounter></CardCounter>
            <IpcrTable></IpcrTable>
        </div>
    </main>
    <div style="height: 5rem;"></div>
</template>

<script>
import PageNavbar from '@/components/Global/PageNavbar.vue';
import CardCounter from '@/components/Dashboard/CardCounter.vue';
import IpcrTable from '@/components/Global/IpcrTable.vue';

export default {
    name: 'DashboardView',
    components: {
        PageNavbar,
        CardCounter,
        IpcrTable
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