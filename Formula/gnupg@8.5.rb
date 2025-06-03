# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT85 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.3.tgz"
  sha256 "c1555e0c86a7f6d95141530761c1ecf3fe8dbf76e14727e6f885cd7e034bdfd2"
  head "https://github.com/php-gnupg/php-gnupg.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "6ee542a8284b26450956f89d3e9625acfff1a68eab9c23f495506048f8f37300"
    sha256 cellar: :any,                 arm64_sonoma:  "f8836297cd846afc5fec1797b2a8aea1c7a7299e30a7a776d7efe90254604db4"
    sha256 cellar: :any,                 arm64_ventura: "faeee109432ac2fd06270356adea2c8f9565b8460fc56b254aedbd88fe1b09c2"
    sha256 cellar: :any,                 ventura:       "f3e02387fb15dbb0dc884db14dbd68d132e9a5522f1a379bf36fe81007ba9285"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "37d628f7c2d605428a185bad55dc435a4d150cb8594d698c40f058b17ed9f9f2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8c2a1d8bdef8067e707692ce2ef16806b5ed16b14f73793d63b10de4ca306052"
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
