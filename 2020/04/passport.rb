# frozen_string_literal: true

# passport object for validating passports
class Passport
  def initialize(data)
    p_data = data.split(" ")
    passport_data = {}
    p_data.each do |pd|
      k, v = pd.split(":")
      passport_data[k] = v
    end
    @passport_data = passport_data
  end

  def required_fields_present?
    keys = @passport_data.keys
    keys.delete("cid")
    (%w[byr iyr eyr hgt hcl ecl pid] - keys).empty?
  end

  def valid?
    valid_birth_year? && valid_issue_year? && valid_expiration_year? && valid_height? &&
      valid_hair_color? && valid_eye_color? && valid_id?
  end

  private

  def valid_birth_year?
    @passport_data["byr"].to_i.between?(1920, 2002)
  end

  def valid_issue_year?
    @passport_data["iyr"].to_i.between?(2010, 2020)
  end

  def valid_expiration_year?
    @passport_data["eyr"].to_i.between?(2020, 2030)
  end

  def valid_height?
    height = @passport_data["hgt"].match(/(\d+)(cm|in)/)
    height && (height[2] == "cm" ? height[1].to_i.between?(150, 193) : height[1].to_i.between?(59, 76))
  end

  def valid_hair_color?
    @passport_data["hcl"].match?(/#[0-9a-f]{6}/)
  end

  def valid_eye_color?
    %w[amb blu brn gry grn hzl oth].include? @passport_data["ecl"]
  end

  def valid_id?
    @passport_data["pid"].match?(/^[0-9]{9}$/)
  end
end
