# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "42657bfb2d376e320d54de290107717e44975b8629002263be70f0c772cbf1c1"
    sha256 cellar: :any,                 arm64_sonoma:  "be61c67bad433d1ef21f10a3c4c48098b7c475ecdf83860f92b2c045d4f3a64c"
    sha256 cellar: :any,                 arm64_ventura: "a0f555d8223f4474c31ef56a303d4a88cbd0e4fbd01824eb6756a89299ea9668"
    sha256 cellar: :any,                 ventura:       "bd9e9579d4c5f3d219199447e54a7e129332c01f738afb9e097dbe6701e41f50"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "eb75103e6ac8684ca00cf3795abee244dfe7a003df510d9e51da5139faf025ab"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3e0efc3ad5de21f3bda3a7670936949d02f190a1237a7d9e1b18f7d98a5f27b3"
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
