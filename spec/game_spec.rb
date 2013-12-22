describe "GameOfLife" do
  describe "rules" do
    describe "alive cell" do
      subject { dies(neighbours) }

      context "with less then two neighbours" do
        let(:neighbours) { 1 }
        it { should be_true }
      end

      context "with more than three neighbours" do
        let(:neighbours) { 4 }
        it { should be_true }
      end

      context "survives with exactly two neighbours" do
        let(:neighbours) { 2 }
        it { should be_false }
      end

      context "survives with exactly three neighbours" do
        let(:neighbours) { 3 }
        it { should be_false }
      end
z
      def dies(neighbours)
        (neighbours < 2) || (neighbours > 3)
      end
    end
  end
end
