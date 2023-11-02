RSpec.describe Tanakai::Base do
  describe '.running?' do
    pending
  end

  describe '.completed?' do
    pending
  end

  describe '.failed?' do
    pending
  end

  describe '.visits' do
    pending
  end

  describe '.items' do
    pending
  end

  describe '.update' do
    pending
  end

  describe '.add_event' do
    pending
  end

  describe '.name' do
    pending
  end

  describe '.engine' do
    pending
  end

  describe '.pipelines' do
    pending
  end

  describe '.start_urls' do
    pending
  end

  describe '.config' do
    pending
  end

  describe '.logger' do
    pending
  end

  describe '.crawl!' do
    pending
  end

  describe '.parse!' do
    pending
  end

  describe '#browser' do
    pending
  end

  describe '#request_to' do
    before do
      def subject.ping(*); end
      allow(subject).to receive(:browser).and_return(double(visit: true, current_response: :ok))
    end

    context 'when uri is missing' do
      let(:url) { 'http://example.com' }

      it  do
        expect { subject.request_to(:ping, url: nil, data: {}) }.to raise_error NoMethodError
      end
    end

    context 'when uri is valid' do
      context 'when uri scheme is http' do
        let(:url) { 'http://hello-world.com' }

        it { expect { subject.request_to(:ping, url: url, data: {}) }.not_to raise_error }
      end

      context 'when uri scheme is https' do
        let(:url) { 'https://hello-world.com' }

        it { expect { subject.request_to(:ping, url: url, data: {}) }.not_to raise_error }
      end

      context 'when uri scheme is ftp' do
        let(:url) { 'ftp://hello-world.com' }

        it { expect { subject.request_to(:ping, url: url, data: {}) }.to raise_error described_class::InvalidUrlError }
      end

      context 'when uri scheme is file' do
        let(:url) { 'file://hello-world.com' }

        it { expect { subject.request_to(:ping, url: url, data: {}) }.to raise_error described_class::InvalidUrlError }
      end

      context 'when uri scheme is missing' do
        let(:url) { '//hello-world.com' }

        it { expect { subject.request_to(:ping, url: url, data: {}) }.to raise_error described_class::InvalidUrlError }
      end
    end

    context 'when url is invalid' do
      let(:url) { '[]' }

      it { expect { subject.request_to(:ping, url: url, data: {}) }.to raise_error described_class::InvalidUrlError }
    end
  end

  describe '#console' do
    pending
  end

  describe '#storage' do
    pending
  end

  describe '#unique?' do
    pending
  end

  describe "#save_to" do
    let(:item) { double('item') }
    let(:path) { '/path/to/file' }
    let(:format) { :csv }
    let(:position) { true }
    let(:append) { false }

    context "when the Saver instance does not exist" do
      it "creates a new Saver instance and stores it in the @savers instance variable" do
        saver = instance_double(Tanakai::Base::Saver)
        expect(saver).to receive(:save).with(item)
        expect(Tanakai::Base::Saver).to receive(:new).with(path, format: format, position: position, append: append).and_return(saver)
        allow(described_class).to receive(:savers).and_return({})

        subject.save_to(path, item, format: format, position: position, append: append)

        expect(subject.instance_variable_get(:@savers)[path]).to eq(saver)
        expect(subject.class.savers[path]).to eq(nil)
      end

      context "when the with_info class method returns true" do
        it "stores the Saver instance in the savers class variable" do
          saver = instance_double(Tanakai::Base::Saver)
          expect(saver).to receive(:save).with(item)
          expect(subject).to receive(:with_info).and_return(true)
          expect(Tanakai::Base::Saver).to receive(:new).with(path, format: format, position: position, append: append).and_return(saver)
          allow(described_class).to receive(:savers).and_return({})

          subject.save_to(path, item, format: format, position: position, append: append)

          expect(subject.instance_variable_get(:@savers)[path]).to eq(saver)
          expect(subject.class.savers[path]).to eq(saver)
        end
      end
    end

    context "when the Saver instance already exists" do
      it "does not create a new Saver instance" do
        saver = instance_double(Tanakai::Base::Saver)
        expect(saver).to receive(:save).with(item)
        subject.instance_variable_set(:@savers, { path => saver })
        expect(Tanakai::Base::Saver).not_to receive(:new)
        subject.save_to(path, item, format: format, position: position, append: append)
      end
    end
  end

  describe '#add_event' do
    pending
  end
end
