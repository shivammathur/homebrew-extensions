# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT70 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.2.tgz"
  sha256 "ad57aa23b3aef550fa4deddd003ff5322b886d55a67d1b020f5682ab829809fd"
  head "https://github.com/php-gnupg/php-gnupg.git"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "0b2e7eb05c9b36dc222cdddf9e8c5fd8bff5c04f60068c6b6ca4a439fcba1322"
    sha256 cellar: :any,                 arm64_ventura:  "fa7550bc806095b7e674d5653a2132b4d9f77cffefb9edf1697950f5b0b86e73"
    sha256 cellar: :any,                 arm64_monterey: "b8669769263ac5e24696a3a45e2d306878e792885969d2a582dc715725f35fc5"
    sha256 cellar: :any,                 arm64_big_sur:  "df5d5df5e40c858e9ff732dd1ded0aafb4f0401b4a35229bf0dfc3b12bf028f0"
    sha256 cellar: :any,                 ventura:        "61a6c8fd1f73115df7e06e72f32ad89e965b88668c853af23497d7bdfeed346d"
    sha256 cellar: :any,                 big_sur:        "7e8577c75d37bb162b3505bcb55385edb673bddd285bad325b2be90f601a32cc"
    sha256 cellar: :any,                 catalina:       "e3b3f1a7d3b3b157aa82acc63554f4a5cad4d3400585d7c75312851733992616"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7a37f52ead0e6cd6ce7f2e013bf06bdf7d0d4083f4f3ac2402b53548393f4d6d"
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
