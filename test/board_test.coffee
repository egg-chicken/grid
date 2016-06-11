require('./helper')

describe 'Board', ->
  beforeEach ->
    @position = new Point(5,5)
    @character = new Character('A')
    @board = new Board(10,10)
    @board.set(@position, @character)

  describe '#command', ->
    it '未知の操作が呼び出された時エラーとなること', ->
      command = => @board.command(@position, 'something')
      assert.throws(command, /unknown action called/)

  describe '#_move', ->
    it '移動の前後で位置が変化すること', ->
      assert.equal(@board.get(@position), @character)
      @board._move(@position, 'up')
      assert.equal(@board.get(@position), null)
      assert.equal(@board.get(@position.up()), @character)
