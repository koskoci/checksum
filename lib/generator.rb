class Generator
  def initialize(input_string = nil)
    @input_string = input_string
  end

  def generate
    @count_of_original_words = input_string.split.count
    @length_of_original_string = input_string.length
    string = remove_unneeded_characters(input_string)
    string = capitalize_word_starts(string)
    string = upcase_certain_vowels(string)
    calculate_checksum(string)
  end

  def remove_unneeded_characters(string)
    string.gsub(/[^a-z]/i, '')
  end

  def capitalize_word_starts(string)
    string
      .split('')
      .map.with_index do |e, i|
        i % 10 == 0 ? e.upcase : e
      end.join
  end

  def upcase_certain_vowels(string)
    string
      .gsub(/[AEIOU][^aeiouAEIOU]{2,}\K[aeiou].*/) do |m|
        upcase_certain_vowels(upcase_first_letter(m))
      end
  end

  def calculate_checksum(string)
    count_of_newly_created_words = string.scan(/.{1,10}/).count
    count_of_upper_case_vowels = string.scan(/[AEIOU]/).count
    count_of_consonants = string.scan(/[^aeiou]/i).count

    [
      count_of_original_words,
      count_of_newly_created_words,
      count_of_upper_case_vowels,
      count_of_consonants,
      length_of_original_string
    ].join("-")
  end

  private

  attr_reader :input_string, :count_of_original_words, :length_of_original_string

  def upcase_first_letter(string)
    string.split('').map.with_index { |e, i| i == 0 ? e.upcase : e }.join
  end
end