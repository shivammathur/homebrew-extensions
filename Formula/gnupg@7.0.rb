# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT70 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "e0be1365332e1e71d186293f499ad2e7c4266d5feb8c39926172565e687411b1"
    sha256 cellar: :any,                 arm64_sonoma:  "f2ffc18ab5772ba01e95c5d45a583c81e7ce330a523a013f7f6065e78067bd8b"
    sha256 cellar: :any,                 arm64_ventura: "e1da42037534cbc2a70a6726f68c0471002f0a9720e91d73ea9d4ee774a09852"
    sha256 cellar: :any,                 ventura:       "1e5240d8a0cbabfbb3ec7a138c0c687726f3b0032c1f9718ec6804c46cfee1b5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d33340b60e78eb12d3c6d7c5dd7ed56fcf4de9f67d6efaa6b434b8f4d65993fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1d4b03ecb4ce292a183b523c9418ed1d032afc95f3f3fc96bcda419a4b6702b4"
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
