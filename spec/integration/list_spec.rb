require 'integration/spec_helper'

describe 'percheron' do
  before do
    $logger = double('Logger').as_null_object
    $metastore = double('Metastore').as_null_object
  end

  before(:all) do
    Dir.chdir('./spec/integration/support')
    cleanup!
  end

  after do
    $logger = $metastore = nil
    cleanup!
  end

  describe 'list' do
    it 'displays a terminal table' do
      expect { Percheron::Commands::List.run(Dir.pwd, %w(percheron-test)) }.to output(%r{base      |    | n/a}).to_stdout
    end
  end
end
