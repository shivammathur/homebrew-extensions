# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT82 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.14.0.tgz"
  sha256 "207a87de60e3a9eb7993d2fc1a2ce88f854330ef29d210f552a60eb4cf3db79c"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "44e7317d80fd864fbfcb4e87a711c09f175f8fe58c14c3e86480a1722e369dfa"
    sha256 cellar: :any,                 arm64_sonoma:  "ff86ab98daf458e3a9adb6af1b5279b5b6bf22933c6b883566310adc5640087b"
    sha256 cellar: :any,                 arm64_ventura: "64e7e0385b7668f64935fbfcff31bbb2da0c76db05fde08f1920578ef8feef14"
    sha256 cellar: :any,                 ventura:       "59ab3715b2058d67bc80443b08b774767f68ffeb2568e967a54a12920598857a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a67f399c61c0b397d59d358c8eb4409bad28c6c4d08008d3a6bc689f7215a6dd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a86052601b9160d3f1800d8582e8f05b2ca3cefae87293bce3902ccef0011db0"
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
