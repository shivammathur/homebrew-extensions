# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT70 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "df5d5df5e40c858e9ff732dd1ded0aafb4f0401b4a35229bf0dfc3b12bf028f0"
    sha256 cellar: :any,                 big_sur:       "7e8577c75d37bb162b3505bcb55385edb673bddd285bad325b2be90f601a32cc"
    sha256 cellar: :any,                 catalina:      "e3b3f1a7d3b3b157aa82acc63554f4a5cad4d3400585d7c75312851733992616"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7a37f52ead0e6cd6ce7f2e013bf06bdf7d0d4083f4f3ac2402b53548393f4d6d"
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
