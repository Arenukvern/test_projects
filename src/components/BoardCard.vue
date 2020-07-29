<template lang="pug">
.board__card
  .board__card-header
    .board__card-header.--has-accent id:
    .board__card-header {{id}}
  .board__card-body
    
</template>
<script lang="ts">
import { Vue, Component, Prop } from 'vue-property-decorator'

@Component({})
export default class BoardCardComponent extends Vue {
  @Prop({ required: true }) readonly id: string
}
</script>
