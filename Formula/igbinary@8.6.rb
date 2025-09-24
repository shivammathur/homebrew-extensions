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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "a43867985db1dc7db0065e845c0ba289b99f34ddac01532cdfd305562b189022"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "40421eb571a4193b4ff5efd95230ffe4e5c860db7cf5d1bda8c30c9ccb2d3d1a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3d8c88d9b5def2b108b2f7a0b76c1cbc22076ef0772fc5d1e7ccfe345fa30ad5"
    sha256 cellar: :any_skip_relocation, sonoma:        "1b0fac77aa0406024c00efd7001fd83b230c04edf8edcdd7f8b8464cfbc76f85"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "008fc635259021152fc6e75600241faa023441573ea9865974da921c3e538b47"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "197be50476fe571035a65afb8dbef9a83c870d1f2499e18c0e930077a1c13412"
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
