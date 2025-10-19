# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT74 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.4.tgz"
  sha256 "4d4a0980759bf259e4129ef02cb592bbeb103b4005e7b4bb6945d79488951a50"
  head "https://github.com/php-gnupg/php-gnupg.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "c50dc5eaa788ef246781b1dbe32e5b7f200ebf93bb8e82f2bc71ca56e5df9b22"
    sha256 cellar: :any,                 arm64_sonoma:  "d1038282a71ebbe48474b5b4a73ab10ef13f0f9b4719f63c489224f87b354365"
    sha256 cellar: :any,                 arm64_ventura: "6a9725ff065e5103c5e338aaafa2c0495615073ed2b234955ce88d50a3851aa6"
    sha256 cellar: :any,                 sonoma:        "0a873c24ae6376afc9aef4a9ad5d90ae4f00ac8ad780ffb671e7e9d176d6e8ed"
    sha256 cellar: :any,                 ventura:       "58cf503b9d9cd2091393f8d080f392f73cd3e8ecb3ea100a26181522c1229b3a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fede9850a5e931418b9233ee3956c7b1053da31e25e8820b67f02751b960f225"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1ee5bd12b8336475586eca7d536d14d4de7aeffcaa06a961f19ba019b64bdb3f"
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
