require_relative "../../lib/generator"

extend RSpec::Matchers

RSpec.configure do |config|
  config.filter_run_when_matching :focus
  config.order = :random
end

RSpec.describe Generator do
  subject { described_class.new }

  describe '#remove_unneeded_characters' do
    let(:input_string_1) { 'foo bar baz wibble fizzbuzz fizz buzz' }
    let(:input_string_2) { 'The quick brown fox jumps over the lazy dog' }
    let(:input_string_3) { '&AÁB  #{foo}$C DE\ÉF{*' }

    it 'removes whitespace and all characters not in the English alphabet' do
      expect(subject.remove_unneeded_characters(input_string_1))
        .to eq 'foobarbazwibblefizzbuzzfizzbuzz'
      expect(subject.remove_unneeded_characters(input_string_2))
        .to eq 'Thequickbrownfoxjumpsoverthelazydog'
      expect(subject.remove_unneeded_characters(input_string_3))
        .to eq 'ABfooCDEF'
    end
  end

  describe '#capitalize_word_starts' do
    let(:input_string_1) { 'foobarbazwibblefizzbuzzfizzbuzz' }
    let(:input_string_2) { 'Thequickbrownfoxjumpsoverthelazydog' }

    it 'capitalizes the first letter of each 10-letter word' do
      expect(subject.capitalize_word_starts(input_string_1))
        .to eq 'FoobarbazwIbblefizzbUzzfizzbuzZ'
      expect(subject.capitalize_word_starts(input_string_2))
        .to eq 'ThequickbrOwnfoxjumpSoverthelaZydog'
    end
  end

  describe '#upcase_certain_vowels', :aggregate_failures do
    let(:input_string_1) { 'FoobarbazwIbblefizzbUzzfizzbuzZ' }
    let(:input_string_2) { 'ThequickbrOwnfoxjumpSoverthelaZydog' }

    it 'upcases any vowel that is after at least two consonants and where the previous vowel is upcase' do
      expect(subject.upcase_certain_vowels(input_string_1))
        .to eq "FoobarbazwIbblEfizzbUzzfIzzbUzZ"
      expect(subject.upcase_certain_vowels(input_string_2))
        .to eq "ThequickbrOwnfOxjUmpSOverthelaZydog"
    end
  end

  describe '#generate' do
    let(:input_string_1) { 'foo bar baz wibble fizzbuzz fizz buzz' }
    let(:input_string_2) { 'The quick brown fox jumps over the lazy dog' }

    it 'generates the correct checksum', :aggregate_failures do
      expect(described_class.new(input_string_1).generate)
        .to eq "7-4-5-21-37"
      expect(described_class.new(input_string_2).generate)
        .to eq "9-4-3-24-43"
    end
  end
end
