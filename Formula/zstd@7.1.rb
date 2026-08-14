# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT71 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "066a0b5f9cdda3e4cc62a15563c22a770be7ecdec4579457799eb65d15adeb4f"
    sha256 cellar: :any, arm64_sequoia: "8c5d2c1b7990b28e5ca425389aea68e1289138be6842f1be3642d3947cf53888"
    sha256 cellar: :any, arm64_sonoma:  "a9d4bfbe7c28ae36a591fdd8eb29c526164deb678c73eebffb53eb80265ba187"
    sha256 cellar: :any, sonoma:        "5172623fe3bbeeb3e550a136a4c969e8c8cb23cbcb5a18ee17c3d411dced369e"
    sha256 cellar: :any, arm64_linux:   "6bf6806d261601971b7c31d9012e8e6d0ceaf62ba89a648b6c064a49a0641ff7"
    sha256 cellar: :any, x86_64_linux:  "a5f0a0a1cf923e38287ec3eb98c79423d829aa85a777068ae476ef5c25a9e968"
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
