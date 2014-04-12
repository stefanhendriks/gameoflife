require 'cell'

describe "Cell evolve" do
  subject { Cell.evolve(alive, neighbours) }

  describe "dead cell" do
    let(:alive) { false }

    context "revives with exactly 3 neighbours" do
      let(:neighbours) { 3 }
      it { should be_true }
    end

    context "remains dead with more than 3 neighbours" do
      let(:neighbours) { 4 }
      it { should be_false }
    end

    context "remains dead with less than 2 neighbours" do
      let(:neighbours) { 2 }
      it { should be_false }
    end
  end

  describe "alive cell" do
    let(:alive) { true }

    context "dies with less then two neighbours" do
      let(:neighbours) { 1 }
      it { should be_false }
    end

    context "dies with more than three neighbours" do
      let(:neighbours) { 4 }
      it { should be_false }
    end

    context "survives with exactly two neighbours" do
      let(:neighbours) { 2 }
      it { should be_true }
    end

    context "survives with exactly three neighbours" do
      let(:neighbours) { 3 }
      it { should be_true }
    end
  end
end
