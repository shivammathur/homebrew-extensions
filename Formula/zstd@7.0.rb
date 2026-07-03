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
    sha256 cellar: :any, arm64_tahoe:   "33930157508fa44b3d593004f946bc4ba0c169aae260e327b9dceac47eb38b3f"
    sha256 cellar: :any, arm64_sequoia: "873c493aea5cbb693795adb38d450deaf00aea598a364fa21541f00e1230da39"
    sha256 cellar: :any, arm64_sonoma:  "1c91b1189bbdd23d8fef8b2bd68cfd1761386d2e049760f70acfc75cee77d1da"
    sha256 cellar: :any, sonoma:        "05cb13bae4125872e171092b60fd2afc446810f3025dd9a366b79c5eee28ccfb"
    sha256 cellar: :any, arm64_linux:   "61f067ed9d1b2e5e2ac7db06d6e1c35fd9a6b93c08badbb6db5ae5feac09405f"
    sha256 cellar: :any, x86_64_linux:  "5324329bbf296f5f3e5d12f1376d8d269b95a985c42ff2c634e59cef9fedd243"
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
