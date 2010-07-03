require 'spec_helper'

describe Bankr::Scrapers::LaCaixa do

  subject { Bankr::Scrapers::LaCaixa.new(:login => VALID_DATA["login"], :password => VALID_DATA["password"])}

  it { should respond_to(:log_in) }

  describe "#log_in", :webmock => false do

    it "successfully logs in with valid authentication data" do
      pending
      expect {
        subject.log_in
      }.to change(subject, :logged_in?).from(false).to(true)
    end

    it "fails to log in and raises and exception with invalid authentication data" do
      pending
      scraper = Bankr::Scrapers::LaCaixa.new(:login => '33358924',
                                             :password => '3333') 
      expect {
        scraper.log_in
      }.to raise_error(Bankr::Scrapers::CouldNotLogInException)
      scraper.logged_in?.should be_false
    end

  end

  context "public getters with cache", :webmock => true do

    it { should respond_to(:accounts) }

    describe "#accounts" do

      it "fetches the accounts and caches them" do
        # The first time returns 3 accounts, the second time only 2
        subject.stub(:_accounts).and_return([double("account1"),double("account2"),double("account3")],
                                            [double("account1"),double("account2")])
        subject.should have(3).accounts
        subject.should have(3).accounts, "#accounts is not caching the accounts"
      end

    end

  end

  context "public getters without cache", :webmock => true do

    it { should respond_to(:_accounts) }

    describe "#_accounts" do

      it "fetches the accounts" do
        stub_request(:get, account_list).to_return(:body => fixture(:la_caixa, :account_list), :headers => { 'Content-Type' => 'text/html' })
        subject.should have(3)._accounts
      end

    end

  end

end
