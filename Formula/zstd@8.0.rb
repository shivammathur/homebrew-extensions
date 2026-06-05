# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT80 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "59c09ea37e38ba85ce6680d2592fbd239d2a6e7ea202dee488d072564d767715"
    sha256 cellar: :any, arm64_sequoia: "cbf08273f001aeacf8c63c1eb5dc4c47d28311ea0ae5754a8a6f749db1b37019"
    sha256 cellar: :any, arm64_sonoma:  "a6dc4da20fbb5420b6607162edf92726301982896b1066f6e41b86b0090cd8c7"
    sha256 cellar: :any, sonoma:        "1654e89c29dc830e173ebe131c674fa09405f0b5f8862b51c2df526a180b9cbb"
    sha256 cellar: :any, arm64_linux:   "d58466a179efe8d5ee7eb7448433664db606885ad4e926bdd6ef2261a8917b7d"
    sha256 cellar: :any, x86_64_linux:  "0ee38dc29f9f836866c68011da8f3062fdf57c463c97ea428b853e2a643521fd"
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
