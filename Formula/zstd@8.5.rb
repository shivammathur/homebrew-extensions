# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "3bf44d6d6475d1782fb103ce07fed50df7a02bb0210a03e3bc3fe7833dbce0e2"
    sha256 cellar: :any, arm64_sequoia: "c2b4a99792e6e425893e6d6ef18dc567027fa38af5e0e1b1fb84e70acf288e6a"
    sha256 cellar: :any, arm64_sonoma:  "618b4249fa50ff10f8e75b21e52706a0b307c67d4aecd851a16cf3b5af57db3a"
    sha256 cellar: :any, sonoma:        "8afa7c7406d18ddf4429fd0b3f079988b3bcacf2f5572ea3290fda8ec2e4d185"
    sha256 cellar: :any, arm64_linux:   "1a6c42feea14432c8e3638955cd52a47f7ac1f490d86044112e5d9c00a9b0b4e"
    sha256 cellar: :any, x86_64_linux:  "08fce541da43742c0df611fb944fbc8a7407b058c533e41c27cd5cdb76b11c34"
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
