# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT80 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.0.0RC4.tgz"
  sha256 "31d3c2051dab6ff2cf08957b505bcc34ba4278e3004b335e03b8a2182ee01065"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "42db48588444c0712b2c94c2ace661c09cd03482bb25432a9370ca144ce83bcf"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f81a31d6a463aae1abc7fb47f6df028f5d52a32ff33e1285602011a14abf0961"
    sha256 cellar: :any_skip_relocation, monterey:       "07b861068d87d57bdde848ddc0d9d11a974ab13f9ed350cb627f2ebe4b6b7a01"
    sha256 cellar: :any_skip_relocation, big_sur:        "a9f76611d90d1493dc5736e38b40854271f082a56d1f88942e515e1e90aeae27"
    sha256 cellar: :any_skip_relocation, catalina:       "35ee560257d5c0e58b5fa0dcd4bf38b0e8cfb0f69e21706723dc097338ec1130"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7c525daf8260ea56685ed6b35cc887e68acda755086a6323b4882f3ce8353fcc"
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
