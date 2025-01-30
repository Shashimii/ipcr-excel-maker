<template>
    <PageNavbar></PageNavbar>
    <main>
        <div class="container">
            <AssignedOfficers></AssignedOfficers>
        </div>
    </main>
    <div style="height: 5rem;"></div>
</template>

<script>
import PageNavbar from '@/components/Global/PageNavbar.vue'
import AssignedOfficers from '@/components/OfficerDuties/AssignedOfficers.vue';
export default {
    name: 'OfficerDutiesView',
    components: {
        PageNavbar,
        AssignedOfficers
    },

    mounted() {
        this.$store.dispatch('getAssignedOfficers');
    }
}
</script>