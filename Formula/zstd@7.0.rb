# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT70 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.17.0.tgz"
  sha256 "38cf9e239e72e775bdf01fb5f1abaed76c7ce92e8d3a562a97ef96c9d0446ea0"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "3b39710752dd7aafc657c6fe4bb01cc9915ace65793d40006443d07f1c4605e9"
    sha256 cellar: :any, arm64_sequoia: "6984d191f4def60cedbafa07a0aa62dc6289ec5abef52dda7ad552f64e2a9fe0"
    sha256 cellar: :any, arm64_sonoma:  "1bf422e760689dbf80223f22d595600b3a3abe6c8c4ac4411c2873f419afa6ad"
    sha256 cellar: :any, sonoma:        "0a27f2d68a996a11e87bb789cab1bef6c64d28444118bb5e24f2f1fd0d35bd6d"
    sha256 cellar: :any, arm64_linux:   "4dba0144338d33074a7e9528a3f7190a73714dff2b8ab7a0fbdeade9dd9e67fa"
    sha256 cellar: :any, x86_64_linux:  "8d04e49b0b5c6f9346dd093b6d88fe8a0129c7bb531770f5058416e89eb30090"
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
