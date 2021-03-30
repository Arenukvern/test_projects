<template lang="pug">
.toolbar
  slot  
</template>
<script lang="ts">
import { Component, Vue } from 'vue-property-decorator'

@Component({})
export default class VToolbar extends Vue {}
</script>
