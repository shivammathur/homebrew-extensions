# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT83 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.1.tgz"
  sha256 "a9906f465ab2343cb2f3127ee209c72760238745c34878d9bbc1576486219252"
  head "https://github.com/php-gnupg/php-gnupg.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "8d390d95802974d213d2003d44310a5dbe81f4195af96cddf2db4298aa2da131"
    sha256 cellar: :any,                 arm64_big_sur:  "62f014c451d34af6ab06c82b0edafb3b28b9ecac0367465b362d7c6b6f36923e"
    sha256 cellar: :any,                 ventura:        "864320ce5d4acadfac3ed81b4beada57a49de07857376d569eb1ea046d48c3a9"
    sha256 cellar: :any,                 monterey:       "ac8f6c95799b454063b553d19e3fb06a5b45b82ba6627936a004358814fce21b"
    sha256 cellar: :any,                 big_sur:        "3c46bb282657ff200410f65f7bd52abe069402200f2c258a8120c550e41dbaa6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a80fc158f3894e322b118423b9d39fc7f562a39d4dc7e29841359c71011c9d97"
  end

  depends_on "gpgme"

  def install
    args = %W[
      --with-gnupg=#{Formula["gpgme"].opt_prefix}
    ]
    Dir.chdir "gnupg-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
