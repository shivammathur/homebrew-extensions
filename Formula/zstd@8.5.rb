# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT85 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.16.0.tgz"
  sha256 "3d5bfdd1c70b0e3e892461fca3bc74e899322c69404b706fec27af8118d9bf99"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "4d7c220061864729707bc6fdd79b3f3abdfd6fa870bd9b3eefc585071255b5f5"
    sha256 cellar: :any, arm64_sequoia: "fbe5c58ce535e5783ae819969ada83b2b6b451655c5933ce1e6a6117e0c2a8c3"
    sha256 cellar: :any, arm64_sonoma:  "f7b90f759c315ecaa8e3fbb2a20d5e544da4be5c8c523a6bccab34aa0693185c"
    sha256 cellar: :any, sonoma:        "5119ae53c242b8ae581c464bd5412f807c996aed4c4e2847315a85382da83386"
    sha256 cellar: :any, arm64_linux:   "5ec5e00224658a3a9f5d65d28a162649519b1ab16eebb9da001e83f9160d553d"
    sha256 cellar: :any, x86_64_linux:  "06ad1db09ae7c59af0737421572900df14f103e148f1a72f7a145bbd15bde7ad"
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
