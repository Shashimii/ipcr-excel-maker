<template>
    <div class="row">
        <div class="col s12 m6 l4">
            <div class="card-panel yellow accent-2">
                <div class="card-content">
                    <div class="title">
                        <i class="medium material-icons">priority_high</i>
                        <h5>Assigned Officers:</h5>
                    </div>
                    <h5>{{ this.assignedDuties }}</h5>
                </div>
            </div>
        </div>
        <div class="col s12 m6 l4">
            <div class="card-panel cyan lighten-3">
                <div class="card-content">
                    <div class="title">
                        <i class="medium material-icons">person</i>
                        <h5>Officers:</h5>
                    </div>
                    <h5>{{ this.officers }}</h5>
                </div>
            </div>
        </div>
        <div class="col s12 m6 l4">
            <div class="card-panel deep-orange accent-2">
                <div class="card-content">
                    <div class="title">
                        <i class="medium material-icons">description</i>
                        <h5>Duties:</h5>
                    </div>
                    <h5>{{ this.duties }}</h5>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: 'CardCounter',

    computed: {
        officers() {
            return this.$store.getters.officers.length;
        },

        duties() {
            return this.$store.getters.duties.length;
        },

        assignedDuties() {
            return this.$store.getters.assignedDuties.length;
        }
    }
}
</script>

<style scoped>
.card-content {
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.title {
    display: flex;
    align-items: center;
    gap: 0.2rem;
}

</style>