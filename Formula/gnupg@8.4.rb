# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "d71f59ffe5fe2b7ddd55bdf3f166ff75731b93b67d96dcec842c9031e277ae9d"
    sha256 cellar: :any,                 arm64_sonoma:  "ff71e0f144223231d88506f4458371e752c528e9e70cf16608c74e3956124f74"
    sha256 cellar: :any,                 arm64_ventura: "b7132fadae9b73196f33b90268bc0726b6ae27a69d65e796f2e20182e31e8748"
    sha256 cellar: :any,                 ventura:       "311b06ca19fb6597a8c7c0bb3319ab574e6560a3f2854e903c2fa36dccbd36fa"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "496ea40af772c467fc26468cb8e58340ca2f3b40d19b9a5c2b925376347a6668"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "36e2c2e76192dcf9d8267dc7f353ba02f4d4ad20f261b04cc237a8682e5d8886"
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
