require('./helper')

describe 'Board', ->
  beforeEach ->
    @position = new Point(5,5)
    @piece = new Piece(name: 'A')
    @board = new Board(10,10)
    @board.set(@position, @piece)

  describe '#command', ->
    it '未知の操作が呼び出された時エラーとなること', ->
      command = => @board.command(@position, new Action(name: 'something'))
      assert.throws(command, /unknown action called/)

  describe '#_move', ->
    it '移動の前後で位置が変化すること', ->
      assert.equal(@board.get(@position), @piece)
      @board._move(@position, 'up')
      assert.equal(@board.get(@position), null)
      assert.equal(@board.get(@position.up()), @piece)

  describe '#_attack', ->
    it '対象の Piece#damage が実行されること', ->
      @board._attack(@position.down(), 'up')
      assert.ok(@piece.isDead())

  describe '#each', ->
    beforeEach ->
      @board.set(new Point(1, 1), new Piece(name: 'B'))
    it '配置済み Piece に対して繰り返しが行われること', ->
      @board.each (piece, p)->
        a = (piece.name == 'A' && p.equal(new Point(5, 5)))
        b = (piece.name == 'B' && p.equal(new Point(1, 1)))
        assert.ok(a || b)
    it 'board 上で操作が行われたとしても 2回以上同じ Piece が繰り返しに出現しないこと', ->
      callCount = 0
      @board.each (piece, p) =>
        callCount += 1
        @board.set(@position, null)
        @board.set(@position.down(), piece)
      assert.equal(callCount, 1)
    it '繰り返しの最終に死んだ Piece は出現しないこと', ->
      @board.each (piece, p) =>
        @piece.dead = true
        assert.ok(piece.isAlive())

  describe '#isMovable', ->
    it '有効なコマンドのとき true を返すこと', ->
      assert.ok(@board.isMovable(@position, 'up'))
    it '枠外へ移動しようとする command に対して false を返すこと', ->
      corner = new Point(9, 9)
      assert.ok(not @board.isMovable(corner, 'down'))
    it '既に Piece がある枠へ移動しようとする時 false を返すこと', ->
      assert.ok(not @board.isMovable(new Point(4, 5), 'right'))
