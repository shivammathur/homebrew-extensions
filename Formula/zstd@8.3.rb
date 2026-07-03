# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT83 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "f379fbbaf65ce2bbd1b0e111755134a1c3682c2c4394ddd5c8b73a6faefeaf4f"
    sha256 cellar: :any, arm64_sequoia: "0a562efcff1a537c3228f0fc0f5e1f45c3238f4b609eb89084c71322d32cef94"
    sha256 cellar: :any, arm64_sonoma:  "4c2fbfaa8cbea6a0c364b0dc7f8b43e447f0902c23a2ec86fb2ce3230ca657de"
    sha256 cellar: :any, sonoma:        "5ebe7bd3b15feb833d92ca8c624a2d42cb9aaf16bf50a840c0d2e5c9311067c6"
    sha256 cellar: :any, arm64_linux:   "fc491c2268624846f0fde2cb7dbfe473efc832df22ded586ecc6b77053c40629"
    sha256 cellar: :any, x86_64_linux:  "9b8cd948d0d0eac9bf762f05295ec72b660e6400fea835d3fdd3a7160c75b4fa"
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
