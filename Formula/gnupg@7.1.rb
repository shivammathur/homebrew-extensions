# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT71 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "d4d960fb61a006d27117e17f44270cf44e0e08c6c2db4ac8322a9555e9f85a8a"
    sha256 cellar: :any,                 arm64_sonoma:  "ec93a4ff6c7ad02c119c8c72c115ecfbad1ecd0d7e3dc94c428497be329dc12f"
    sha256 cellar: :any,                 arm64_ventura: "7dcf4119e546f0a9a33f5b654110b9a6e1a59d3ea0ab9a1a3547ac5b585f9252"
    sha256 cellar: :any,                 ventura:       "754a3699fe5f3e27f10ff6564a438097ff5a6330db69a910f372fd46a22eb32c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b8770cce7ce7985228007062c7e83e70d4c963e9924c5097f4218d10f82732e0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0ce0fe771c31e44868ef6ac74ed115443df89ff00a8460fe3c4053ddb77656dc"
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
