require 'spec_helper'

describe Percheron::Stack do

  let(:config) { Percheron::Config.new('./spec/fixtures/.percheron_valid.yml') }
  let(:stack_name) { 'debian_jessie' }

  let(:container_double) { double('Perheron::Container') }
  let(:containers) { { 'container_double' => container_double } }

  subject { described_class.new(config, stack_name) }

  describe '.all' do
    it 'returns an Hash of Stacks' do
      expect(described_class.all(config)).to be_a(Hash)
    end
  end

  describe '#container_configs' do
    it 'returns a Hash of Container objects' do
      expect(subject.container_configs).to be_a(Hash)
    end

    it 'is as Hash that contains two Hashie::Mash objects' do
      expect(subject.container_configs.keys.count).to eql(2)
      expect(subject.container_configs.values.collect(&:class).uniq.first).to eql(Hashie::Mash)
    end
  end

  describe '#containers' do
    it 'returns a Hash of Containers' do
      expect(subject.containers).to be_a(Hash)
    end

    it 'is as Hash that contains two Percheron::Container::Main objects' do
      expect(subject.containers.keys.count).to eql(2)
      expect(subject.containers.values.collect(&:class).uniq.first).to eql(Percheron::Container::Main)
    end
  end

  describe '#stop!' do
    before do
      expect(subject).to receive(:containers).and_return(containers)
    end

    it 'asks each Container to stop!' do
      expect(container_double).to receive(:stop!)
      subject.stop!
    end
  end

  describe '#start!' do
    before do
      expect(subject).to receive(:containers).and_return(containers)
    end

    it 'asks each Container to start!' do
      expect(container_double).to receive(:start!)
      subject.start!
    end
  end

  describe '#valid?' do
    it 'is true' do
      expect(subject.valid?).to be(true)
    end
  end

end
