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

  describe '#each', ->
    it '配置済み Character に対して繰り返しが行われること', ->
      @board.set(new Point(1, 1), new Character('B'))
      @board.each (character, point)->
        if character.name == 'A'
          assert.equal(point.x, 5)
          assert.equal(point.y, 5)
        else
          assert.equal(point.x, 1)
          assert.equal(point.y, 1)
    it 'board 上で操作が行われたとしても 2回以上同じ Character が繰り返しに出現しないこと', ->
      callCount = 0
      @board.each (character, p) =>
        callCount += 1
        @board.set(@position, null)
        @board.set(@position.down(), character)
      assert.equal(callCount, 1)

  describe '#isAble', ->
    it '有効なコマンドのとき true を返すこと', ->
      assert.ok(@board.isAble(@position, 'up'))
    it '枠外へ移動しようとする command に対して false を返すこと', ->
      corner = new Point(9, 9)
      assert.ok(not @board.isAble(corner, 'down'))
