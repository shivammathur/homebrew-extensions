# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT80 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.16.tar.gz"
  sha256 "941f1cf2ccbecdc1c221dbfae9213439d334be5d490a2f3da2be31e8a00b0cdb"
  head "https://github.com/igbinary/igbinary.git"
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:    "d0f94742b1fbc16fd070592b3d0b345a1fee7cf7323223d195b7459db23cf159"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "baf1562ca9b7d49a3eb3a523b0253b88d7d94d3939c16606a9dbe12e5f63a151"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "65d76ec312b9d39b2c022623ddf1a8602ebf3c0ceccc1b44b43c65f770d7adc0"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "78c3f90a63cadec5591de8e441156a8f39ce8b471a42a322fe7032d557a53590"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d2c428df1a7bce2c1ec50c025806ec398c947523c8a55f5d031048f1481e843b"
    sha256 cellar: :any_skip_relocation, ventura:        "bd82ba6f8d5cebe3d75242afb9ba4543c82270bba231649d2bdb5dfc7d80141b"
    sha256 cellar: :any_skip_relocation, monterey:       "d6ee12166a885f954f36f6b626d158dc7ddfff240fe8d5663e1e44764d68769a"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "79ea96b164d1509ab8946ad09c8eb82d32eb21b6f88fdb68f43094992efd3eb7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fc41a719d06e6757ba1f90cb12ae3ad8e514ed5037826b848a61f000c33d4d4a"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
