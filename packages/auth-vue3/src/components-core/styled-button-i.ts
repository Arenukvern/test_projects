import { SetupContext } from 'vue'

export enum StyledButtonsEmit {
  click = 'click',
}
export const styledButtonEmits = [StyledButtonsEmit.click]
export const styledButtonClick = <
  TEmitOptions extends StyledButtonsEmit[],
  TSetupContext extends SetupContext<TEmitOptions>
>({
  context,
}: {
  context: TSetupContext
}) => () => context.emit(StyledButtonsEmit.click)
