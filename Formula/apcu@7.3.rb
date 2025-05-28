# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT73 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.24.tgz"
  sha256 "5c28a55b27082c69657e25b7ecf553e2cf6b74ec3fa77d6b76f4fb982e001e43"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "54600d37d9c774b07856fdfbc91530c425c47c37c79d9df6d94abe489acb7d83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f6a8773c42202f592e2bedec96de68fba1b2bb35a6a101f2c90904f9e2792e19"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "bddb75de09f4ff322508a41ece916af7050485e52a2a5ffea220008f749783be"
    sha256 cellar: :any_skip_relocation, ventura:       "dccd2fdb430afc61a508a5b8172984fbf778551bbc196001a558d204dfbd4b50"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "17757a190e645e8defd2a1c94e62edcdc479d786bed9869af7758a03b06c8a12"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8b1629500bb63e69d38c9df789111fbf8ed1a2bb6ffd91f4da1f29ac31319f7c"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
