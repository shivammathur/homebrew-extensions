# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT72 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.12.tar.gz"
  sha256 "de41f25b7d3cf707332c0069ad2a7541f0265b6689de5e99da3c2cab4bf5465e"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/igbinary@7.2-3.2.12"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "abd24894641057a78d2e2ad0be0211f0a970bd4cdfdd9caec7a9302713d7c346"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "106f15980d719d81ef3fcc0608a6fdaa8c2bb6c7fcbfccaca441dc5a058a2e91"
    sha256 cellar: :any_skip_relocation, monterey:       "42e87c621956d94d11141bdaf4cdf7baabb15da957c339de1cca65471c49f41f"
    sha256 cellar: :any_skip_relocation, big_sur:        "54f10e9db49a8d41dce7739e654daab0d61c0eabc09dfa2798ac45a22e6f84b5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6b640446284612848bc6ed9357ad24bc7e46205fbf16d9a8d88357057935def4"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
