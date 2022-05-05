# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT82 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.7.tar.gz"
  sha256 "21863908348f90a8a895c8e92e0ec83c9cf9faffcfd70118b06fe2dca30eaa96"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b7caa893146dca1feea771bf997fa9a3500d341a6099329391b9c54ca59795c6"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "db585fd2f2c95e75ebd80d2698a59fa976121814eae266752a2b9ec0d1a5dcb8"
    sha256 cellar: :any_skip_relocation, monterey:       "2535bfd919fc2ad4f59e390f5f95a69c671e16b933be29fdd7ccedfdb1a55947"
    sha256 cellar: :any_skip_relocation, big_sur:        "ae911ef151c4b98f1a8b4f5380a35fe9cbef24823dcc2217bc9a193031008eea"
    sha256 cellar: :any_skip_relocation, catalina:       "6b7e0a120fa99abe9c61c345044c41954fa802645bf30218ff81effa7cff9973"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4a1c80759bf86a4d3cfeb09e26dffd01f217dc77b7ed8782930fbe7c1e3c0724"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
