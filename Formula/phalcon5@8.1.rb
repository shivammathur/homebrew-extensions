# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.9.2.tgz"
  sha256 "c85b6739e4e6b0816c4f9b4e6f7328d614d63b4f553641732b918df54fe13409"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1f611fcb37878ddbaf73f5ef2b0769382da24775baa480651a183ba713777656"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4a1e5d907c71c0b2f294f0acc8fff3bf37241ac3d4d0fc0ac528ad43d31334b3"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "01a3fd08304b5afbd12701129ef5efa6924a8b78302a432c809ba0f21ba4250f"
    sha256 cellar: :any_skip_relocation, ventura:       "3f06c1d2c0878c979403ab350262fa091085078561a8793c04efe3cfc2cd35d5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4db28073839cb6dccaad58ddb554b3345314e1c1e6caad3ffd7e81dc6b940e22"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
