# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "bd1475c545325198b152be6f44bc887cd0b604911a924384563f8c6acf47203e"
    sha256 cellar: :any,                 arm64_sonoma:  "f96b03bf6901780b2c117478b413e12868d15fe09066e4a3ab709d992236db34"
    sha256 cellar: :any,                 arm64_ventura: "ecb63827ec7cea6a31b91bdbd1b1ad6328cc3a56d6129f0a12f5f9637840886f"
    sha256 cellar: :any,                 ventura:       "eae9462ed881eed6870bad7189f9ef56c403e398c2162d26e56cccaaf4bd97b8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f147531fd31dbc5db05fee5f952f4ce88c1a0f192b031b1b7a478dda3cd9aa3e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "087cbd39cf6f7e51443fd03c5a95ad2eb30259c1fc92529f5ecddab7207f9a78"
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
