<template>
    <PageNavbar></PageNavbar>
    <div v-if="preloaderVisible != true">
        <main>
            <div class="container">
                <AssignedOfficers></AssignedOfficers>
            </div>
        </main>
        <div style="height: 5rem;"></div>
    </div>
    <div v-else class="preloader-container">
        <PreLoader></PreLoader>
    </div>
</template>

<script>
import PageNavbar from '@/components/Global/PageNavbar.vue'
import PreLoader from '@/components/Global/PreLoader.vue';
import AssignedOfficers from '@/components/OfficerDuties/AssignedOfficers.vue';
export default {
    name: 'OfficerDutiesView',
    components: {
        PageNavbar,
        AssignedOfficers,
        PreLoader
    },

    data() {
        return {
            preloaderVisible: true,
        }
    },

    mounted() {
        this.$store.dispatch('getAssignedOfficers');

        setTimeout(() => {
            this.preloaderVisible = false
        }, 2000)
    }
}
</script>