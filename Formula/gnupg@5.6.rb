# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT56 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.1.tgz"
  sha256 "a9906f465ab2343cb2f3127ee209c72760238745c34878d9bbc1576486219252"
  head "https://github.com/php-gnupg/php-gnupg.git"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "05b767bf94fb0c2b34b3cfae48e4762ac8ae15cbd28e03f8d30b79734cb9d607"
    sha256 cellar: :any,                 arm64_ventura:  "4c9b9e821325fc9d21c0c5b09dde66b8b8867d6e87e2139d843cffe912e972b6"
    sha256 cellar: :any,                 arm64_monterey: "def2bf213e56866557b027633cc2929f4fd86b9a64a1aefc952f8f41d3e66246"
    sha256 cellar: :any,                 arm64_big_sur:  "6a04bd147dddb9a272548d434836fd2e2884eab3ba0bbd34784b3e67d4ca7f48"
    sha256 cellar: :any,                 ventura:        "5dd70e1f0451f7f186ad3d8bc9ecf17c610f3dc3f7ca50b92636490e8ea8fcd3"
    sha256 cellar: :any,                 big_sur:        "95416d09ded0afd26db0595b7f35d211bcf1d369c5bf2ecbde9cba5ea9dc796d"
    sha256 cellar: :any,                 catalina:       "db5795e33083c637c2b4c6a992d0f06da8831d002624bbd886476d259d248adb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "83c38b89a2475737769150c71816a37fdc60f45194f43461b54d198b90f3e1a6"
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
