# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT72 < AbstractPhpExtension
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
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "26c9eb66cd7cdf41532e82c44db5c3315688f813255010f71e9b841322b66293"
    sha256 cellar: :any,                 arm64_ventura:  "734b2e14c300a21c3430872942116a36f0fd1cd3918a9593854b7f1c9b692c93"
    sha256 cellar: :any,                 arm64_monterey: "4cf19d28fc469d6234cb9ffb8dffeffe44d7c3e0bfbe9187754dd6daef701fab"
    sha256 cellar: :any,                 arm64_big_sur:  "efb0165550864e71b4b15541a99412d3425392716a7f31811a9f2635ea04ae3a"
    sha256 cellar: :any,                 ventura:        "8e59c1111eccbe1a31db6dbf4d5a272f192f7cf87076b7e938e67d1c3148fa03"
    sha256 cellar: :any,                 big_sur:        "f534d9c4da9577da315d6ba81cfea06223856511b120a75d3ef61083a79c9054"
    sha256 cellar: :any,                 catalina:       "9c7fb38f3c6b4d2d0c424a8e1b66e97a12b5c79642381445b962018b158518fe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0ee7fe3ce7b3802b18d69f07a990133d04ea8bfda52f868000bfa39d250e002c"
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
