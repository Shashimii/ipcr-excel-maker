<template>
    <PageNavbar></PageNavbar>
    <div v-if="preloaderVisible != true">
        <div class="row">
            <div class="col s12 m12 l5">
                <FormAssign></FormAssign>
            </div>
            <div class="col s12 m12 l7">
                <IpcrTable></IpcrTable>
            </div>
        </div>
        <div style="height: 5rem;"></div>
    </div>
    <div v-else class="preloader-container">
        <PreLoader></PreLoader>
    </div>
</template>

<script>
import PageNavbar from '@/components/Global/PageNavbar.vue';
import IpcrTable from '@/components/Global/IpcrTable.vue';
import FormAssign from '@/components/AssignDuties/FormAssign.vue';
import PreLoader from '@/components/Global/PreLoader.vue';
export default {
    name: 'AssignedDuties',
    components: {
        PageNavbar,
        IpcrTable,
        FormAssign,
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

<style scoped>
.row {
    padding-inline: 5rem;
}

</style>