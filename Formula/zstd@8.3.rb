# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT83 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.18.0.tgz"
  sha256 "223d0f77eb5a5e73cf5e7a0652dd8fde7ffdcc843e7f30eeb3998283dec847b9"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "7f5fdd70a99c6bbeaa4b0f68e336936dddf935ad8257e12f4347b4bc4275a8a5"
    sha256 cellar: :any, arm64_sequoia: "48813146f84f695ad202919a1cd601fe73fafd5d253d03c62169453ebdc5cac9"
    sha256 cellar: :any, arm64_sonoma:  "d55925fc03f85997b07193f1466e9b0df309239b96480e50f0ebe55f758acfac"
    sha256 cellar: :any, sonoma:        "07e5a5dcb62e9ee01a719a1fa0885acf6cb508a743ddc25babaeb2cbedf1098b"
    sha256 cellar: :any, arm64_linux:   "926c467be9e5f5a7d731e3bcb3ff4191b4bc314da3098a1d2740d9e57eface09"
    sha256 cellar: :any, x86_64_linux:  "65bb7919449d3998252097862b817a58b2a1899eb7f4918b8cee5703b4e78136"
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
