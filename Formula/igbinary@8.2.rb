# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "70b3d8efbc4b5437c6a8f90714bc2c783db6d972adf58939f15318a18cc7fbd9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "572e89d9f154b4fd976b53bf3fcc8fd1f4774a1f6d75fc69b1c7014c089e086a"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "91b839682c202c7395b2a63c75fb803ea39df511c73b5f49d53f9dd2b9a07236"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "112a83e52ff7dd30e7bdffe4332ac8c5b295fc35794c4e700175b724815a7729"
    sha256 cellar: :any_skip_relocation, ventura:        "230b86beb86159315c0070101d2a39da16f939363139aa71476858d26f0198f9"
    sha256 cellar: :any_skip_relocation, monterey:       "e442eb000a549b6d1c5d5c083e4ea694ce9fc97b71d268db91c8e982e9c13fca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0dfc7b5c99db33db6790182af73d022cdca4024129c19f632b4ddab489184d86"
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
