# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT73 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "8bb28fd1645e1ead635f9c53f0ee406cfbaf1d95704d93e3829d23d8de499b9e"
    sha256 cellar: :any, arm64_sequoia: "8e90f3ad067aa2cd0618bab200b09324a4ff7fca4e5e46a258d3940eb3e178a8"
    sha256 cellar: :any, arm64_sonoma:  "75a41d95c5bb17f9d4d79523a47fb4dc50cdd62a4e7da835cdd76e352a3c8f69"
    sha256 cellar: :any, sonoma:        "681449ad22bb6ee8f63cb127988b22193d048daaf7358ae1e4778057b85b8300"
    sha256 cellar: :any, arm64_linux:   "9044d52a98fcc506a75542b065d74b21422dcd2fc895e19342eb7891444d62b6"
    sha256 cellar: :any, x86_64_linux:  "faa64d4fa081ccdc40766a22146302cd8451f8a67fb9155e0ec44a83e5df2497"
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
