require('./helper')

describe 'Strategy', ->
  beforeEach ->
    @board = new Board(10, 10)
    @strategy = new Strategy(@board)

  describe '#plan', ->
    it 'なんらかのアクションを返すこと', ->
      @board.set(new Point(8, 8), new Piece())
      assert.equal(@strategy.plan(new Point(3, 4)), 'down')

  describe '#_approach', ->
    it '目標に応じて正しい方向を返すこと', ->
      current = new Point(3, 3)
      assert.equal(@strategy._approach(current, new Point(3, 9)), 'down')
      assert.equal(@strategy._approach(current, new Point(3, 0)), 'up')
      assert.equal(@strategy._approach(current, new Point(9, 3)), 'right')
      assert.equal(@strategy._approach(current, new Point(0, 3)), 'left')
    it '障害物がある時、障害物の方向を差さないこと', ->
      @board.set(new Point(3, 4), new Piece())
      current = new Point(3, 3)
      assert.ok(@strategy._approach(current, new Point(3, 10)) != 'down')

  describe '#_nearest', ->
    it '一番近い Piece を返すこと', ->
      @board.set(new Point(1, 0), new Piece())
      @board.set(new Point(5, 5), new Piece())
      assert.ok(@strategy._nearest(new Point(3, 1)).equal(new Point(1, 0)))
      assert.ok(@strategy._nearest(new Point(4, 2)).equal(new Point(5, 5)))
    it '距離ゼロ(自分自身の位置)を返さないこと', ->
      @board.set(new Point(0, 0), new Piece())
      @board.set(new Point(9, 9), new Piece())
      assert.ok(not @strategy._nearest(new Point(0, 0)).equal(new Point(0, 0)))
