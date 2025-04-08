# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT56 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "38ec94d11a51f958543118cb6084a566fdf8a3be2a7cf9d5a4df6dc0b90c62de"
    sha256 cellar: :any,                 arm64_sonoma:  "2f1a5fc84d252f1a951bbdda767b7bc543ed7c153302f01cbf43187be5981816"
    sha256 cellar: :any,                 arm64_ventura: "68cdc3fa1dddd862ed2925b6f50788105419abafdab5f4bd98c4abb5b079d177"
    sha256 cellar: :any,                 ventura:       "3cb33d2eb4a61a98a494a93cf15419da461ddb98ee7803e18d924291612f3823"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c98ffc42b16b23743ac32a1b75286bd93c76468e6f20ecbd0dd4a6d5ca244e0e"
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
