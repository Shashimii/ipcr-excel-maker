<template>
    <PageNavbar></PageNavbar>
    <div v-if="preloaderVisible != true">
        <div class="container">
            <div class="row">
                <div class="col s12 m12 l3">
                    <OptionsPanel></OptionsPanel>
                </div>
                <div class="col s12 m12 l9">
                    <RegisteredList></RegisteredList>
                </div>
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
import PreLoader from '@/components/Global/PreLoader.vue';
import OptionsPanel from '@/components/Settings/OptionsPanel.vue';
import RegisteredList from '@/components/Settings/RegisteredList.vue';
export default {
    name: 'SettingsView',
    components: {
        PageNavbar,
        RegisteredList,
        OptionsPanel,
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