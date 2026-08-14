# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT84 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "fd6d7c9504ce5c9dfd89fcba25bda7980c79ab937c9827437c4adfc2c64ffa50"
    sha256 cellar: :any, arm64_sequoia: "baa572e14baee6b9b93b1223ae96a2332fe78486689b283368e37a628844331c"
    sha256 cellar: :any, arm64_sonoma:  "22a206d903553f4e9b9c4ac096e815549ad17ee888ea1517e9e216db92ce1c17"
    sha256 cellar: :any, sonoma:        "e4a9eecea716986ce7840511211d63ae67df52fbdeeaa83c8c5b58929eeaa25a"
    sha256 cellar: :any, arm64_linux:   "e34780c30590c08d024be81248c9f8823e895e7858541bce17aa0bc5f8e71c0a"
    sha256 cellar: :any, x86_64_linux:  "f7bd10591befad6bcc30305bd0731a8fb830700b52094179f4fce6faad68d172"
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
