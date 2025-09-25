# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT85 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.16.tar.gz"
  sha256 "941f1cf2ccbecdc1c221dbfae9213439d334be5d490a2f3da2be31e8a00b0cdb"
  revision 1
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "7e2ed132c40c96126799fac8350562d693d1059ab94a342ebf4a3202fee1300e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "27eb75834d9311ffcf9439f231d3bbedd950a069076150d5a60fe92cbbacdc81"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5b791ee3009a2321d5f8c8ad763b1b12fdaddfa0802e8fe0affde4d6ee43e48e"
    sha256 cellar: :any_skip_relocation, sonoma:        "f91424b35a755f17948a007e7803b0dd60995c9aafc4590fe2279f9a53c23680"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "07e9215af3dc24f9f933a5438a1ecafe48908869a8c62554c803cd0d89f49b4d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3a18780a3237c0110331b696e1cffde1534cdf36a7d137280bf9bd6a09db9d5f"
  end

  def install
    patch_spl_symbols
    safe_phpize
    inreplace "src/php7/php_igbinary.h", "ext/standard/php_smart_string.h", "Zend/zend_smart_string.h"
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
