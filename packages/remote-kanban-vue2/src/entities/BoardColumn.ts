import { BoardColumns } from '@/constants/BoardColumns'
import { Colors } from '@/constants/Colors'

export class BoardColumn {
  constructor(
    public id: string = BoardColumns[0],
    public color: Colors = Colors.blue,
    public name: string = ''
  ) {}
}
