# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT85 < AbstractPhpExtension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.2.0.tgz"
  sha256 "9c3d2a0d9770916d86e2bc18dfe6513ad9b2bfe00f0d03c1531ef403bee38ebe"
  head "https://github.com/jbboehr/php-psr.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b4593806bb2dafdb3df8e530fa94350e68144d42cb8c93ecfdcada464a531b18"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7e7fbc401a7ed66a82ba2b01b915c599bc0068af6ad608fff8fb81270f8466ce"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a4a5ff3677d598eba758a9255ac97f31b5e9d5d9612d876660620b727b1a2d7c"
    sha256 cellar: :any_skip_relocation, ventura:       "9189c25ef4fcaad79a09e783f2c9a0e86a6dde65818b70712abeb8faa5e4c1a9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "89aa5d36e247ab335b594eeea7a6e2061ad6850f7f9d206043df4111540c61ee"
  end

  depends_on "pcre"

  def install
    Dir.chdir "psr-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-psr"
    system "make"
    prefix.install "modules/psr.so"
    write_config_file
  end
end
