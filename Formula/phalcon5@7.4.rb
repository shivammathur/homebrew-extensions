# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT74 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.1.4.tgz"
  sha256 "313aeb79611587776d0f56dc7ee0d713ebbb19abb4c79b38f1cb1145913ea374"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3a9a8d2345eada4f9f72fd4e89e4823baaedbe9c3353458b827b69e53758e4db"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "ecc39e9c502c515eb0019532ed014bee2e5b8a81849cceba851325bea85cea90"
    sha256 cellar: :any_skip_relocation, monterey:       "ba06454abc306a6e320f6d110340520ee36d6da26954051d0041fbfb341aab9f"
    sha256 cellar: :any_skip_relocation, big_sur:        "f79c5ef49004d9d34155035f37da7018cb76c21cf82678e0ca1b8c73e49655fe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d649515c96b18b7f34f51fa500f02af7b8455c85945ff79542bf06c06f3cb71d"
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
