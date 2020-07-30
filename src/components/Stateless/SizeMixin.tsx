import { ComponentSizes } from '@/constants/ComponentSizes'
import { Component, Prop, Vue } from 'vue-property-decorator'
@Component({})
export default class SizeMixin extends Vue {
  @Prop({ required: false, default: false }) readonly small: boolean
  @Prop({ required: false, default: true }) readonly medium: boolean
  get size() {
    if (this.small) return ComponentSizes.small
    if (this.medium) return ComponentSizes.medium
    return ComponentSizes.medium
  }
}
