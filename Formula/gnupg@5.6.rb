# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT56 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.4.tgz"
  sha256 "4d4a0980759bf259e4129ef02cb592bbeb103b4005e7b4bb6945d79488951a50"
  head "https://github.com/php-gnupg/php-gnupg.git"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "c9e383fe16eb8beecae9c4a2073c9cac1e009af77d01fcdf10822a5c19edce5b"
    sha256 cellar: :any,                 arm64_sonoma:  "f6fef87fcd61bfdb3889d1cdf6b818375dd98006504616dea619637724179315"
    sha256 cellar: :any,                 arm64_ventura: "c9ad9e85961f7b7cfe0ea913f7fdad0f1a750163bf80e2b7c16f06bac8b55d7e"
    sha256 cellar: :any,                 ventura:       "497b69c387eaf49377dd55721e47d839e935ff0666111616aa4475e93f565e8a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ed1205b7782c81f9c66efe9f9e8c05dcdb7823bf813f7e5fa855ba5d97196040"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "58aba8013074b06ae55316dd4d6790024ed0c1f729087c5a82d7e6df10973628"
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
