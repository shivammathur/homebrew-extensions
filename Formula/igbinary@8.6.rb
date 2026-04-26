# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT86 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f0f2165c2c7ff8a73f8e69eb68c7d84a34df8e0ad161beb10e121da3c8742d2f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b3d14fabc0e7d76a5b26d9c257049a465de6c60e275d11feebd984f111f42a5c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "25b433a12e2aca7d6f656562fc6b77a9ba4d0f869d367b9552818c76ad3af7f5"
    sha256 cellar: :any_skip_relocation, sonoma:        "31dc1641e34e6d152b24300cfd62da15eb05027d2353b6c5cee9a2b106c86006"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9d9f84306f593a1f7dd7c1f292c64ce2fe4f345f5fb3eee05b1613a4f56e7bd1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ad04d9f9da11edd2006ae6118f9d554ca1afdc13766b74faef99b9a0498bb696"
  end

  def install
    patch_spl_symbols
    safe_phpize
    inreplace "src/php7/php_igbinary.h", "ext/standard/php_smart_string.h", "Zend/zend_smart_string.h"
    inreplace "src/php7/igbinary.c", "zval_dtor", "zval_ptr_dtor_nogc"
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
