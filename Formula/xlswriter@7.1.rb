# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT71 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.7.tgz"
  sha256 "3736aab69aea238dc80fbb385fcb2a878a78fa9460551cf633e119f3854086ef"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "63bb77e70ba5e4bc0b19bea35e1e90d18348d3918596b70886da7dc01e0faf6f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "6b1784502ca7bbfb074ce04f4b60214aa05092202c56333b9507a5191748dd9e"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "746e8d2e6e47e7c1ffe3d862aadb314774d9a1ffa8fba98ad540f52cb224097c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "028a2b2aa81c10fb5cc47160066e4847bef865e11090a0ece6226977de814652"
    sha256 cellar: :any_skip_relocation, ventura:        "5106ad9ed8e5cd7667e2487166529af4d0eef052abb45299aeeac41e07e66368"
    sha256 cellar: :any_skip_relocation, monterey:       "68c126d99d9c2aa99174d71c822b0ad27103d789235f46256a32927ec28e4bb7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "82a40fc6e12aa24f115ad9891b62e41acf4aeaf92f65f0a39f9968c8af17d22c"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
