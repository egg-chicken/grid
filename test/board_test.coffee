require('./helper')

describe 'Board', ->
  beforeEach ->
    @position = new Point(5,5)
    @piece = new Piece(name: 'A')
    @board = new Board(10,10)
    @board.set(@position, @piece)

  describe '#command', ->
    it '未知の操作が呼び出された時エラーとなること', ->
      command = => @board.command(@position, new Action('something'))
      assert.throws(command, /unknown action called/)
    it '何もしない操作が可能であること', ->
      command = => @board.command(@position, new Action('move', null))
      assert.doesNotThrow(command)

  describe '#_move', ->
    it '移動の前後で位置が変化すること', ->
      assert.equal(@board.get(@position), @piece)
      @board._move(@position, 'up')
      assert.equal(@board.get(@position), null)
      assert.equal(@board.get(@position.up()), @piece)

  describe '#_attack', ->
    it '対象の Piece#damage が実行されること', ->
      @board.set(@position.down(), new Piece())
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

  describe '#isMovable', ->
    it '有効なコマンドのとき true を返すこと', ->
      assert.ok(@board.isMovable(@position, 'up'))
    it '枠外へ移動しようとする command に対して false を返すこと', ->
      corner = new Point(9, 9)
      assert.ok(not @board.isMovable(corner, 'down'))
    it '既に Piece がある枠へ移動しようとする時 false を返すこと', ->
      assert.ok(not @board.isMovable(new Point(4, 5), 'right'))

  describe '#any', ->
    it '最後の要素が条件をみたすとき true を返すこと', ->
      @board.set(new Point(4,4), new Piece(teamCode: 1))
      @board.set(new Point(5,5), new Piece(teamCode: 2))
      @board.set(new Point(6,6), new Piece(teamCode: 3))
      alive = @board.any (piece, point) -> piece.teamCode == 3
      assert.ok(alive)

    it '一つも条件を満たす要素がないとき false を返すこと', ->
      @board.set(new Point(4,4), new Piece(teamCode: 1))
      @board.set(new Point(5,5), new Piece(teamCode: 2))
      @board.set(new Point(6,6), new Piece(teamCode: 3))
      alive = @board.any (piece, point) -> piece.teamCode == 4
      assert.ok(not alive)

  describe '#find', ->
    it '条件をみたす要素がないとき null を返すこと', ->
      assert.equal(@board.find((piece) -> piece.name == 'test'), null)

    it '条件をみたす要素があるとき その要素を返すこと', ->
      @piece = new Piece(name: "test")
      @board.set(new Point(9,9), @piece)
      assert.equal(@board.find((piece) -> piece.name == 'test'), @piece)
