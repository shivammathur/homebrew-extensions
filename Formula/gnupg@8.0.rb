# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT80 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.3.tgz"
  sha256 "c1555e0c86a7f6d95141530761c1ecf3fe8dbf76e14727e6f885cd7e034bdfd2"
  head "https://github.com/php-gnupg/php-gnupg.git"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "83c602f7022d84c57b6aa6a36d7fe14c2de82b520126e40d948a123f7e503be3"
    sha256 cellar: :any,                 arm64_sonoma:  "3ceb1afc73a0a574f1ed72a6b45afc5c3f442e077e3207f8b40d0eb7cb51887f"
    sha256 cellar: :any,                 arm64_ventura: "2cf604cd55e6cb9a9f3d289f42c757c6a6d57a9f87d299dc7c4c3e0489cdcd0b"
    sha256 cellar: :any,                 ventura:       "75551d2191e6a621d3d2c82e56a3df399c638e6910b81bd229fb0ab6197d471d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1d484be4f6cdf2df8175ac3c94b28ec85cee84c3d3190ae2c3fa36c3624235a8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "78ea6b2e15c05bbc50d2742c3678e4c61c66aabd86d877961ee5f5aecc732a85"
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
