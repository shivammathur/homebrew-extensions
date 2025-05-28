# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "98c446e21e8a5e8c9657366261871746e71a9b658abd77c49afe77cf79107263"
    sha256 cellar: :any,                 arm64_sonoma:  "63b36ead4d3d0fb2d58c1733c14f8b45365e99d49f964f50b45c996bc3ce69c1"
    sha256 cellar: :any,                 arm64_ventura: "a20ef05d2c5d0c8ff794933011e64e33da00a15aff389ede5324e094fb2ae735"
    sha256 cellar: :any,                 ventura:       "23dd32ad853091e3a2cbdde4e48d139348a2765fd4a703c98f5c23ebfb25f65e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "124653bdae383cf7b932fd904f39992bf5f43ca681769ccafa8160303406500c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aede1e53910b2970b863f57978c18f922a2f4ae80e6cef1730b0f7fceee8aa24"
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
