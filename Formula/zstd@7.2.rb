# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT72 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "42fe9efbc8e5647b526c9324c678244d04367b03a3677b88fe2d5eb17271407c"
    sha256 cellar: :any, arm64_sequoia: "8d248b93477f0fe470f87c0b9d70d9cad01059c8ea677ef169697ab938e8018b"
    sha256 cellar: :any, arm64_sonoma:  "205612824e5b55686c8a4870427175f8d297212bc1740f9107c1f5eadc93944b"
    sha256 cellar: :any, sonoma:        "8aa62c2a0dc048a907fca4ff29d0c2246df905a5e53d9f8143df86dd7c4749e8"
    sha256 cellar: :any, arm64_linux:   "dc93a5a070417f0739aab665753c9200a3979f3f7ed3eb28894ac51b180ad82c"
    sha256 cellar: :any, x86_64_linux:  "8e20a726fd9d575d275e1c0c9ef1233f7327ad7cabbe3c234aa26dcdc50aa5c3"
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
