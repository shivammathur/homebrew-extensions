# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT87 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.18.0.tgz"
  sha256 "223d0f77eb5a5e73cf5e7a0652dd8fde7ffdcc843e7f30eeb3998283dec847b9"
  revision 1
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "52c941ea6f1116c8fe60847361df82a819b4830ce361e04607cc35df7007a960"
    sha256 cellar: :any, arm64_tahoe:       "a585379093b63b08d8ca96ee25fb74c9485e4f861a709a318d3f6d4f321071d8"
    sha256 cellar: :any, arm64_sequoia:     "4fc66a72db4789a4d2678a676e66d109d594ed61a3e819ddbb5c9309ea2145b4"
    sha256 cellar: :any, arm64_linux:       "bc6938b097e4a98842ef635fd7b992680a0357e4a2c5021778adf78baf28a06a"
    sha256 cellar: :any, x86_64_linux:      "d816adfa30cabf8f7070eb58dae02f3da2d567c3e8762181460c18f1853e228b"
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
