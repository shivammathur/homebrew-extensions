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
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b22052c2c52b471db5aa08caeee3c9cefcd50807405315d1437a61e93a3e2961"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "474d3b626d9d4a5c68dfe81606aa48880371a212f942fe23d4bd0e1f765dbddb"
    sha256 cellar: :any_skip_relocation, monterey:       "1b3b28c5534e72d16e3a68044054d51c458f81fddd77c5d82a27b71441e8e021"
    sha256 cellar: :any_skip_relocation, big_sur:        "dde78d35b3b1cdc6bf1d43dbd6ab0f7aeee1a2e28274e9b0776d7dd09e179959"
    sha256 cellar: :any_skip_relocation, catalina:       "c41f828183adccf7b51f47a6941828be22ae144ee6f53b70b6fd2f2698f469a7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b6a02288fad5ee26ce027a27683c8bed624b22c1c8401d2eb50968ae24fed445"
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
