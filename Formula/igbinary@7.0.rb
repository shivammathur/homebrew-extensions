# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT70 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:    "00084218fe490655a2ffb5ed55732bb84387f6f01647978911204003a6f5bff3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "a76d624afc2f877d193f13ec982196800002f961fc83cb8dd89716770450562d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "50748df9fbbb468d18e03ae978bf28e3e07263b015869896114463fccab76e28"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "3c48b4ebf30ae850157896eb8707122aca4840935e519c8c2bbea6b8f30cdb1c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2c8410015492d88e9ef0d363e0f960e5dd073bf3664c3769337cf7e822812ff2"
    sha256 cellar: :any_skip_relocation, ventura:        "00b806105ce9a98741dedb8fac82c4e26cbb66ce403ecda5ee2291034b2946b4"
    sha256 cellar: :any_skip_relocation, monterey:       "7adb14929f9d73459cea5c16ca063a193f57664411e2d8e46c9bf24c48cbf804"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "800bdb1a29ef68c59b6ad1ac9055290f166402b3785cc5fdd858fbebf2d6177e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bf7c188a2f1c62b5cbd1e61f010a34287047c5eb39a18929de5051c5ff836929"
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
