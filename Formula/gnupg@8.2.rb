# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT82 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.1.tgz"
  sha256 "a9906f465ab2343cb2f3127ee209c72760238745c34878d9bbc1576486219252"
  head "https://github.com/php-gnupg/php-gnupg.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "d2d4996ccddd2c9e44cc1853621b08b4948be03fef8fc4f7cf00db0bb69a58b9"
    sha256 cellar: :any,                 big_sur:       "d6730d90dc6b48bc1576d59f3b12293c8bf0e9bd1636fe9ce6f0a476d014d928"
    sha256 cellar: :any,                 catalina:      "eb3839d23126647481d454aecd4e0bb42d1f0aafc432f46842fb468e8fe85cc1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e52d3ab0bac81e3d7b2cf242e6ea3db48fc58d82fb1efcf824546843bc6e40b0"
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
