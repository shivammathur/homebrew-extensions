# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "214bd4e8c89051903360cff5d2e906666bc5b5e7e3ca31241eb47390b6fe5cac"
    sha256 cellar: :any,                 arm64_sonoma:  "5949c98753d425a2fc5f49c3c1fb745bba89b4335c962ee61435962a1b0e76f2"
    sha256 cellar: :any,                 arm64_ventura: "1c00429921831fe53aa97433924a8fa49117e0528ac5fe558f01327f4a168583"
    sha256 cellar: :any,                 ventura:       "d440d16c336b00386da8417e6863fa55b17dfd5cd9b0abcd7a978f007917ea94"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "30deb3f384459124b9424598e2e84f2c0b37d47ce2638523acc0ab4ff966e2bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4941ecd193b42d4e456d52203780c123c1a752217f7ce860f5387c334d3c0b14"
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
