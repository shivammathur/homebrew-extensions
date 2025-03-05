# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT74 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.14.0.tgz"
  sha256 "207a87de60e3a9eb7993d2fc1a2ce88f854330ef29d210f552a60eb4cf3db79c"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "6d446916ab150dbd6f4dc3272bc4d99b209011fbd16ae1bd97cdd868eaeabab4"
    sha256 cellar: :any,                 arm64_sonoma:  "a51032920cc52cdfdd20ef6033a7614dd8ff6d67a38078eac898a29c4c09a2d8"
    sha256 cellar: :any,                 arm64_ventura: "4883fbed0fa1401891ba05bc35b8ee6bc6d9bf5fffb55897ef525070a3ec672c"
    sha256 cellar: :any,                 ventura:       "abd7a57b9ed2db2d47cf5b5b2bed78fbeec5695c23e22435cb58196af01fe775"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "04da5b2d6e839c8a93711ddc0504b0776f5272f35ba65c1934a84d7c4ba3b418"
  end

  depends_on "zstd"

  def install
    Dir.chdir "zstd-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-libzstd", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
