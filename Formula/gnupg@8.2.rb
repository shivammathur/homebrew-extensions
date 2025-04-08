# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "a0ee682522124e0696270b723eef957da0cc421f421f33206060cbf6a2cfb4d5"
    sha256 cellar: :any,                 arm64_sonoma:  "d6c981ffb7dcbb12970d3bd2cc7ae1026a4d9de5e026968fd48251f2c4eec082"
    sha256 cellar: :any,                 arm64_ventura: "743e9ea0952325f6a9b6b050a8c672d280e08a278e4b1438e1158c1a8db8c435"
    sha256 cellar: :any,                 ventura:       "c0a0ec2aaf0f465095e987d190dfca20c9754648f44abb2475c02e25df208fcf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4555a2c6ad6bf5102ecee7ce32d98de3c64ca9ce385492560f71f34f45ac2e16"
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
