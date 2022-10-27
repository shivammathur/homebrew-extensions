# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.0.5.tgz"
  sha256 "860e4fa67073a551c67b412ff0108306f01c5512b1e6c2192128c7ef02a3c83d"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "141dd235d94a3efc45ce2fe6c6bac2c62f3b8da3e0da12c4eba3dc7df19e2e5e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "48d2b3a71eb83b111e42c87e362b2c2550b399e70e9ff77e636e6829adc5681b"
    sha256 cellar: :any_skip_relocation, monterey:       "22a13b729e56f5fac34f1fc0faab50aeb91ca63e9f99cdf45db9845eb4a4806d"
    sha256 cellar: :any_skip_relocation, big_sur:        "f6bfc73e2605da54787b4d8586dd81b036ae5f6a81d5dfe22a70ace1114fafb6"
    sha256 cellar: :any_skip_relocation, catalina:       "e9d329578e5bb3acf9984b507315e715740273cd6ccb1e7ec52f433864735707"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0a2573faee0d5719a1123f590ea3e2a70fec42d85ca3bbe67b0d90120a31fac9"
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
