# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT72 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.19.1.tgz"
  sha256 "b280d9e9c146586648b0d4c14720220b9e1aaa1a3083a31ab1665784c90601d0"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "0969dc1e3154f339c7ae76dfbd039efcfd2d79631b7508c91f5fca328d63d8bf"
    sha256 cellar: :any, arm64_golden_gate: "1b5a5ba7793855d5d60e8a663ade5c46ff6fc0fb0f95cf3924da1779b5c1e3c9"
    sha256 cellar: :any, arm64_tahoe:       "44fe225f085beac8b50c53cd64a5339bf92e93d5fbca26c46a1bffbc53a948e7"
    sha256 cellar: :any, arm64_sequoia:     "16cccaf7cea64ac6df6a463baab203682011a2c6acc12cd96cc8f1c358358da9"
    sha256 cellar: :any, arm64_linux:       "c948ed67ded55b7d5c78553660427fb14db1653ed4bccd45eeaccc830ccdfc0d"
    sha256 cellar: :any, x86_64_linux:      "606887e9e5a75bd8399793cf4988c1effd7afc5be03c47584b86ce041caabbe3"
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
