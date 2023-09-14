# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT74 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.3.1.tgz"
  sha256 "3a3ecb0b46bc477ed09f8156545fe87858f0e31ea55ca6110cda4594c234fb3a"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "be6cc319dcf776a582006f3df228ef3d9ffdc5f19c79d419cf9a654410756433"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "e04c83a746e0be63ee46a584992222f85103056110ad4246edc041b98d9d1477"
    sha256 cellar: :any_skip_relocation, ventura:        "3aebe453505819995102dcab645e92cd616daed8d1decec06ff462c39471874d"
    sha256 cellar: :any_skip_relocation, monterey:       "016260ecf485da32486902d9e58d43aea2358fad3119c9ff8539fa7d61a8181f"
    sha256 cellar: :any_skip_relocation, big_sur:        "82a57289f258160b372a82638ce557fe8066474948a9cdbbbb4d85fe0d222aac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "21da6a31399579d874b0f19a64a8995f4df9ca6d31dcaa8ce60ecfebd1a883d3"
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
