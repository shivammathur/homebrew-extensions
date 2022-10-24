# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT80 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.0.4.tgz"
  sha256 "1d65dec6d5d9be6fe331616615933a455dc008d8d1c132fefbd44a371221347f"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8a76c1984cc25fb938613c54bc35993a7f53da58365814606c8ac86b10d9d4b7"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "723dea7fcc6faf62baac47f6446c22ec07b07070155b6acc0e958c76b17c48f7"
    sha256 cellar: :any_skip_relocation, monterey:       "89e1cb90399a0538e87ca9f9932928a8c0a8e3196fd332be76cfa4576ea90d94"
    sha256 cellar: :any_skip_relocation, big_sur:        "b40ab634cc987bab5ba7e4d537852e77d21a51cf8e8fd43e5f095bfe2b9480a1"
    sha256 cellar: :any_skip_relocation, catalina:       "edf60b59cb6e72f3e3431b678b20d96a6770e431717eb5cc51e3143777718b21"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a427919bf66ba08bcffe3662c2da6215fbce84dc3cce2a4c8aac37f795579e37"
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
