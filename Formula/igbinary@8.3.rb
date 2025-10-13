# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT83 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.16.tar.gz"
  sha256 "941f1cf2ccbecdc1c221dbfae9213439d334be5d490a2f3da2be31e8a00b0cdb"
  head "https://github.com/igbinary/igbinary.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url :homepage
    strategy :git do |tags|
      semver_tags = tags.map(&:to_s).grep(/^v?\d+(\.\d+)+$/)
      semver_tags.max_by { |tag| Version.new(tag.delete_prefix("v")) }
    end
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:    "c5651cf40e676c8bb33cf20ad7a9b61b2b91c3a9949dab5d5edbf13ccd911706"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "77ac37150dfb2fe674c365c8ac1f16c3a5e9510719139fad9087100569df1d1a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "a173960b2297bd2b900da12cdd44094a6451628863d2dae4ea44ced952fa62bf"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "11dddec48965c54e77053f13c3beabe943aa4906239f4d1325e21e34ddae82d0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1262fea9c093b6ec6cd45ec6772f6aa75dcf85ba4a7ce1f3c4d2dcdd40c047ef"
    sha256 cellar: :any_skip_relocation, sonoma:         "6edc29985032a7d978be5efe4d44494bb01153a2c22999c7802724e4c744f000"
    sha256 cellar: :any_skip_relocation, ventura:        "84b05b601f7f0934201ffccbcdb77897bd66eb46312555f10f49ae804505f1e3"
    sha256 cellar: :any_skip_relocation, monterey:       "f0cd65c6730b15434b4e641fc33c602e8a0d50bb43ea5a4e6838cc50fd67e995"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "5d442b57397249369cc1afe0ed4d8f6b48a956e2997e06d7776bc4d3a33035d8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "21a3e0b32c21d689e9f6451936d747ab44bf67c1df40b4e418ffe47e3aa32c83"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
