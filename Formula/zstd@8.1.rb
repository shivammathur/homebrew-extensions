# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT81 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "2a5a95214e311d8dd024dbb7ae7b0e51bc549aa1421f871d0345e11951ede94f"
    sha256 cellar: :any, arm64_sequoia: "82fb204f0e144419b12ac4eea1a85c7a7aae8430a53f37830afe0b3afb5febff"
    sha256 cellar: :any, arm64_sonoma:  "4ddb536282ab94dbaa5713a22ae72f329e32d6e484506a9503101094eca3e2e4"
    sha256 cellar: :any, sonoma:        "84e960809ff92b5c8c5a97b3ff3ed4d63ebc958756fc4e5d5ed389f41c49c79e"
    sha256 cellar: :any, arm64_linux:   "830b6593826e1eedbc1a731b6ad12d30e288e3dae658e86c9d416b672c027d41"
    sha256 cellar: :any, x86_64_linux:  "e62a4b95fbe4413c90ea1978c957fff97d2c2e2af5f9d9e283b8c9bd33f84259"
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
