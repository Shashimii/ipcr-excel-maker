<template>
    <PageNavbar></PageNavbar>
    <div v-if="preloaderVisible != true">
        <main>
            <div class="container">
                <CardCounter></CardCounter>
                <IpcrTable></IpcrTable>
            </div>
        </main>
        <div style="height: 5rem;"></div>
    </div>
    <div v-else class="preloader-container">
        <PreLoader></PreLoader>
    </div>
</template>

<script>
import PageNavbar from '@/components/Global/PageNavbar.vue';
import CardCounter from '@/components/Dashboard/CardCounter.vue';
import IpcrTable from '@/components/Global/IpcrTable.vue';
import PreLoader from '@/components/Global/PreLoader.vue';

export default {
    name: 'DashboardView',
    components: {
        PageNavbar,
        CardCounter,
        IpcrTable,
        PreLoader
    },

    data() {
        return {
            preloaderVisible: true,
        }
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

        setTimeout(() => {
            this.preloaderVisible = false
        }, 2000)
    }
}
</script>