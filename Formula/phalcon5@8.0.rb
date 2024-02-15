# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT80 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.6.1.tgz"
  sha256 "9842c0f75e89ae64cc33f1a2e517eaa014eeef47994d9a438bfa1ac00b6fdd54"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "7f36fda8e9a31bb99f94b1446e3cf963cc476577fde346ea13268ac83a0822e0"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "7bb0e2647ed0ba837d52fe9c4fa7d7edfe73304f378e2e4b37bda5fe674ace8f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b0ad675030ed9c47a9c9ee4e7ccb80dfe60acf6b5ca5bec0822ac410f1a9da8b"
    sha256 cellar: :any_skip_relocation, ventura:        "f91f504e362ae19c50e0559a8c8f95cf992d9337e6b0500979fa5b3b53eb9cde"
    sha256 cellar: :any_skip_relocation, monterey:       "52c28d3d18e96f90e95eb7175463fc3acdaaae8e22f5008508d5356bda793382"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5c6865cc21809919bc15c581f1cd36f77862ff367e39d422009072ed8d1ac39b"
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
