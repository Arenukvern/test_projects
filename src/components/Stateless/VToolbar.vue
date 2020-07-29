<template lang="pug">
.toolbar
  slot  
</template>
<script lang="ts">
import { Component, Prop, Vue } from 'vue-property-decorator'

@Component({})
export default class VToolbar extends Vue {}
</script>
